Return-Path: <netdev+bounces-118357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8509515E9
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F800B20F03
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C211913B2A9;
	Wed, 14 Aug 2024 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j2D1XkC5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C638488;
	Wed, 14 Aug 2024 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622227; cv=fail; b=ElcSr77UeO2U7aCN15ohq3tVo5T/n40m5lXngRIRhW1K+uY8aKu3A/WeYVEIDI74N1rWAUJHLN4JvaqVyyGsc+RLCEfVIuxmOPdSFZhsO+hru6eaZIB2vNO3uT3elCSystxhW8z9ABvfdy0y/LqDgr1VOcD2/SRRbwdFUFaUKTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622227; c=relaxed/simple;
	bh=Ucun0BPlZyM1BTFJrCYB/1gcvJxqAYlt8yCnUxqXZHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xs/4vWxZTPpRqkJilRpIDIWOQ/LjfSpI/T4El0aO/rsACgSkRasju9lSdf6JBW+Udluq1HEXeivaNxmWc27Wl+5iGGnBA9DAt+xd9boNzAMNR4/s1hpNpUOg4+pY21c1b0kjCwicwo8yhPjKdilP5oeEVwzloYARX0haDHokbgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j2D1XkC5; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpI+ZOgEHNE8kkSvJEkZrHuF1v/ObbASosiRmyaWn/fUL/+bOACRUKfQJS3cA6PxO3ZougQRMukFXPfwYeNdDX3qisbq4wvg+1EEunZaY2Dah60PmS1i/M3pY0sKQzcqYMGe793zdQHCaBsDYGXsfGqfQG9QZpgbk+6Q5zimiwGyNVWouoCvEl5fgXdCl9kO/zHN6eJM28qdcf2T513I/QJ16r2YigvAMVQiTSml56uLHDPWXefgfN9731rMSX6hRLAfCVPeOfsCgVCbTNc0V/CnGb4gJ3m62IV8UNc4MVWGjjlqNwSXDWxbFgJ6TC+GoQa4Hrl8wH17ehjSfYUtJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cot9GWAOdh6X1fyBB4SeUQ1vIBEsNCRLEh+bbTPQHxU=;
 b=pWhlPaaDyc5cnr39jxA7Krcv5rPXQwwWnGe+F55YzI5kvhVxdMIyfLI3gVty0ZDKCHEhWFPYnJe2HmEkcw3uePb5lcVAwV3W+L5HT/K2nCtOskn4AXQBgkIYfincqHVDebeOFMEuU/tQOtqdnpMYGxSVjDUzW9pU2gYKkNFK16JyGnUto4h21LT741evBikvvzvWiGBCA4+fj3iM1JM6nUgN9Ya75f84ykUxdUUnWPTCh45M0fKgQ1Q8yylFixKNrHLNrnFYOUDpxpSC6un+5bAFmxcsxD4VHzVa0XWyGIHIJhhFHl4htM1lt7cborVp9dxYRVqrcZsKj/fAz9Ws/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cot9GWAOdh6X1fyBB4SeUQ1vIBEsNCRLEh+bbTPQHxU=;
 b=j2D1XkC5jA7GDX9zxcWPxtuw8xmYExfNMLh6Sq1xA7LYhH96ygeGHXI091cmM1trxuPkD6V8s5/+2nMh4jo/B3oGXwc847GlpKIvtxvBb+UHpUOksboaigRdY1ly83yOQvDijVZGzMtcNWZ4DQhGRlCHSskqGK5nD7wm4/AZyzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 07:57:02 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 07:57:02 +0000
