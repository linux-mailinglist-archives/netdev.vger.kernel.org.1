Return-Path: <netdev+bounces-183734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15D4A91BB0
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A663BCA4E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054D243378;
	Thu, 17 Apr 2025 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nbfyDb7m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A5242927;
	Thu, 17 Apr 2025 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744891870; cv=fail; b=J9xhNFOliOlvOOKzsMQdDNHOFkP7NMEryVDAeOB3t+LwmXCb3R1W2mr++tSqRPy51g+vY8FXtQ6FDLND4ndorICTtGq57PCEKuZmda5GCPz7UZC97fGGiCI2dPPGBxMyrW0a0B9+AGoFjosYtC+INucrTHKxUFiNBldP6jIDz+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744891870; c=relaxed/simple;
	bh=xmFFzCopsJzAA0zWPlYEgzD3T4Fm28xsHlG+HegWzFY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ogfwUdCGZw8rm9JKTZlEeJvfYGX8V+eIGeqdR0aCUGOAn/bZmwNgSJqYdf4tSgDYDA46iitRePWATgwCrDpJMZzZjX21Rhgs09sLJ3QafXcm18Ytfvvb3RKKvgU8g5QSLXZ3punOgkXuKYo3P0X4MA31CbhgcFqOhMdeD/WTqrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nbfyDb7m; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgCfJayy4GnI7ATt+cONRxiQpscGT4MJND+5naHDnLNCECQvrQWpygsHB1ojrMxGXyIYphVKtotONupq3Dtaw1I7xng5poZw1skVP3Z8ULHzihdQQEZK+v2fwu5sqMmlH4dGAbiJyzZAIc+Hy5S6Qw5G5rjpKLIQ/k1OtW6bya5IkDLWKObtDZE3MfRBctS/EwanWma/tvAjacRWMIMFhjEh49g9KplB2kmpGyEsedNAaMv7yNzMPHUBgigbnMWrq4G5uigm6G9E92yShFssRuBEX6nrafj5BV5cvTdTBqZX/6vKw/A0VYvlhQK/Lgn8upTxO6VANA0ulmxuoQIW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2bgpjvf/eVQLdsFGez/SRHfW9I/v4RqTK09MIOQJpM=;
 b=emS6x9IU4jpjYmSH+1GC144RW0dVijuT9+/cl6W6D7cRbJU7ka8xbaSKXtFSKRtye26xAS7MLTr51nvxqMvNL1YzxfOrRzPgssSfnFJF9Q5/mE5XZ9pU/6N0p3aqXQcqQm15QjUq4ataKXMYik1+4ocFHVZuAncPsSmN7SBVbQUuc+N+xBEj0YuDqKn1Y9vXYLe7Sh6Opd/EJH4HPv74S2OiexcPIAufBUPcDxeSotlXNB4cFceVDnQht0E+7hhiNN+dnd3+QsNLPme/fR7RK5SKZ/chSbYgyT/dTvpRu65GD50/dt9BAf5XwBVkJIPTg14iTBc/DgoDILEq53KwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2bgpjvf/eVQLdsFGez/SRHfW9I/v4RqTK09MIOQJpM=;
 b=nbfyDb7mWujXCDn9YoIzajC+cpvrwdEegr141dW8fMsmTb+rIK0DUOs8faanvwjhrGa3Q+8Q6m0UgMZi3MbnZcMfupyNQ04Nnt763WABymPzQwxnotwu3yT2nTwEYmSBm/D/RZXWbCTg+LLGhOuWquQpVBpMCY51nPuYzTEwBjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 12:11:05 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 12:11:05 +0000
