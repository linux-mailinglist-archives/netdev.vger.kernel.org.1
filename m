Return-Path: <netdev+bounces-271303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHDwNr78wmlXngQAu9opvQ
	(envelope-from <netdev+bounces-271303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:06:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EDF31CAB2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CFD23046F33
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D842E06EA;
	Tue, 24 Mar 2026 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oX1yy+7Z"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6859013790B;
	Tue, 24 Mar 2026 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774386364; cv=fail; b=bRuAOrtNLYqKJQLqtplsuRKKYvMMKPod+e0oLyEcPTotDQUU9+DXA6Luea0QglSyxVwW38WVgpHo1J6T8S84XtvUD6NSpHNdvHGt33MGo48pcgyDPN0QYbkiyl3CvLj6pPk1U+hlXYvwpMMZYV5VKWJF/JRB4Hyx3Ctj1WCoN4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774386364; c=relaxed/simple;
	bh=lPMAitFsn9+8LxiFekQRbywzJphIHCRG2DPtgo2KicQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J3+CJlh28/lpEq7YWtKy9OdIAQzRRbFam2LZX37xqRqYIXFGRKXrVfgqGJ1zn9kVa+Za233BBvMgh2bYrmKPSJTjbxKLEi74JPRisfKjgM2MD9oRip5iBPYu/d958koDibX3415eT8KyYIGW1lR6ueYPyRB5hpeVD8prkHxQ6eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oX1yy+7Z; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHVClyf/49OGHZP8I2BCJ+JqojkZN1lgnZmduMMF7V0fXN/iVOnvHIUsBfs0wnt8bbzBRIlLlASsxCwVbo4c+EaBBBxLRxZq7Pwbjfc7Z4Ju3zN37JExEshfS1QhE7F4PQfrPCp2ivFOKKNO/coN83kezn4zM5nSqt9lWVIMlSHCPLs8EK24384wh5zHqrkIkgFQbWXR3X88xeYQNP+Fe4C1IUS+/FG1G2ivBo6inQPazniy9tNEvs4GACYdpjISnWnNIL7QEHEdJ2ECMH4lAT4GSpqB2PY0F/jCuQOSzbVhui5P6Rqp876MhMmGUrZyU31JD/xafFJl5KXNU/yONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvXvQz3N18fdlo04UzD0189k4TwY9YdZaYJhpjQ+K+o=;
 b=oYSMWbImvL/rVbIb8vE/nPB87U1PoLfOQvzF5q4fnjnc8HerOE26HL7nJjfEQp62EdjLDPA48UiJzQqx1cE4lc7FP8ucN1RaVWuJ/aqwpYhywpCUH4HIMwfbhC2S02zkcc8bjAfxtDngogPdxK1S5vEdgFtVhHSz369gwye9TGsA+/AXPXVZzfIxC8wZpGw6zvyLVZ6+GAZpA0QCRnOQ3B07uTHaPlHAbaCNM9aurxElKr9N9GKA+edyxZ/Icx5PwFO67E/B3vFeMtPfjzhDi5+eNjbtg0bxjBFIV8UUoETJDCoYuTc8c/McX671u2x8dIxpGCNKlKO8fb0h0qcAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvXvQz3N18fdlo04UzD0189k4TwY9YdZaYJhpjQ+K+o=;
 b=oX1yy+7ZT0CCsrYnpv/cnH36YXvLarZ35wy4h0w94FpmVFYjU1U+ZV+1Nx4eVGGCD1nU8JRgL5bSgTjZ9dB/IdEIT1orMrJMp+Xaz/nRg4HIhHcrmTAfootk4D4XggloiC+9W+iaua8ESnDqvGtFMKxd9NTAOSxLhDE7hA8UYQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:05:59 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 21:05:58 +0000
Message-ID: <82c56bee-2160-4a7b-8c7c-428b7f5412d9@amd.com>
Date: Tue, 24 Mar 2026 21:05:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 01/11] sfc: add cxl support
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dave.jiang@intel.com,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 Edward Cree <ecree.xilinx@gmail.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-2-alejandro.lucero-palau@amd.com>
 <20260324162907.00000c84@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260324162907.00000c84@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P192CA0005.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: b311fb3c-e14d-49c9-8432-08de89e92591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	2bO4gxLOKXaVetVbhjrlnjnwXKtVjt1ViwxX0fX9Pgm7bMXnTGv8PqRtMlvNJfK0ztOBpY3h7pqY4KJMk5SKJfrCQHxV0UyYkpRO/SJtiJqvJF5Hs1fqES9nx94gO6uQDMVjLTIG+rcdw9J6o9zbaBFq0nMUkuGek/JGFK+L0Nx4fQirgUqCDorxFPx0vow3dhSN8CdQpBETDmdAmjF1rZ659Js40ZAltgBhYGx9N9m0LBzYKwGE3164I3MjXcqrDLwXQ88yVtEMJqcEHkO2IX/Nievdkx4gSB2aMI+Lz/wY+juhjKgP06CAms52IIp6NY/bYf3q5HUH4fudht1Yin9BFrvrYmOOqtpGGBC5ZaAqoDnuwY8mb8I0F/N1uTuH/CuHRDh1d4/lcb+7x9WZmupVvg7o7OwEOG1hD85TYY8ltQNFa1WduviGkO1zlFRMqZRG9n7ogob37sC102dhYNVJfo2uvmcKSMc09Gw/YF7kwNyAe2M11QTSrSubJKEeTuXR8LKudLMFp9A0TwYuRDCUl8joCKCKu+T3/02cnd9OKAr5wanKF2BtYc2tTBUoKOFo/ad4XglmhSVNNjzei4i2zylAp2nBlAdbYrP1G6gulqhIsO54FobZAt1Td4Y8oUpBQbbfIypl7+g1MuDKPtO1Od1aP11/DXFGpwcJvdh+72ZGUsIQqqdiPEDB8tsWMx4scgnCdqfGYgcdrfr3IZuYLJGNeCqKCxr9+rUem44=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUE3aldiS2tjUTdac1l5ZnhFbG9BN05KdGNFelhzSmVVejR4Q1p4VDEwUExY?=
 =?utf-8?B?UFhXVEhvS2JNTDZqNjd6UHdjbEE4a3IvaVVwMHUxRVpUTzI2R21abDVGVzdY?=
 =?utf-8?B?bEEra0VZbkZkMUZmMTVVRFdIdXRaL2oxbU55eHlTdG5qQkRlVEpCUm13Q254?=
 =?utf-8?B?YzNWOEhZNTBWVmN0SFZZcWM0UG5ZY0ozamw5enZKaGljRHpSbStacHkzaEpH?=
 =?utf-8?B?N2dwcDJGYStZRDVORnBhS0JKWGh4VUs2UlVRTThHWVlpckpxeFN4RTRwVWRD?=
 =?utf-8?B?ZllUUUJiWUJQcWtPWGdCdFAza3NGK2F6dVZRMmdocWhZSFVSdDh6WjJaTUVu?=
 =?utf-8?B?cDVxY0NENHpnZWJxWTZQUmp2YmIydktObWM4TXptQkcxMk4vcElrZkJHSWNo?=
 =?utf-8?B?NFp2L0daUU1IaCs4ais4SDgrelNFS1U0SzBvM1grUXJoaXNacXY1QjJtdW1n?=
 =?utf-8?B?Ykt0WlcvOEJzNE4rR1JzNVVaWEVyOWhEblJ0dXlsYTZuSXhNaTZ1aTY5V2xF?=
 =?utf-8?B?STh0N25VSk9MbUM2N1RvOTQzdEVzTm4zY2dyMFBSVFVNOFlmcVBVMHJQeDFN?=
 =?utf-8?B?L3FialRhS2pRdG1EczJ0dGpwNWVNY3kzVHo0Y3ZIRktjMEc0YXovY1dMRVFh?=
 =?utf-8?B?aTdSdnNvZU5FSE1pWDcwdlBlZ2ZBVkZNdjExdDFpcnVRSWppbmdpK3lYT0tB?=
 =?utf-8?B?NmVZSVZyaHVUbWNxQk80NDByMjlZTnFuVFh5cTJzSjJkR3pYUkxnalc3bGoy?=
 =?utf-8?B?czNhT0JLcTJlZFVhenNPdFZWc3lONTl4VDZLRTZuaUs5UzdjMmN0UmJMZVpn?=
 =?utf-8?B?L1dGcUl1SzMxLzhaakJjMXNIVHhiaFBEWVpEcXEwQVJubjBaQU05OGlQRTYx?=
 =?utf-8?B?VExjTUdjOTJxenZ2Q2wySTBCODJTY29VQnJQZ2tvczhZL1d4OFMzOW5rM2dW?=
 =?utf-8?B?MlVUWWFmRU90QllnT1JlS0JGVWhHdERyaDRXL1hZdkJUNmZaRW1LdktidTlE?=
 =?utf-8?B?d2Voazk4ek1rUmFLNDh2ekM5U2Q5cjhQeDRqWFpiS0tBdWhqSU5MQXdTWGdq?=
 =?utf-8?B?aHRUblRPb3BPTnRUaGJKYWo1MVF1SWtRbFZoYkZ6QzhXOGhmSDkrYWtqM054?=
 =?utf-8?B?WFplc2tqaHR6M2xVdGliZXhSMGZ2VDM1cllXMjliMDkvSFlNdkJ1TkwzUE5k?=
 =?utf-8?B?MkJZWlloeVNCVVpWcElmV3BqYWlLR2x0VUlNYXY2YzBlUDA5aFFlWWZxL05B?=
 =?utf-8?B?L3NRbU5yT0V3MXhobDAvWkRhNnlBWE91V3ZlRElXVitSUG8xcDA4Zzl2a1d6?=
 =?utf-8?B?VGRhUU9IZWkyS2RhSUJPQ0xVeXluLzNVb2NjU1RoVExrRFoxd2hJcHBiZFZz?=
 =?utf-8?B?NHZOZTIwcFREYmo4UTQ3bFUwRkdwM2puT1BWVlRoUXNocHVKbnYxRm95VWpN?=
 =?utf-8?B?TDRreTJWMGEyMHVIZjRlQWpoMzhKTlZQSE1UVVFtQmlTMy8rYUlxV2cvSkJO?=
 =?utf-8?B?NEhiNnk3THJ3VzN5YnNJcWRDYXBoY3F4eVhscitWZFY1MmJjaFRoL0dXU3FM?=
 =?utf-8?B?Yi9HWmpFcURRT2p5MmF6ZG1QbFZLMENIdCtUaXZSeWRlQXVVVm5adnJhaEhn?=
 =?utf-8?B?MHV0YTBSRUVIWlZvdUp5Q3ZCVklXUVdLaHEzZndzQjVwRGJteUp4Mk1wL3dl?=
 =?utf-8?B?aDkvYmhVYXQyQXBEeEpTYVg4d3RqU0hzQmt3UTYraVV4SnJuNVdXdndpMExa?=
 =?utf-8?B?WWlqeEhZV2ZoRnZYcmtLdGhxOTcyeWZCL1VIQ21DMnJveHdEcDczTmJ5RzV1?=
 =?utf-8?B?SDNoNU5RREVLdVlKMTJnVDBwbmEzOTBuOTNrZWs5MVhPOGovb2ppMlJUMSs3?=
 =?utf-8?B?SDRWbENubEhvVmlwYXFEZmJPVWh3NEV1QVhSMUhJblNMMzlXS2QzQU5CUFVv?=
 =?utf-8?B?WDI3aGFlSWZsUE5mZVQ4OUZ1MlJxSm41SE5tTDNJbUVCU1A5eUxxanpPaGpj?=
 =?utf-8?B?STJjUjBJaFlycHR3ZElYbGkyQm8xcEFHL3RZOXEzVWdtZUhoSjdHZ3lENXVE?=
 =?utf-8?B?ZGE5azJvY0lnTk1BL1dKeHVHVWllUHdWWXU3anNNcFBGOElpRFdnNHZvbHZT?=
 =?utf-8?B?dUE4cGFMdEhUbnMrYk00TEVqNXNRU2UxVEJ6OENFbzczc21xd1F6amNOdEVl?=
 =?utf-8?B?ZXFQQVJGR0ovaXAxZ3U5WG5uWnZLYW00NzRBZngveW5CdG1pR0tzc0YzSHJp?=
 =?utf-8?B?OHNuVm54dVRWVm0wWXhrTUlQTWM5clRIVWY5T3Q0WC9MOFBnTUlVRUdyb3l5?=
 =?utf-8?B?MEtjSVlkcnhIOFhieDdzU0lzUFJmZ1ZtVFQ0NHd2NExwQ1VhNHNXUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b311fb3c-e14d-49c9-8432-08de89e92591
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:05:58.5916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPGQek6v7Jx14LJd8LLv/nm8uUdB4bP6F94FpGKjBuUFGy0EmP7h51y0KafW1TfphNkNuZcwlDrcrrwx1JRKgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271303-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,amd.com,davemloft.net,kernel.org,redhat.com,google.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,intel.com:email,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Queue-Id: 71EDF31CAB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/24/26 16:29, Jonathan Cameron wrote:
> On Mon, 23 Mar 2026 11:31:07 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependent on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Hi Alejandro,
>
> Been a while since I looked at this, so I may well repeat earlier discussions!
>
> One really minor thing inline.
>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> new file mode 100644
>> index 000000000000..8e0481d8dced
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -0,0 +1,56 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/****************************************************************************
>> + *
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/pci.h>
>> +
>> +#include "net_driver.h"
>> +#include "efx_cxl.h"
>> +
>> +#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>> +
>> +int efx_cxl_init(struct efx_probe_data *probe_data)
>> +{
>> +	struct efx_nic *efx = &probe_data->efx;
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct efx_cxl *cxl;
>> +	u16 dvsec;
>> +
>> +	probe_data->cxl_pio_initialised = false;
>> +
>> +	/* Is the device configured with and using CXL? */
>> +	if (!pcie_is_cxl(pci_dev))
>> +		return 0;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
>> +					  PCI_DVSEC_CXL_DEVICE);
>> +	if (!dvsec) {
>> +		pci_err(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability not found\n");
> Trivial but if we are returning zero is it always an error?
> Maybe pci_info() more appropriate?


It makes sense. I'll change it.

Thanks!


>> +		return 0;
>> +	}
>> +
>> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
>> +
>> +	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
>> +	 * specifying no mbox available.
>> +	 */
>> +	cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
>> +					pci_dev->dev.id, dvsec, struct efx_cxl,