Message-ID: <5d8f8771-8e43-6559-c510-0b8b26171c05@amd.com>
Date: Wed, 14 Aug 2024 08:56:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 02/15] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-3-alejandro.lucero-palau@amd.com>
 <20240804181529.00004aa9@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804181529.00004aa9@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 9056ac50-d4f6-42c0-9074-08dcbc36aed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1drWDkrRExpcHhldUM1bk5xa1FiUTVZMTVxcmZlK2V2ZlRMVmx0dmphUUts?=
 =?utf-8?B?TTViSWdvRFhYbEErbXd1bFhJWEZUYTQ1dFRKRnNhNzgwRnlOUWdsek1CS3h2?=
 =?utf-8?B?dXlmZzhjKzd0OFhJWGNRd0lGdmcybHd1TmVYd25uckhFV08yTnRNcUxTSFVW?=
 =?utf-8?B?TUVwdVdTQ3p4UjB2eWVlS2JZNGdmMU5KK2QzdXZ1R2VlbWdYOExOZi82QVU0?=
 =?utf-8?B?T0dCVHRqb3BSOEhFbm1lT2JuWkhWeVp4TmdEYnRTbVRPSVJveFpWV2lPdWZI?=
 =?utf-8?B?M3IyOWhWeGMxdGI1SG5LWDYwZnl6dlVZQjhJNnpHRzRnQjBTT3ZOTDFteEdJ?=
 =?utf-8?B?dFQ0ODhGb2pReUpic0wybDBwZmJzRTJrWUkyRzJpY2hYeCsvKzJHTzE5eGxi?=
 =?utf-8?B?T3dLM0pzbmw1NUpITlkwaTFQU0lTQXZUOFIrQTd1bHdWTjY2N0ZSVmpMaldR?=
 =?utf-8?B?R0p3WVpBZVo1d2hRY0wrRHZZdGk1NEllTWxIQjVRd3FxKzMxcHJHdzlXNWNk?=
 =?utf-8?B?d0ViYnhWSVJ1TzZzWElLUHpzYnR5RTVtUlN1WS93ek1Makszd1lUNjNQY1lW?=
 =?utf-8?B?a1ZsdTJ1Zjgwb1VhOG0wMldKZUpueC8vZkIvNi83N1RyeksxMnM0QnI1eGYx?=
 =?utf-8?B?MnZyM2RRTHN2bCs2aDRlTC93SUZjVmhwV1VZdk9OQytHVkFrb3VjdkVIR3JY?=
 =?utf-8?B?YzJsVTRHOGVUc3NrZ1hRckZ4QjNSS2ZLYVRMT3c3dnFZdUtkRDIzaGpsWXZa?=
 =?utf-8?B?S0lnekJaby8xWHJNTytReWhzdXRpY1ZhclYyYURYWFJmamg0NlluVzZ2ZHRu?=
 =?utf-8?B?NFNHMksvR2xvYUMvaEtzV2txSStvNGdsalh4OEpwNFFJSk00TXJ3YmtXci9H?=
 =?utf-8?B?blhQblFlRXQ3QlY2RUdlSnBta3ltUlB5bkJVNDZLbWRlQU4rNjRsQ3JVYmF6?=
 =?utf-8?B?b3VocGprdlNTcjNrYVhCWDM1d0Y5UU5HWVoveEVXZUpyUEhkMWFqaW84b3Zp?=
 =?utf-8?B?TXc3YmwxTytwdDJjTVZsKzhldmlDZTFtSktmY1A3OUtvYXhua0ZNSEpjbjl0?=
 =?utf-8?B?VDFUcE0vSlRGNWxSRXZUbll2bHNkbG5iSUJpZmFOaTNzWmdQUEpmS0VQMTBm?=
 =?utf-8?B?RElFdjc1WGNhTW83KzZLaVhPbExRQmxVWlRMdzF5ZVZ2ZDZOdUtUS3A5V0JR?=
 =?utf-8?B?N3dSS2t3KzFyYW9Id0tqT0Q1RmdaUlBERTlNdzF3YXRiL0ZvbFpoSWhCSUpQ?=
 =?utf-8?B?eFB1ZU5vWm9oRldOaTF2TW9hOE9ZckdiUnljZmRvczZhVkMrdG82OVdiZ0kx?=
 =?utf-8?B?eDYybUtsbmpzQTJqSzV6dWlMemY1TGZKR2hJc1RnTnZWY3dxZVhKMWJ0dU1Z?=
 =?utf-8?B?ME44L2J2SlpCN3BZNXZtR0RoRGxKMHM2V0hKbEFXV3dwZ1FPdEJxLzI1SlF4?=
 =?utf-8?B?T3pDNzJJbFBwRGtzc2xGS3o4aVpOc2JIM2k1SGlkSndtL0M5MmhoZmRDaURP?=
 =?utf-8?B?NXF6VDdIM2x4VzY1U2pCUEc1L2RnTlJJNmFuSlFzcWVsNlpGM09vbi95S3oy?=
 =?utf-8?B?b3lXbk1kLzNtazV4K3FxeFlsM3lWeUtHS1hLcVRmdkRFNnNSaGxCTWdJdDE1?=
 =?utf-8?B?bS9vVkFKaU5oV0hSK1U2Y0QwK0EzODdUMU41MzgrSkdYY3AzVGZMdytIL29H?=
 =?utf-8?B?MGtxQ3gzaDUvUW1xcDcvVjZSY3E2aFZCUVZRWEJiTC9mcFAweHh4eXBVYXoy?=
 =?utf-8?B?bmFRaGE0TnJQSjlEd2lRVWVZY0hqRTJUR2lZNGFLWkhROUZOL1V0UFRITlJG?=
 =?utf-8?B?L2RYT0d6U0NQdHhRa0FzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um5mK3NFYmZYdGVoRW81M29lRWRFVDB3ODAyQW9OL0pQeGE5VkI1T2ZHOXY1?=
 =?utf-8?B?cXBjOXFyLytPNkVNREl0L0Y5cXh6WTl3d3RHUklCQXBIVnI2UmFORWRlaDBB?=
 =?utf-8?B?NktMaEl0OE9MajdJT0kvbEI3a3F4OUVKY1ZZT1prTzQ5dkVYZzFmOExBTVJv?=
 =?utf-8?B?bXJjUWt2TjNkZ3oyczlmYnhVcXNKZEk4M0V6MkxRVVJUaDZMYXJZZmNoblk3?=
 =?utf-8?B?Wk85c0JKTXM4OU5BWkM0TGdFRktCeHVnK3pCVFZ4TEhWYW5QbWowTlBmNnFx?=
 =?utf-8?B?UUl5WGFVSmIzUjdPRHdjQnk2bU1UaGs3YlJ1Z1hMSkZ0SEV1WDFhNHZRaUJ4?=
 =?utf-8?B?cHhIR3F3cGx6OVIyb0NOcUdlQ2pYY2lLK0s4OHVaL2FIR2k5THF6REJqM2Ja?=
 =?utf-8?B?K0dHQkpyWEpXNEdrTlovLy9Td0xGQjl2dk9XeGpBSmo0NHZIUkdhWVkybStl?=
 =?utf-8?B?OHhsUXRwV3lmb1ZSN000bFV6TzErMUtlcFpEYTFJUWVlU2dyQmtMS1IvRjgz?=
 =?utf-8?B?bXk2Yy9zWmlHMFpFVXMvTVFKc1E0SVM2WllCOXAzakFPSmZYVjJiZGRYVHBi?=
 =?utf-8?B?SzVlR3RDS3RZT1BDS2VqZVI4QXA0aXRocUh2aFVqa0VCdXR0RmgzckRUeUJL?=
 =?utf-8?B?RmVJbWE1QWg3VTFRUWdZMnQ4UUd2OXVQS2pKdWhsT0ZWKzZpelp5bGV5bWsx?=
 =?utf-8?B?UXVzVFRiMVhTS3NhK2Z0WVFXL3dIMFY5dGpuOElncWwyMGNRWmI3dHJzM0dt?=
 =?utf-8?B?ZXg5MlFzbm9QbjFKaW9MazMvaWZ1dlM3NklMZlNYV2NZelZlK2pXSE4wZzdj?=
 =?utf-8?B?V3NOTzh4Zk5nYXdCcHl1MFhhdHlhT2RpTFZOWFFHbTRuZ0FwTVlJaTMxNHRi?=
 =?utf-8?B?d2t5K0g1c2pSQ0ExS1FKeGRSemd2SkpET2lvWlBuVnFPVFdRVjBDRllsRTI4?=
 =?utf-8?B?aDd4VEloUEF0STlxV3FNVHdwY0NPbXdVeU43eTlNOWc3YWFyTHluNUQ1akZS?=
 =?utf-8?B?Zi9DWnRDWS9UZkFpRFl6OTk4VzVFVm9HWjVHWlMxMFI4Lzk4dU9rMWRCb1Rm?=
 =?utf-8?B?R25XeTNFSTN1eUhhMTVZMmVLRDNqYTJmUTBQd0JaMWtKL0RqYXpSY1JlMEIy?=
 =?utf-8?B?OU0wVjhEQW1HSldSRFZsRVp2SUZ2OUZkSmp2SkZvS0YxQkpMUEVwYWRXb0Fh?=
 =?utf-8?B?VE8xb3BHNVVOSk1YOHNjMkV4N3dRRi9DQmo1NXEyOGZWOXJmRTFYYmdrbEVE?=
 =?utf-8?B?dVlRNUszNE5hamxEbDN2cFQ3V3RhVHJIZlpmN2F4V3ZnQWF3L0xOdzFPK2lP?=
 =?utf-8?B?MXJpQWdUZHUzYTErQnlwdENLNjVDZFlpZGpTWmxwUUV1Y3pTRm1ZNnM5V2Z1?=
 =?utf-8?B?aFBuWlRueUlzQkpQc1dhWWcreWREWFhsdk9HaER0TDJJOWN2dVNybTBxRkVz?=
 =?utf-8?B?MXdMb1h2V2ltNXl6Z1g1VFpaczVQQm04eXBRTExBTU9IVEFzcEpiMVlYZThP?=
 =?utf-8?B?ZWVQQTNDV01uVjErMUFqdXg1UXRtZFZvczd2NGdrMEdDMjVvZ0Q0c1hZUU9B?=
 =?utf-8?B?ZGtzbHNmUDN1RVp5RFVkeDR3QTRLUjU5MTZ2NVVhYVhTNkhmT3NRaVVjTmh1?=
 =?utf-8?B?WnJvUHpYT2VxV3o0UmVKMjVtWlNhSldrdytkRVovN21WWGJqU0dzQUY0Nm5s?=
 =?utf-8?B?TVI3Q0hSMXFCVytzbjI5Ym5QMHNOMlk0bnZ3OHFIbHJFTWVnaFllUHBDSGhK?=
 =?utf-8?B?dElWQW9nbGdHQUhyaWtrM3lMNmliSkpJVndPZ0UxMXZXTllVeGpiazBhRDVU?=
 =?utf-8?B?cXR2anh6UWhMRFgwQUhiLzhvRmdqZ0hydGZNbFlrM053Q3Fqb0syaGFLeXF0?=
 =?utf-8?B?N3h0SXg3RXZhQnRQM09TVlczTm5ReEQvTENyVlY0dC8xWk1INFJFdC9SRmZ6?=
 =?utf-8?B?a1pDYTVjOFBFWGtHRktET3IzbkptdkpsckdIZFZld05qTjYzOVB1MkNXKzUv?=
 =?utf-8?B?a3V6V3FrOFhFdzJvaHdudHJ0WmxieG9lRFk2VndyK0ltdmttQVlUZnR4bklQ?=
 =?utf-8?B?Qi9CUjVyekFDeTdmcjRXUHJSbUl4cW1rbXQ4RVJHMGlOM1JKZVM5cEh0cDY3?=
 =?utf-8?Q?BczAf1i8ciDo+o1MoQ1i2c4c6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9056ac50-d4f6-42c0-9074-08dcbc36aed2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 07:57:02.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bYM0t5uBizdrB09cw8xakt7P1RiW4lG8+WZSvA50BOHNvMvGY8mLKZ0IjkhiGXluwQdJLnFSia9ydf+fkuo5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433