Message-ID: <eb5f16f8-607a-4c71-8f81-5cdb4ff73a75@amd.com>
Date: Thu, 17 Apr 2025 13:11:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 11/22] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
 <20250414151336.3852990-12-alejandro.lucero-palau@amd.com>
 <20250415145016.00003725@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250415145016.00003725@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: 5399659e-3db6-4dc4-d005-08dd7da8ed4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkdmQWVJeUNwN2FTMmVjeStNWXJLT01yeUVtcGljQmZpcEtsZ1lMT2xMbmF4?=
 =?utf-8?B?YmtXZkJGcTVrWHlWejY3Ylh0SDVhSFR3cWp3UGc3WHlVRmxHcHBIczJtQ05S?=
 =?utf-8?B?V08vdCtHQWNQdnJnMklzTmVFaHJxWmNuVHBuQklRV1NZK1FpKzN2UEV3c0dM?=
 =?utf-8?B?N1dyWllNRG91bHVuajU2T2xvR1pkTmhQSU1UN2pBa3lpYjhybS8yL2ZTWWNB?=
 =?utf-8?B?R240dHA4SmVUS1hkUDZEaUNVUXZoY0Z1MFAzT0FMc2pEVnErVXhzQjJ1SjJn?=
 =?utf-8?B?RFhBMkwrTmxMOUtIUWdFUlRQK3JlVXdLaTVXK2ZUS2ZwNmtXK2ZKdWNLVWlJ?=
 =?utf-8?B?U1B0VVAwcTV6MHFUUStOKzlhdUZYYWxVWG9sSnVCQVMwT1dtTm1mNXk2NE5o?=
 =?utf-8?B?Mk1KUUFmc2JQdytueWUwYTJNaGg1V25iOGZyNE5QK1Y4Y0tQN0VxTkZxM0hR?=
 =?utf-8?B?bVJIZ05mamkzQ3ZWdmVIMHpaMmplT01ReUtSbDdIeWR3RjZ6MWpHSzMrK1I4?=
 =?utf-8?B?dWNncDRIQVdIZ2h2d2R3QnBSc3BnVkRJKzN6N3NES0xDZlVaOHY0WXVjZndS?=
 =?utf-8?B?RlptU01ZVXVSOVpQUG1MQjVDWWlFSTJ6QVFZMnd0emFlYXBvREo1L2hhRFdS?=
 =?utf-8?B?UFdtcHVRSXdCcmd1NUMxdEs3bThPY2FvWFNiNXZEeFBpSzNwYTRFV1BOcUpQ?=
 =?utf-8?B?cGJ1cytwSHBYVnVOc0NKV0h4UjJkZDlWcUNjZWdLYk1mbW1ud1MrRmtMQ1hB?=
 =?utf-8?B?NFVuSDlSRGpvczQ1YjcrWmJkanRHMEE4L3kwTVpYZXJhSWl0NVk1Rm04cjls?=
 =?utf-8?B?VHMrVy9qeURMbUxrQVRJdStKWlViby9GbHFpMW9WeWhEbmRjNHV0T2dzYnlm?=
 =?utf-8?B?d091QjcwQ0Z3dFhibHVHbytabFZKcThacjhxVGFPZ0EvSFI5eFpZQnROOTE5?=
 =?utf-8?B?Sk5VN3NQZG9KQzc4VlNSK01NU3QzRm91bXh4aUluRW4yMU82VmxIcWE2Zmlw?=
 =?utf-8?B?Z2Q1TkttZUZuMEV6MlRNUnVBcTNwQUkyMUFnc01lb1hqalBsZmR5SlkybXNL?=
 =?utf-8?B?UEE4cU9UbWdtVzBEd3laWGdBUGJJMEcxY05ncTh0Z1cxSE5TSkNJZHd6WWNr?=
 =?utf-8?B?b3R6a3RWMDFYbWpMQTlrMDJCY3VhS1VzbzhNZk5RTHd6cTBVUTNXK1AyS01J?=
 =?utf-8?B?WUh6SEtvY2YxcVNsVlBYdDJTdTRHMys1UGxqR1lsZVBZd0dMbVZRRkVrd1JX?=
 =?utf-8?B?SEJRVno2VXpkSlF2cnpyd1oxR1ZHeGhtVU5kYk91bDgwTFlMdkUrM0VITW9D?=
 =?utf-8?B?djBKL1F2UWR5VjZLR1h6cXJBbXRUbCs2N2cvYk9aVW0wMlU2VFU0ZFl2dFcv?=
 =?utf-8?B?NDEwWGF1eWpaS0VzR1l3L1ZtbkM2YU9tS3NvcjE3MStRQmhNb3N2V0FoQllE?=
 =?utf-8?B?ZXpRRm05M2JYdldhRFNSbDFkZzVsNVRVZ3ZQVDRjSHdZdDVlQkREbzhidldw?=
 =?utf-8?B?VjNLSE5vaFRqTEJPWk5rYmJMUGcvWXpQM3ZVYmprdVY3SWE2Z3AxaFlyZVVN?=
 =?utf-8?B?WUxrd1laLzUrVlptc2hxZGNBZHY4OE8zVmFQY2RueUd3MEFYVUY1TU1qOWtL?=
 =?utf-8?B?UDRMRTBJSlJvQy9SVWxwREk4TmgvSnAzand2Tk1YSmE5MGNYalF0bnYveWxy?=
 =?utf-8?B?MDM0SXArTVpaMTU2UFdyV0JkYVF4SVQvWGYyeWlVa1FldThKd2FNUGdDT2hL?=
 =?utf-8?B?YldCQlpqWlpQS2ZRWWwrd2pMSU1JTklUTVloQWo4dEwxd3RtZndmT2JiTjhh?=
 =?utf-8?B?Nm96N1A4czRWZ3VpYnhvaDRkM08rSmVqTWEvQzFTNzlpWC9HM3o0a1hENmxB?=
 =?utf-8?B?dVZVVksrSlNjOEs3a05KY0VVc25ibURaQW9jWjdocGo3SkdsSEloQVBwLy9N?=
 =?utf-8?Q?/APWmCrjPag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SStYeGtpdjJvb3lUc0tvKzZnMVU3bFN4MjN5R3phaGZYTVZ2dUJXOERWS21p?=
 =?utf-8?B?TGdlclp2T2MxTFQyRXU4UzllQ1JGN24vazJmTmthT1BBMjJNQk1XOGZMRjRM?=
 =?utf-8?B?MDJTV0NuUHdRbTFqWnk2MVEyVXlGeFRPR2dmZklaSk1nWTlrZFpJdUwrelZK?=
 =?utf-8?B?VDh5MHpxbkR2alI3RHJXRVdobGhNc0c5VER3ajlrOUNRVThnUk01aXZJbkdI?=
 =?utf-8?B?dStLMlIvb0ZKaDJKUlUwK2ZDZnRSdGFLcG9iNzZkeVFncytFRnA5MVR2VW9T?=
 =?utf-8?B?M3Vod2UyNVFWdDlkamZaM0NLdEhUY1Rtbm9WS2Y5dFlmWnZheHFOalV6S1E3?=
 =?utf-8?B?YkNoWk9oc21yVndqclN2WlhZL21JTnRRVzkwYWlwWWVTeklXeGpRaW5tbEhD?=
 =?utf-8?B?N1J3U05BZXBUYi9EQVNXQWxiRDArOVVZQlVmMlBQaGk1RUpRZ0JrOFdZT3ps?=
 =?utf-8?B?YWRVZ0VIYW1qUGYzK0k5R0RpY2tneG1JVXBtR1pLdkZGZVREVFBySHZxL2xj?=
 =?utf-8?B?cFhiTldWdFpnMGpmeXEvTlpOY25ESHVkSHpZZGVNY2xESFZtV2pTS1o2VW9m?=
 =?utf-8?B?cTJHVTZKdnlLOXlRUW1PNUNaWm9Tak84R2pqcnRjNWl0YWl2b1pnalVlQ2xi?=
 =?utf-8?B?dVdFVGp1SW5aT2lQZzErcGgvTWZ2WWdTaGgyaCtacjBMWExyNTVVU3VIRUo4?=
 =?utf-8?B?Yjl0TzdsQlc0WVdxS0N2N1BKQTBadHdNWXp6eE42Uk01aHZMNDM2ZUtMODFV?=
 =?utf-8?B?OHVYU1RoNmFRbHRvZjF5WUJWL2VORFNEWEZFeU8xbm1LQVpZcTFZNnVpblor?=
 =?utf-8?B?ZTg1L0JNQVkrSmhyTjdxSVB4dkYwQlNLVHpJelVFTGlleTlreENMTHlmQ3RI?=
 =?utf-8?B?MDRiTXZMbGtUeEZBaGpDbDZ6bVJhcmNQeFVlVG5sSmdoQllpVmpOaGltbDN2?=
 =?utf-8?B?eVVueSsxeFRRZUMvampyM0VTZDJUdU5EUGRhL0VXYzRKeTVrMWxaRmJtTEk5?=
 =?utf-8?B?ZlU0akpNZjVSUHBJSHkzZnNINm9tMjVNeFgxUXpNK2FrTmpFcUNYa25WSU8r?=
 =?utf-8?B?Q2w4dm9kWXVnSjNkMFA4ck9UVUkyK3RJT0lLS0hHQm1IaytUNS8rRzViSjZL?=
 =?utf-8?B?V1Q4clJDUFpmaFhndXM4SVBuYktpbnl2ZUh6RzB3dlliblk4NDFPdGtmanVE?=
 =?utf-8?B?ekpFNmsxSUdoOW8yUytIYUdjMXRzRWwvS1k5TDAvRG5YeHdGc25nSTRnQkpn?=
 =?utf-8?B?ek1KOU9XWEljektOanlFdW1QNUd1UTJBbitnVU42RXpDei9nd2FkcWVaM1BP?=
 =?utf-8?B?ZVUxdzNOTCtWTEQzL3UzdjZVWjNIOE9qU0RlYjVCTHZ3ODB2N1R2RGNiMTUr?=
 =?utf-8?B?SGNSaURSdWFCcUJKb1JBYkR4b3Nxc3A3NmVlT0o4eHh0Qk5qVXV6VGhCbjAy?=
 =?utf-8?B?bFJqU0ZJU2dkUGRtd09yaWpCOWZPSnB0UW45N1owRFNtaHJEL3VyL0dRRE8w?=
 =?utf-8?B?Umc3dXBEdVNWOVNBRUtkdkcvRjBiL2Z5bTU5eW9XMzBLNHhSbnNUZUkyT3BV?=
 =?utf-8?B?alcwNzBLcVhtMzF5WUdpS25JLzl6cndPUkdQOW1hUmlxV2J0a25wRmVUenZ2?=
 =?utf-8?B?RVNMTVZnZ0pyaFpMRC84bHBVSktjOEhFd1V5OURsbHVlUjg5Nnl4a1F2ZTVw?=
 =?utf-8?B?dlRVSUZ2WGdJQjNEUXZCZm1wZmppWHJDSmVOSEU2UWNPcU8wZkR1OUNvME9o?=
 =?utf-8?B?ayt1cWpSRTRJd2x1OU5wenYvSGNobjBONlA4dnJUQVFleFltazhjRGQwZ3Fa?=
 =?utf-8?B?TmJiN2h1bGw2STJFOHVGSlZvS0ZhUHVwbXVwRk1xVzhIZm83KzJSajR3WnAv?=
 =?utf-8?B?WnI4dlNwQXVPdk5UUUhnUHVHekZCQmtxaUdTSmZOWFNJWGIzNWNzb0tNSjEx?=
 =?utf-8?B?NU9Pbm9EZXZUblArN3dKSWNxZ3BNRmlJcE9ONnJpYUFCdXZLa2o2TWViWldr?=
 =?utf-8?B?b3VwaUtHQzNLLzdybXh4WTQ3V2praVM2OWtLcTFkM2VMSzA3Z0RLKy8vYTJP?=
 =?utf-8?B?RzQxQ3p1UHVRSHFBSE9uSUl6RUJWZ0xNbDNhZFlSb0FIZmpjSlg0MTNNQXk4?=
 =?utf-8?Q?M11ul4Vt+XoX4iZvUH3Hf3iRN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5399659e-3db6-4dc4-d005-08dd7da8ed4e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 12:11:05.0587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8PYK/PVymOcQ1vMlWbq4X7/AbDZzbcIRBmSkMMYV3DFGiLv0zd3whJOHMFflVXxwOy4ixsQ/PQM8Z4PKyBvEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540


On 4/15/25 14:50, Jonathan Cameron wrote:
> On Mon, 14 Apr 2025 16:13:25 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is created equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> Wrap all of those concerns into an API that retrieves a root decoder
>> (platform CXL window) that fits the specified constraints and the
>> capacity available for a new region.
>>
>> Add a complementary function for releasing the reference to such root
>> decoder.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> One trivial comment inline.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 80caaf14d08a..0a9eab4f8e2e 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t max;
>> +	int found = 0;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +	cxld = &cxlsd->cxld;
>> +
>> +	/*
>> +	 * None flags are declared as bitmaps but for the sake of better code
> None?


Not sure you refer to syntax or semantics here. Assuming is the former:


No flags fields?


>
>> +	 * used here as such, restricting the bitmap size to those bits used by
>> +	 * any Type2 device driver requester.
>> +	 */
>

