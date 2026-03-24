Return-Path: <netdev+bounces-271314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJvTL+gDw2lKnwQAu9opvQ
	(envelope-from <netdev+bounces-271314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:36:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E80E31CE4D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3D3B3022550
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719E35DA76;
	Tue, 24 Mar 2026 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vgBE81Vq"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419BA358396;
	Tue, 24 Mar 2026 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774388177; cv=fail; b=MOj6LglowFEKoy4ybjAM/qfGaYhVX+IlrtJAnqpuZYaomUw1BWl2tk7uPDUUNM83+sbMd94dUaUFUkkn75VkhxrNgiKUh5Coit0iaoLaPxNgFt55HxE6HY4Jo8D9g/Ar7PE5swFtI9giuWbFmAifpSe9CwAshvqsu3Mrqi77p/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774388177; c=relaxed/simple;
	bh=oAJ4CNsutTkxn0aUFc+AaS/uJfaALHMOI9QeoradhwI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UV54mpAtztw2/HWI1BqFWEzj7erjXo/5IUmBFxsUslPWDLaOc+17otBAEdfih2Qyx9p99hSU/4KersjRhyqaWn43zOf7yfttJSw7VqF5H1u84PPtku6T3JmlXzEZBMZ5/2wyqwlRA4VOEPRMj+kp64cmUggDebJsdvrga3H/Khc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vgBE81Vq; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Crffm/9Ht+Aiy6uiDw0mTfGtqssRHTEdxlN4cfuPo75nJuDmLowcwLM6hS3Q6Szvg36lC7O0s8BJrQmev2r6zwJYGr7p4Wk3OqX4CwC3bb5WGRcpZDoBtrjV3RTYf5lT9Lm2+PaeVGSrHbhDJAKciwFHvfp3sx44G6Jonu/aVm0iFIRoyo7pODPr/Dw9oKps1ZJziHNACUxzxoPayK/YH6E6RYEccUM3vp+CHwF2YZdxdwziaom1Ck+zSaGPbogYd0R2XbjukpNRFynYgJJ3KhPL9JF9+/7K5mF7CoNJN6HppveUW39FR7f/Civy/LTNK0OKMIZIAxCiu54bqU0DEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hRD2Ab+Fl01nLqC83bctYe6i+LH1uCkpgtZ9kiLp20=;
 b=CC7qN4qb32bfT95g6XTaTA5noTEP9OQzXgFkMb717ZrMjnVp5FdRE0Q9gMsSnjtYCEqaG5Sx12Y6PLfAl9PKC24yDq10pAir1E937qRlSYKyqiYNLZsuo03e3Qup97Ol5b+BQP05ASGwpDTcn8lPWe0/3yLar95IUhOhDzJxh/yLUF/foQVyxJWzE/sBWeIeMYA/tXqh9vti2Rsajc9QVDaTwdAX/HNgZu36ywaEd/46clVoPDdPclGI4EuX8SN24PaXNiEGL4hE/e75rXqDvfxrzCHnasAER5StGgkTVmmw7FpJh0IZ3fld9v5B0Rg8tYPOSawlF+sqlr7K79sdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hRD2Ab+Fl01nLqC83bctYe6i+LH1uCkpgtZ9kiLp20=;
 b=vgBE81Vq42Rnd6vjWMnPN4ShCrWDa6pE9W54149AFPY7kFmMWWFAHqwZR6Mbvese6XfHuJSMB+uN8jgOpi4im/7i3ltavnlTa+GYoQUEieSmu2rJOw5Fu+r5T47f7ZGpLVBqizengAzWMpFwENhuWPLDjreZXMiwZtEuxv9ngp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LVXPR12MB999198.namprd12.prod.outlook.com (2603:10b6:408:3dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:36:14 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 21:36:13 +0000
Message-ID: <0d21a506-e158-4b80-8264-064ff891dde1@amd.com>
Date: Tue, 24 Mar 2026 21:36:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 08/11] cxl: Export function for unwinding cxl by
 accelerators
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dave.jiang@intel.com,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Gregory Price <gourry@gourry.net>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-9-alejandro.lucero-palau@amd.com>
 <20260324165056.000037b0@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260324165056.000037b0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LVXPR12MB999198:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0e2a3f-12f5-4abe-9c43-08de89ed5f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	MEDueM+PkGBzvcP9/t7L9MwfY/G5vbehZ9E1FuYfTpzgKMpiIsXDGAfZJUepcPN8je+kSQK/g863NDLaorIOHGYa6oxg1e8VLG36aigZqMpRZFxNa6YShscvMGLej+P8gv2LsR5lqrhIOHpwhgrBITM1BI6kic7M1T70PcVGAsLBuh+nzkkuCwluc9nidOMY0c5pfc6BVPloD7y5Qr6JMWVQcMVK1asqujGtkpqdoUMLxj5HRpfYu5Iqd4O+cbzGok4QXTnKtTvpDNm+AtvAke5WO1Vv/GOCN+LLuqYZ6UHGwMhlQxJMZjNKFPQYpuwvhMlalng2V4hKs8a2MvManzYwBb1lF1VG8KTtFfP+qvgPRzj7wEtoO5bIBiNLYPGGRGiFE0hqEhJQgxWAzTpn6XkkyuQyNUX6m9guGIFIBxBzo6rv4M9WixrQIuu3jjTJ609OTO3fTCgO7vA2ywYtNZ/2vGOkHHnNdYVTTpA46JNwTOw1afyNIOeglvMFvQA3H8rCp31hibQkyA2g14I56GEqlF6eXN68XOVknQFi+03GkW4yRnwkLzUQW7envko+/lJQze3z2sclJ22u4ssKFndCektGDtz1t6SgtjUUFOmfg4CcQEUh3NEyOU7fUHYaO4wAE0mqapqFla9nBAAv7S5JCE/SaqswqeeELeLy6ktge5B3A6A90t3FXWwJBk5ZULWQKXZIUH0EyB4uvGog+0P9uVw19fnh0kjGsRqbDWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHZRRDJ6dFVGaSsxd1puNDZwY0s4R2Y3Z0t1bTdrN0pwbTFoU1ErbzNYOXFH?=
 =?utf-8?B?UmFrbTF1Nm02WkRQRmY3Y3YvaDk2US9jKzJDSW01RTJqK1dETUlXd3FnVlZL?=
 =?utf-8?B?Z0R3QkhFMHZyclpLcXhScUR6empjaldmaVlFaGhsUHdydm9jdVpQejIxb2o2?=
 =?utf-8?B?YVFhSlZWa0xYT3JvaVB5UmF6NS8vS2U5eUJaOFlsWU5TWkl1blZVc1ZjcFhZ?=
 =?utf-8?B?czMxeTFTcUNkUHVVZ3AyMEp0UmJ3WGc0blNyaFAya0Fka2NETlhXaWh1bC9o?=
 =?utf-8?B?bFlLSnJ3VGpMM1lrLzFhc21EakZjaU8wTERKdGhLSkVjQ0NFUjkxVHhKbWJE?=
 =?utf-8?B?ckwrdlcrRy9vdGY1Ym1Pa1E2LzJ3aEkzM3ltSnFSTEJiVGNzYklBcFFncTd6?=
 =?utf-8?B?UVJydFpRdGZoNXB0UFZubVh0QW5tZGgrUnhOV0xvVkFocDk4QkhyYmtmbGJa?=
 =?utf-8?B?L05RR0kzRk1QRTJ3K1dIbUpNR3lPQVlvcG83eVd0OW5YMlg0dUkwRjZyV2t5?=
 =?utf-8?B?RGtVMlFiZ084WEs1TzVJc0daRVlUdWNjYW9CbzVTdlB4VHF0S1VXdkFXSkts?=
 =?utf-8?B?WmZLcHhSNjdmY3huRU5ENU5NRFdlTVJnQ1hhUDA3YlZmVDlBQ2N5eWtsRlRI?=
 =?utf-8?B?S1BzRUhjQW5jeGZuTkROWjFEaHI1QUtMM2pSOFZMdDMwbkZkZC83OWl3NlUx?=
 =?utf-8?B?TnpvcVJIVmNPMk9zNXd2L2tJWmpTcTd6Z01KbkUrTkkyUVMxS3Zncnl5aE4v?=
 =?utf-8?B?QjZ4MGFvNGFUd0pWY2hMSTY2SFNCaFVOYmU5REM5WUsxY1RaVnNYMEUva0hU?=
 =?utf-8?B?elgrNm1sMmpXbDFieEN3NmowRVBzYXBjRjFaUldvaCtGMkhRZFQwV2NVeTQ1?=
 =?utf-8?B?ZGFHMHQrZlVTbmQzVzNMUlJJZGpOSk4yVGFsM0xYbWhQeHZJQ1FualVUdmVp?=
 =?utf-8?B?SEI4SGRCajdYRkMrMWs5YTJRSldqR0pVUWdpc1JnL2dxdFhSYlV4WmlkRnNh?=
 =?utf-8?B?Yld6UHpKOXYvaXRoclpVcU9NNFlCREFueitQRWNuak5qNU9Wa0l4ODV5dWNF?=
 =?utf-8?B?QktxWlR3Q1BKSnVncDN4VlBPQUpZTnVlVlJQRjVpOVRaZnJzeGgwRXBDY2xO?=
 =?utf-8?B?V0pTR0hQV0FPamtPQ2syWjFsTUlRL2pvcms3WmxQRktiNnlCR0dwVVQ5Unk2?=
 =?utf-8?B?clRUSHZNNHZIeVBwcFR1Ulh5SXJsVkpUY2Z4UHY3S3gzZWJTanhiY3puZHM0?=
 =?utf-8?B?Sjl1MWh1WTBqREdBcXphTTRiZXlUc3RRZ01UZ1hQQy9mSjUwMW14WXk3NXlC?=
 =?utf-8?B?M1RGbG13Zkg4cGxQQllZZC9vSVpuZENKRVdxWEZhb0llaFVwVWEwTmg0NXhL?=
 =?utf-8?B?MTc0SnNpQmtQMFNBZ2taVzErRGJiTG9BK1drZlRpRWp1QWppdHI0eUM0WlZr?=
 =?utf-8?B?bDBDdlhSRUFNVE9mQ0YzSFlka3I2TC9rTDJZaGFIdWhiam9MMXBUZy93NkVt?=
 =?utf-8?B?VUpBTVlkclpCMEg1a2FZckpBazlBWmhDa3Y5RVAvVGZrcTd3UWxQelY2TFpa?=
 =?utf-8?B?b2U1QzFha1pDRlBwR0VNVjZMYUtKd3VKdENZcFl5SFpObzUvYkxLS1RTVy9Y?=
 =?utf-8?B?REUySlBXbEZRV2hobFZyZXVLeUxmZkZuclBoUXVLY215bWxUZ2xFNU0rQnlw?=
 =?utf-8?B?azlsYlk5b092YXJmWlk5RFlqdGtkbjFuam91eVZvcWJYUVljeEhqNGljQ2Nw?=
 =?utf-8?B?MmFINHcwbjZ6eDdiOEsyb3Zhb3dyVDlaSTBzODltdlJqdU5HVElwRDNJaGlO?=
 =?utf-8?B?Unk3Kzl5ZXBZdjJtekp0cDMrb3JVVEZhMFNGV2VnL1NYeG5vdk1XSHZrTUVV?=
 =?utf-8?B?NjJBdThwUlRCa3cxT0VvRFF2NFVybGdnWksvc3UwOXdVaC9yZXhXUFlaSFB2?=
 =?utf-8?B?d0tKN3hINVVFdVVhRmx6dlVwbmRWNFdUYjJlb3ZOTjV1V1M4cmRibnpqQlNu?=
 =?utf-8?B?cVpNMlBGYjYvUERGZkIxT0NaQTlqNHo0V3dQdWlYbDNaeTlINlhndVVZcC9z?=
 =?utf-8?B?SWFNb0lVbGYyTWZXWjVxbVMzekdRWlh1UFhyb0VvMklHVHZ0ZUM4U2lkbTNL?=
 =?utf-8?B?d3NtTlpDYU9iaU1TNmZMTzJPb21jTVBRNzBQWEYrMEcyaElnalNhVDBTOW1O?=
 =?utf-8?B?Q2pCbG9GVDB0Q0pzOGdwaTE2bFQ2Zjcwek1IaGk3U3M3dnNiTUgxQTlaODRC?=
 =?utf-8?B?SlQyU0dPNmZBOVhLS0dNNHJROGxhcjZ2UkwvdHovTGNXV2NxZnJHd1hzRVhJ?=
 =?utf-8?B?blFtc0U0RDhVbng1Z2oxaW9wOW5CNTUrVWozZ3RMYXpuU0NqVDQ1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0e2a3f-12f5-4abe-9c43-08de89ed5f91
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:36:13.8142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGyMstjvrNzoy9dp5M2JMvC/QqA8BQ7yC1vThsSBIKiBgHBjRMBTu3TS5SA5rqeZIKTmuiqEb0P1rGlxkn4P3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999198
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271314-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Queue-Id: 2E80E31CE4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/24/26 16:50, Jonathan Cameron wrote:
> On Mon, 23 Mar 2026 11:31:14 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add cxl_unregister_region() to the accelerator driver API
>> for a clean exit.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> For this I'm seeing an outstanding question from Gregory on v23.


Yes, I did not forget about it but I forgot to comment back.


The kreview is obviously wrong but I think it points out to the missing 
invocation I need to add. I did not suffer those problems Gregory 
mentions, but I think that is due to how I configure my testing kernel. 
So, yes, I need to remove the release action from inside this function 
to avoid invoking ... this same function. That is another thing that 
puzzled me when I saw that review, and it implies I need to have 
different functions for accelerator driver specific invocation and for 
normal release action call. Or maybe just an extra param only removing 
the devm release action if invoked by accelerators. I think I will go 
with this last one. Any suggestion?


Thank you


>> ---
>>   drivers/cxl/core/region.c | 17 ++++++++++++-----
>>   include/cxl/cxl.h         |  1 +
>>   2 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 9c3ba911d865..8bb53a095290 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2468,9 +2468,8 @@ static struct cxl_region *to_cxl_region(struct device *dev)
>>   	return container_of(dev, struct cxl_region, dev);
>>   }
>>   
>> -static void unregister_region(void *_cxlr)
>> +void cxl_unregister_region(struct cxl_region *cxlr)
>>   {
>> -	struct cxl_region *cxlr = _cxlr;
>>   	struct cxl_region_params *p = &cxlr->params;
>>   	int i;
>>   
>> @@ -2489,6 +2488,14 @@ static void unregister_region(void *_cxlr)
>>   	cxl_region_iomem_release(cxlr);
>>   	put_device(&cxlr->dev);
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_region, "CXL");
>> +
>> +static void __unregister_region(void *_cxlr)
>> +{
>> +	struct cxl_region *cxlr = _cxlr;
>> +
>> +	return cxl_unregister_region(cxlr);
>> +}
>>   
>>   static struct lock_class_key cxl_region_key;
>>   
>> @@ -2642,7 +2649,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>>   	if (rc)
>>   		goto err;
>>   
>> -	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
>> +	rc = devm_add_action_or_reset(port->uport_dev, __unregister_region, cxlr);
>>   	if (rc)
>>   		return ERR_PTR(rc);
>>   
>> @@ -2797,7 +2804,7 @@ static ssize_t delete_region_store(struct device *dev,
>>   	if (IS_ERR(cxlr))
>>   		return PTR_ERR(cxlr);
>>   
>> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
>> +	devm_release_action(port->uport_dev, __unregister_region, cxlr);
>>   	put_device(&cxlr->dev);
>>   
>>   	return len;
>> @@ -3963,7 +3970,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   
>>   	rc = __construct_region(cxlr, ctx);
>>   	if (rc) {
>> -		devm_release_action(port->uport_dev, unregister_region, cxlr);
>> +		devm_release_action(port->uport_dev, __unregister_region, cxlr);
>>   		return ERR_PTR(rc);
>>   	}
>>   
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 122b3331469d..b8cdc604480a 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -236,4 +236,5 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>>   						       struct cxl_region **cxlr);
>>   struct range;
>>   int cxl_get_region_range(struct cxl_region *region, struct range *range);
>> +void cxl_unregister_region(struct cxl_region *cxlr);
>>   #endif /* __CXL_CXL_H__ */