On 8/4/24 18:15, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 18:28:22 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device initialising the opaque
>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/pci.c                  | 28 ++++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.c |  3 +++
>>   include/linux/cxl_accel_mem.h      |  1 +
>>   3 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index e53646e9f2fb..b34d6259faf4 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/aer.h>
>>   #include <linux/io.h>
>> +#include <linux/cxl_accel_mem.h>
>>   #include "cxlmem.h"
>>   #include "cxlpci.h"
>>   #include "cxl.h"
>> @@ -521,6 +522,33 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   	return cxl_setup_regs(map);
>>   }
>>   
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_register_map map;
>> +	int rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxlds->reg_map);
>> +	if (rc)
>> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> Not fatal?  If we think it will happen on real devices, then dev_warn
> is too strong.


This is more complex than what it seems, and it is not properly handled 
with the current code.

I will cover it in another patch in more detail, but the fact is those 
calls to cxl_pci_setup_regs need to be handled better, because Type2 has 
some of these registers as optional.


>> +
>> +	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +	if (rc)
>> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> pci_err() or similar would make sense here as we have asked for something
> that isn't happening. Specification says this is mandatory so
> definitely smells like a fatal error to me.
>
>
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
>> +
>>   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>   {
>>   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 4554dd7cca76..10c4fb915278 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -47,6 +47,9 @@ void efx_cxl_init(struct efx_nic *efx)
>>   
>>   	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>>   	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
>> +
>> +	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds))
>> +		pci_info(pci_dev, "CXL accel setup regs failed");
> Handle errors fully. That is report them  up to the caller.
>
>>   }
>>   
>>   
>> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
>> index daf46d41f59c..ca7af4a9cefc 100644
>> --- a/include/linux/cxl_accel_mem.h
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -19,4 +19,5 @@ void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
>>   void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
>>   void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   			    enum accel_resource);
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>   #endif

