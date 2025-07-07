Return-Path: <netdev+bounces-204452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5A5AFA94E
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 03:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF1517531C
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 01:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30A72F2E;
	Mon,  7 Jul 2025 01:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="pqPKLKrV"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022128.outbound.protection.outlook.com [40.107.75.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0507328E7;
	Mon,  7 Jul 2025 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751853209; cv=fail; b=icuAM7jjQW4U6lBD7FrD2KylG404fiBudghhH0T36zPvpJjaufCLSm1dnYN9LdPPaAdGrg6jiQFXpfIMxsrtw7nhWL4V4eL2Pn41Kjg55wJU20wpvQ0PHi+N1SQRdJWarm5MjguP9P1ZAoKNiLpRgCnAIrUnSGr0acqCbK9gWOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751853209; c=relaxed/simple;
	bh=GeiLG+iTDY+6FkJeNxMjc+n5K3AFHvYFiaekQyf6xwk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N/2UxJYDxpIm9+tvvM2ID1Kcb5UmSD8/sFCrp0lHatvpVQGMm5qKVGWcmLPAkeiK3DOl3dPtqoLYsOLR5CXcs6oEu2zZkTRxdTWyZcbn5pYoNox5LxkdpSIT2UZXi+57cstxuBc3uwYiGs976YLT1j2p+8hNTqB5DnTLpo/mGOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=pqPKLKrV; arc=fail smtp.client-ip=40.107.75.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9azEQzTEA7wk3uyLw93mJtpS2nK+yB5kuzd+q24k+dJniaV1GhdslJnOwxBf7rHwJGPoRXF8mXLEtayKDS9AeVO2EKR07a46gbaLcfYsxlpYhnSiSJShc+vjEds2T8MmczyF+atkAovZ10+HmOEPS4H9A91lJoZb06joyCCKQZ+gpqctDAcRzaap4yiA6Z57YuBUNxpM2giL7YxrYmTQgfprD1LavWyEF6Lxv0D3u6HKxDpBVXrlPu4EmNZIz/Ja103oMAeBF8a9qYOnQE9V/7UI9hY6XcC1fC7Mr4eKEeDlaZJH6AKrUBvPzkA28Kw7oNx/5lS6I1B8qukHb7G9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZI+M+mOObkYX87Oux1AhJlCuxvd2BkxAPSsdKNQ2co=;
 b=c9fsGcIAOvXOOZbldedsPcYYdX5NbheM5ftDZPvjgm1FPOfHkv7K+FC1C5N4tjG2NIphtLbSAQjEpvSVi+MGou2fwQtIMOaqMRREBA7hDqCbL+oS9FNDuJpYaokOqJHRU04icgGBPbqtJf39QAEUJvZjxCxH4yYQG2kdtOb8HJ2AO94ooh41lnfXL54rMV72eWTkF97dr0ZgKmD3urL5S/yhIS9ORkniNHtGWC338f3EfjyC8BeECh9ViWmTzDocKJ34wKscMye6AN6DHRm8w+k0MgKOOtLRio2t/3xNBsbHlV3ll6q+i3Lgr8/b2GKMQgIeMFnM4NUHWA2ObZixtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZI+M+mOObkYX87Oux1AhJlCuxvd2BkxAPSsdKNQ2co=;
 b=pqPKLKrV95NoBKgDtINnJ/XYDPIJh3PyOmB/8xyijFamUq4IePkPr2ePZ2eEZ3rpY2G4eAdpfoXuGfcLaNn7P8LvJAsOR7oVZnZhYf0JKM2Wi/3EJcSMnxgzA2q1sRpCj+MDZNdegOI5EcOgzCM7L9TlnFkuN1eMeTIIHpiQ9k1s9vzDxF4HGq6uOCLK85M7OVgK5QDZBPVcWTfITl2CcUIItaDhMWtrXYFv3SRh43lhAOOO5qWrAK+40JDjBPlMMNYcJSy6TvOorJ9E8mq336DIOM2Mp3zsWM0Hx7i1nk6CnjVdCNXnSwuRGkecYNBszhnbpRCXMPN6dfb+NUeMOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SE1PPF3E08D6FB0.apcprd03.prod.outlook.com (2603:1096:108:1::84c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 01:53:25 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 01:53:25 +0000
Message-ID: <978c6925-c8c0-4cb0-9184-723c3cd1af73@amlogic.com>
Date: Mon, 7 Jul 2025 09:52:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
 <CAL+tcoAXCbhNG2-Pdd7C3iJD9h=GvM1PNstyMJXO8KE7XKAzDw@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CAL+tcoAXCbhNG2-Pdd7C3iJD9h=GvM1PNstyMJXO8KE7XKAzDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SE1PPF3E08D6FB0:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c40014a-6b39-42f2-f377-08ddbcf90f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVVySW5zN1UwRUJwdUNvaCtBTTZQOWNxTWVid1pQaUdodzNhZDd1Uk5WV1cz?=
 =?utf-8?B?ejhwL0x0aU9NOW1HT2pNcUh0OWl1VU9wVWZDTzlrL2ZUbW13NWttVlFvR3RV?=
 =?utf-8?B?OWxGRkh3K0orV1A4Vm1LOU1uRjE0WFZRL3pZS2ZaRUZXMmdmTFIvcUxYQ1JF?=
 =?utf-8?B?dmRxakNlYlYvTTlEWHBVYTNxV2w0aGhyZVpTNUZQb2V3MG5HSHZiSnVVb0Z4?=
 =?utf-8?B?R0hKWEpzVVdsckFCL3IyaGFZdHVIZlM1WExodW1xT1lUUitUUG91a004N1E5?=
 =?utf-8?B?YXNaK1llNkpJYkROWmUvSUE0WVJwYVhsWTA1cmROTDllQ3FueUhSeENQV3lO?=
 =?utf-8?B?a01JMUVuVFZpVDhaMjdFTG5iYXdCOTdVUE84c0I2a0NPdmZPMXVkQmpWVjg2?=
 =?utf-8?B?eUU4TXRNM01SQlFhZUJ0Y3JiWEJjZ2tiRjBOTjFDRG56a2VZZmM1RWl5ekxq?=
 =?utf-8?B?T0lxVXhjUDc5RGNPWEFCY0E3TTJKdUZGZDJETUZ5S3RuRU04a1RJNHdHbmpL?=
 =?utf-8?B?SUM3bGk5WWlYeDNMTmV5UXBNalk3TmhyVm1rYWhWL0xlKzFqOW9qNkNiSGVs?=
 =?utf-8?B?bFJWcnIvSHJoQjdYQ3dlMDdOeC83MWVOcXptL1p3ZGJkeVp5S3NKR2p1OFpr?=
 =?utf-8?B?ZWNMTTNhNjB5djZZbkNIcHk4V21MYkdOMTQzd1FjVXl2cGFEOEpFcnhKMVFJ?=
 =?utf-8?B?N2ZsRE9La290QXBDQ1dZaExUYVk1aE85YkQyQzRNdXFRWWQ5S2tiMXVKYUhC?=
 =?utf-8?B?SHI2aWdkZTNSR3FyWUpDenBXeGFaSlJHZFNPbU1FZXQ0OEkwRjhDS3dhVjMy?=
 =?utf-8?B?ZUFXMGRsbnU3SzNCQ2hMT0FhTzZiZDhGb0RKMlpRTWRSN21WV3drWFZoVUV6?=
 =?utf-8?B?bUl1N2l1NVpTWDBScWcwSERveWNqSVBCQmlPN3ZBUWVIekFqd3FMUUNaQk1k?=
 =?utf-8?B?R2RnenNiQnFCZDNnSk9mRERLRE13TFFnZmNXUE9seXRXTUlJdXI5MEFPTVZh?=
 =?utf-8?B?WnZDbW1FMlJSZEZ4bk4yL2FrTGppS0JHUnhBdFRQYjNaZnQ2UHNpK3cwelpM?=
 =?utf-8?B?aFBvdy9TTlR1aVpNWk9pRUtzN3lNTTlWRjlxY0NESjQ1N2tyaW90dlBTNDg5?=
 =?utf-8?B?UlQ4R2haOTA0UlVwUWprRWRZSUVYUjJYSUpyN29jZ3RVNGNSb0F2MWhtYmlB?=
 =?utf-8?B?Q0ZNQ0wzRXBrTmFBTTlSaDgvSTVjMllDN096TmY5cnlJd3JQMlJQZWdrTUto?=
 =?utf-8?B?SEl5eHZsK3E2N2xqR20vUzhpUzFFTC9MdmpaaFpWeWpJdlBxOUsveU9Ra3Fa?=
 =?utf-8?B?ZVJSWDB2VCtsVWlwRnJ0eDh5ZjY2RW0reWNkK0JJcTlhVW9SNzE2Z1V4akxL?=
 =?utf-8?B?QkRQOTBIb3ppT3FVY25BaE1kR2gwMTBZelJVNlIzWlpCeVFnRTdLYUFlZExP?=
 =?utf-8?B?RE5uZGZYOGJnR3JteXg4aHF0NGZwTGYwRWpvSjczM05PaVhvaUs2ZUlqTU95?=
 =?utf-8?B?NnBmaXZBeDJPcEhGYlp0K21UQW1Icy84VXpjTnhRc0VIR2pUNzlLVXhNOGNz?=
 =?utf-8?B?azByN0hRcE40Nk1yK2IzRDRXVHh1ZjhXanFUZnlqcnV1WUdiSFJtcEFlT1pH?=
 =?utf-8?B?U2JoSmViR3Z0N0VKcTYyRXVvTGMxZ2xFZ2dTekpHMnhxLzduQ1ZsR1VOSzNH?=
 =?utf-8?B?eTJXR21MNFZCSVgvbW1DaS9sQ1A0T0JLaEJ3YXFSOGhmL2tOeHF5eEl0ZVF0?=
 =?utf-8?B?a2hUODI0QnhXZ1p1aXNySVdaT3VSUk12RmN3L0pOZXdDS1U5RFFoQ2lPaWUy?=
 =?utf-8?B?MGp1Z1BwOWFFOHUza1R4WkoyV3VzTytrZ2RyTTlPS21NS3AyWEd1d0tkVmZT?=
 =?utf-8?B?MWNXZExIZjVUYnZoZHRneVdFemdNSlRuQm1JREVkNTkwZXh3VVZaM2lweUZa?=
 =?utf-8?Q?/9MNKUd5KeU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d09PZW41Zi9sa1hYYUx6WDVIbWR4YVFGSVo0aHV2NFpCMGFvbzA4bVBFNklE?=
 =?utf-8?B?YVErODNUSEJoSWhTODFTQnh5cHdOUzgxSkhxN0lXOHBET1NNUlVQR0RqUmVW?=
 =?utf-8?B?Y0xpNjFQdEhwbDJFSGFaQTdKTVBVc2E4cmV1aGlnNXRraWxtbHdSdHErLzBO?=
 =?utf-8?B?NXAxa1BVdjFBOFZXMVhZc2puQzJRMjF0Ym0vbDVoanN3eGlxOG5uSmM1dE40?=
 =?utf-8?B?YTM2NGlrTW9UNXVXaExhREN5ejNlak5rRldVWjJZSVhYNVlsb1B0Wk40WUZ4?=
 =?utf-8?B?S3llL0czaVpuTVFoOGVRcXJUcnFuc0FUdGF0ZFp3MUF1NVlCZ0VYMEl1Z2V2?=
 =?utf-8?B?MGVSSXhtbm9TTGxPT0xPZkZGT29xR1B1RlZxcEZ5RnBXSkc1aVpiRmNVRmI0?=
 =?utf-8?B?aDNtSk14VnRGVlJPMlZudjBxa082YTd1SHM5ZHI2MHlYeVJ6NGsrUkRxSWFU?=
 =?utf-8?B?dnZQeEZNVkNta0twQVkrMm9FMVhjKy9VTFFVMFh1a0N5LzZhekFnRElFV1B5?=
 =?utf-8?B?LzJFWFlEVHYzdENIelo5U2labmR2SEw3dlBINkdUY2ZubGh2YmJtc1BaMW04?=
 =?utf-8?B?L0wreFFtRnV6TjV0T3RzSE9hcVNOUC9OcnFNQURoYnBjUWNHYkN5Z2QxRDZk?=
 =?utf-8?B?RHBpc3hvYUdUZlFDZStFaDFrWjgvL0J5dHNtWTBEQUw2YXlsQWZoUWR1bjVt?=
 =?utf-8?B?VmgyR3djdE14WjZZMU11b2puVG8zMHJSRFhZV1NzeTBDbjFVVVNIa2pTZWhv?=
 =?utf-8?B?SUZJcmk4czJuK1ExNHlZbjBjM0d5TXhVNUE3RXRDcEo0aVNvUnp0SWhKbjJu?=
 =?utf-8?B?V1k0WHRENUNpTTZNei95a3Z4ang2M3FOMDlBNStGTnVWZkNTVzVOblZaeXcy?=
 =?utf-8?B?YklLSi9CWitKcFRyOXNBMHpNcUYzT1k4UUtyOC9CM3ZVZVIxSXJWbDlTMjY4?=
 =?utf-8?B?bGdMckpLclMvU3duN0lrWXNsYUJKazFQdmlNSHlmUlNyTU5kZE9xaEFjODhl?=
 =?utf-8?B?ektDZ3Q2bE01am00QzF6eEFWODV2Zmpma0IxS3EvdU9GR0pId0M0emUwRjdm?=
 =?utf-8?B?ZmV4YTI1NVh5OVFheVFJY010MTY2ZlJ0S2JxbWNLdS8xamIweWtLQmNObUNt?=
 =?utf-8?B?YWNPWTRENkhQVlhOV3lWNUhUcitsOWtEQkVIdS9BOHFkRlg4cVBTcU5KNk1u?=
 =?utf-8?B?NFlJOTdRS29lM29JRDAxaE5kMzA3WVRoWmVlOHIxbEU2a2s4S29OZzd6V3l2?=
 =?utf-8?B?SGgrV1dqUXJ3c0d3UkExQ1FsZUl0WitBTFNMMC9aV1JadUw0R2RoK0RuQlRs?=
 =?utf-8?B?VTJJMlNmWDVHeXVXVElBbGxIenFPTWR2WGRHT0tVcnFmM1dlRHU4cTV1NWcx?=
 =?utf-8?B?Q1Bqc3VzZUpQL1BqRXJMOEpSYkFaWnpqQWU5NHA3dlFQUkdXWENZSEF5R01B?=
 =?utf-8?B?UXJWUWh0a1J0c0ZpSklOa3ZxRTZ2S2RQSXlVWU1rN0RvRzY3OGxhd0Z4ejZI?=
 =?utf-8?B?Nm1FblBLNEpDd2VOMVhvaWJTQ0NHMFhJSEtpcGgxTjBkOS91TXErODlsL1hX?=
 =?utf-8?B?TXZCVUxMdm1aNDB0YUxFaWZuUEo1R2VEdDBsM1RNbjR5ZXVKdU0rUHArZklL?=
 =?utf-8?B?ajA1NmVCRXhxWGg2T0xEYXduTXVNbVRWZmNMTWhLU0tRZXRsZGdNMHF0RWtv?=
 =?utf-8?B?UERSVG5nWS9Fc3drQ0tHaVdSbFV0MGI2c3ZlbDI0eFRROEdNS1lxdDFudG5p?=
 =?utf-8?B?Q1VrRlJGNElGMElOem8zbUp3SStPV0RsbnJyKzF4RndYdUxXc2E3dGNUZGVJ?=
 =?utf-8?B?R1M4TXhMUE45NWFiMi8vTWFod3dIZlNaaXREMjVvNGM4MFh3bFhpS2tDWUl6?=
 =?utf-8?B?TE8vSGRlWm0xNTNDL3RRMlBIZG5DanNkS0E0OXRFb1piRkI1c0o3cnlnK1dT?=
 =?utf-8?B?eXhxd0h0UHVDNU5NbHpiRVFBRUt4Q2xGVGdzL1VvZjFFbWlRN3o4SGZRZ0kw?=
 =?utf-8?B?a3ZFelNaczBtNG1Ca1QwTHowZ2pGSGhZSStVVmVwM25FV2JiNllVc0k0NzM0?=
 =?utf-8?B?M1JyUUVDUUZrWnVKM3lqSFpqMUgvMnAvejF4QWM4Q3VkeUtvUlljQ0t3bUkx?=
 =?utf-8?Q?iiTx7yiHgO6wyl09DXOJK0L0i?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c40014a-6b39-42f2-f377-08ddbcf90f57
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 01:53:24.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZVKQsft+GDZYia0C1jmQMGi04CjB5nJ8G7eGnGlWilelnxgaDKXI/Flr2vg4r7utBUTKHS6kL6g/mn4kZXWYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF3E08D6FB0

Hi Jason,
> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Fri, Jul 4, 2025 at 1:36 PM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> User-space applications (e.g., PipeWire) depend on
>> ISO-formatted timestamps for precise audio sync.
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>> Changes in v3:
>> - Change to use hwtimestamp
>> - Link to v2: https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d199c8068@amlogic.com
>>
>> Changes in v2:
>> - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
>> - Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com
>> ---
>>   net/bluetooth/iso.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>> index fc22782cbeeb..67ff355167d8 100644
>> --- a/net/bluetooth/iso.c
>> +++ b/net/bluetooth/iso.c
>> @@ -2301,13 +2301,21 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>>                  if (ts) {
>>                          struct hci_iso_ts_data_hdr *hdr;
>>
>> -                       /* TODO: add timestamp to the packet? */
>>                          hdr = skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
>>                          if (!hdr) {
>>                                  BT_ERR("Frame is too short (len %d)", skb->len);
>>                                  goto drop;
>>                          }
>>
>> +                       /* The ISO ts is based on the controller’s clock domain,
>> +                        * so hardware timestamping (hwtimestamp) must be used.
>> +                        * Ref: Documentation/networking/timestamping.rst,
>> +                        * chapter 3.1 Hardware Timestamping.
>> +                        */
> I think the above comment is not necessary as it's a common usage for
> all kinds of drivers. If you reckon the information could be helpful,
> then you could clarify it in the commit message :)


Okay, I got it.

>
>> +                       struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
> The above line should be moved underneath the 'if (ts) {' line because
> we need to group all the declarations altogether at the beginning.


Yes, I will do.

>
>> +                       if (hwts)
>> +                               hwts->hwtstamp = us_to_ktime(le32_to_cpu(hdr->ts));
>> +
> I'm definitely not a bluetooth expert, so I'm here only to check the
> timestamping usage. According to your prior v2 patch, the
> reader/receiver to turn on the timestamping feature is implemented in
> PipeWire? If so, so far the kernel part looks good to me.


Yes, please reference reply:

https://lore.kernel.org/all/df9f6977-0d63-41b3-8d9b-c3a293ed78ec@amlogic.com/


>
> Thanks,
> Jason

