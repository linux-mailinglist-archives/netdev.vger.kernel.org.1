Return-Path: <netdev+bounces-266163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHZgD00osGnYgQIAu9opvQ
	(envelope-from <netdev+bounces-266163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:18:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1C3251B4C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03747304005A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953A22FFF90;
	Tue, 10 Mar 2026 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lQh0Xziu"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013012.outbound.protection.outlook.com [40.107.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF53374752;
	Tue, 10 Mar 2026 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150852; cv=fail; b=F06UNSvarLdBoacV4FjaPsJGjdldXHvBzYAnErHI4YQ7bOvAFCKocZGcar7Cm1tL99vLZfSg/if03CbTn6zRjZFHBygC5Jyll/q4Cy0ZitohTQoIiANLCpbzXV7TxGAksIH/qcnPjwzPKuJRCQrxgnjNfreuY1F/0/5zDvWB1dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150852; c=relaxed/simple;
	bh=poi7Xhj3TC/onQWy6zMAHOF0l7MhZYVvQdEw2jy2Jmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=reBv1H+T/ld1zWfGG6lPG07bBkWxVkTx/TJCa1ZLXLVc8vfvunp/26Zc4VmuXVqZ6WTq8oPVDTrU4Gzj5vrisgkpmKDokcO0R0U0BY7bAFlB/myuFDi809Ei0NSBLq8YIHPpXGtmPVzuvvC4sR5pBHxfx9sCv4T1vHLDfNFH6uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lQh0Xziu; arc=fail smtp.client-ip=40.107.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNCGbdwXbNhyvmyDRmoUKeFwpJ6xNsYtj0pCIy8cvnL4+XLLeXoNJtGlYOnMa1gBtbCu6uc9qefT1gqjurHCgg7q+UIHZ3P4kb5dPJV0CpGg7tAlCoQNaCqkWPaSe7L0UB8v07QwcG6K92Gj43mUG9oMMo29vURDGNawbLYH8mIObR6QezO7ELDXdQYgJguVkpcA+7DMe/LmOlrzsiqhCjKN+zZ07FhgumV3N+1Jo0wGGfzXLKwMiniivxeKpDzlpNwu7X0soGtgJZyyGWKTRLDU71PgZM2OYUk4haGj87ggW+38TJp69QXqFofrDY64z7TroeOaj7ToElub/31RWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNQWUKrcE/TySZM7a+y/BEkxuc7Zl5/CRse5bxIiRww=;
 b=UrA/m25S+/bCIRj6kRIHoN2x4ERoid9PYsJzOAigpQ2XyuxWVsX/HnZxUui6gdVgwDW7foeVxRSy/3i5JzxrlHhc7h7z6dbWuiIVyIePrnuBLfKa6qrznwAoYbRtjUV6uHkLo3RUeB8b7zWR7OvVo7z7NFfLJeqPpsoI1SCJ51HHCnCFn99rW5KEMJNIZ3bnHOW/FyMoT7TKtLy08P7xGk9AtKoAk2Q/Sb6jBWVB8bQBXnMEOcxCv/S0segjGo83F1Xn6qp69gwjmZcxW2BfS6fF/OFYZq0CgmZk0/5CgvIFiMAaFNM428YtLtagspbOG5Wd+zkxXG7hVJHAMwrKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNQWUKrcE/TySZM7a+y/BEkxuc7Zl5/CRse5bxIiRww=;
 b=lQh0Xziu/gR1Q3BWYole+YUByRsucDz2syJt9a0TAfomWB+MCRhhvEYe18wuOVOI2get3wrh1iJuvdZ+x6eHE7Wo4i2O6tYA9e59tFQPw53zbPvgzf/tHvedw+k3S6EHNlmeMjjx4nnVoEVhbpsMKIc5M8pwPWoXLp3aEl2aayo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 13:54:07 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 13:54:07 +0000
Message-ID: <dd2da064-3c75-4311-9d7a-cdc852b56733@amd.com>
Date: Tue, 10 Mar 2026 13:54:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 08/22] cxl/hdm: Add support for getting region from
 committed decoder
Content-Language: en-US
To: PJ Waskiewicz <ppwaskie@kernel.org>,
 "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-9-alejandro.lucero-palau@amd.com>
 <03ab7820-a6e0-4655-bae7-61d2d0b7dfd6@amd.com>
 <28148dcf-3cdc-439b-900a-a3f672a28ad1@amd.com>
 <ac50b18c99f5863f456d2d486454df8eebe35719.camel@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ac50b18c99f5863f456d2d486454df8eebe35719.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0672.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 45172046-1536-4cdb-adc2-08de7eac7f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099002;
X-Microsoft-Antispam-Message-Info:
	XWcpVR21oh/m+KpFMhh11iTaa/k4gpYGa+qYdd5ZgMhDlZ54FlP1+UcBfGqmb2phm8Am1aSJwHmf2QAtACY7r7vFEdx3PVtEF1wjoFZ+HbsEJZjqz7riQwErTQpOLngEWqiyJZ8RguRJP56tamoBzvHZ8OEx/1VXXq6EhSVhexgKijqN8nd+qoWOvPM1fr1PHJORlwWx50vvSVm+tz+y3g8D56Z7M3k1s+bQqqOaz9GOdaYfGFdYOvwtTl1WNfBN3cWjD/L9tvzLaj35urQo2l/6cKECfoxDOILR489NHWCtlXdabYJVHt5MbxfaDgSuWCKFqSU4Jnq1Re4kNByM2HiPPma4AorAg2nuRYeRCKzEK8LT/oh4GXTHSPqHMTX8ROljCWlJlyb7ew0uvR90FXGsiqWVP6BEQKpGM+d1bBHRJNRWpxLL40QtLVU8n3fp5Y9h3HbNdiwP5EYnCn4kf01wNgod7iqBJKcAUQHPdd1gKama7lp/jpb+iO0X6e1WYn03nnPl+6EAKnUk3FmGz5S9PKISc0NVoJCbPeiifXEFeEYD7mbNZS+6U5bYacmtLEENoFR/Dd/Io4bObxO/yBdItn1zNFrw9PU3BYwZ1gD095AdqwVGZNwHJkuxb7umg5GXeKPMG81AInZq5iHSq+paVss/g62u0oZEfiGghNC3gw7wB0rVwgjzaf6NPl/T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVNYL20rdEJMSlNydXBmbURyWUxua3BVYjFXS2ZJUlhGRzZPdGtUOFhIeFJr?=
 =?utf-8?B?Z0JINVV6N2xIdGx2VTR6Qms5UVA2cWhzT0pJZTZueTQrdXpDbXI1RFlqRmJQ?=
 =?utf-8?B?VnNzSHJ6SDRnV1FkNHBJTXl1NGo5M1dWcVNUWERhYjlBa2Rpd1BtcWJ2OUdW?=
 =?utf-8?B?Q1EzdEVnL2FwRjdnYzVIa0JTTHVIbXpzRHpoajdab25udHZkRENHK2FFeGNQ?=
 =?utf-8?B?cEJXWWJ2M25sV01LZUhYdmJieGM0VU00WXIzOUJaSkxvbnJXamNMV0o4WDl6?=
 =?utf-8?B?Mko5bE9qUUloQlpKeEovZU5Mb2Jod0IzeHpzdFZGTmU2QS94U2N0Z1FONWZa?=
 =?utf-8?B?cHM5QVRDN0grVnRPK040SnVjOXEwQzNmVVJKVWxoajRQK1lKQ3lqbzZwZXBr?=
 =?utf-8?B?V3RPNldQODZRL2UyUVlMSUFCWVo3Sk5xUy9ETDg1RFpzc24xMkxXeFF4a2Fs?=
 =?utf-8?B?SFhrTHFpdHhDZFRQU282czlET2tZdVhmQVFRTmpHTnlYODMyR01JUWpFUTMr?=
 =?utf-8?B?K0N3NXVaSlZtMmRFOFJXZXNzTFE4MVkyVlNTVXc1V0p5NzVNM1c0Tk85MERs?=
 =?utf-8?B?Mml3T2ttbk0rc0NkWlh4aGMrYzVwbHYwSy95MnREdDFPT3k0S3FzTjkxTTZ6?=
 =?utf-8?B?cGlSOS9lV3dZcitPUmVYYktrc0dGUjJKSFNFc0h6cWY4bTY1bExEWjdoZFpz?=
 =?utf-8?B?VmE4T3FVdDcrUzlRT0IvZ0dBcmRWNUcvRU1nbUtobWpLM0c0ejZsbGhoMWRH?=
 =?utf-8?B?L0NnV2MzNjcyVVZNeXBlZG9OYVdkR0ZKY2p2NHVNd0ZVbEhVRTJhcEk0M2tM?=
 =?utf-8?B?ZGxJQm9mSkppNytQZXJkNVd1NUFCRklCdkl0cGZqTjV1V2R6OXB0N1JFbkNI?=
 =?utf-8?B?WkNtN0w3c29NS0hITENadWEyODJIMFQzS1QvUjg4L1loblFmdW9LZ1htNkpL?=
 =?utf-8?B?K1J1S2FqRlVraGNBd2xNRCtmY3JOZExtOUk0Q0g4RUI5MjBnTjdsMXBpNlVR?=
 =?utf-8?B?Z0xQLy9TZ2ZHU2U3dTVlWEs3ZEViZjVtT3FPNmZQU3g1Q005bzM5OFd5emJj?=
 =?utf-8?B?V0Uya0VaakhBTndDekxRVmtRSnZpYU1OV0MrQm5IUzNmd3lqRVU4TTkzQ1d3?=
 =?utf-8?B?dE1PbGNkR2Y5SElnZnVIbnBuQTlHbitybXRQY014bStOcHMrUjJtT29UTzAv?=
 =?utf-8?B?N1VSOEhTMzI5TzRQckU2NDZJbEpnamMzemduUmlldjkwVHdncnFQSEkrUU8y?=
 =?utf-8?B?cHcwTlR1cTRXUW9LSzBPVDRBMjFZM3c5VERubUxxTk1IRmxkcEtNcm5XME4z?=
 =?utf-8?B?RkR0VXlyeFpaNEJBSExuc0VtWlVvNGloT1V5akVYcnlmR0dhd0x5ZzdJTXNX?=
 =?utf-8?B?R0EvQlh4cXhkTHRNQUVjdHRoU0MxcEtndS9pTkxqSXdXY0pVblpwT1hDU2N4?=
 =?utf-8?B?SDF0aHpUa1lRbWJXRG5rb1dlVlgxUVhKZ2t6VzV1LzE0TnZxd3g4UElYeEI2?=
 =?utf-8?B?anFQYXloTWh5dnBtTnM2YklMbElhOXBRU0JrOHpFZ2wvNEFkejlWbEVTanp6?=
 =?utf-8?B?MkJBRFlsaGJyUWxmU1BrSFZGNWh5L3Q2RVdrdlJBUXJpYmxaQWdaQ1J5SG5U?=
 =?utf-8?B?UEl6NitaTHV5dVBocXRmSmZCeFdjbHNscWV4N2ZjS253OUFxamdoaWFRNng3?=
 =?utf-8?B?Z1RMSURldFhGT3V6UkRJR0wyb3hDQSt4N0xEaE1rb3ZDQkZnUW9mRklQNVRF?=
 =?utf-8?B?YlVwL0QwaDNOWnpjOXlaSng4Q3doZ0xkQjl6VjhOOEs2dlVYWWhRVVVKV0Ja?=
 =?utf-8?B?UzdvMzZQVWl2Q1dFZGFxYi9mQ3JOUXl5UGFVSU5LVklKU05pQjBSb0I3cEVW?=
 =?utf-8?B?d0U5YmMrSTZ3ZG5HaU01QUFlTjkxRDUydGVtaTVwU0ZYQ3ZnbFBKV055Z1JJ?=
 =?utf-8?B?UFQzblROMmVkaExGcEQ4anlIRFdPS0tTUnVzTklkbEpLN1B3TStlemkvOUxP?=
 =?utf-8?B?d0IwQ0lMRUlpY0M5NklpWXpBNjAzQS9Kam1CMTFUVDZiRjYvRkM5RGttYlN5?=
 =?utf-8?B?NHJsVENzTytkdUsyVHhoRzRVUDA1TjhIUGlxUDNzYVdSTTdNWjEzeVFRallV?=
 =?utf-8?B?eTRlQ2VFenIwTEN6bHg1eHhxTDVCVUJIamsrNVVvbnFQWmxUcFcyUy9tdHp6?=
 =?utf-8?B?RVhXYzlZaVRCK3hvcDVicUE5djFIQkFGQWxHN1RsVkFpQnRXSitRUjdtT2hX?=
 =?utf-8?B?MXpvUi9VRG5obDc1aGtGY0NCZ2FBTnJpRXlHZFg4LzNjRmtma0hFbURKTXBS?=
 =?utf-8?B?cHRKYnBoNzJDTCtxQU8wWmRkWmxic0VHeGdYalF0d0xaZG9ESktQdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45172046-1536-4cdb-adc2-08de7eac7f6c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:54:07.2395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgWM2TDKejf2ZQ52TNlHPR0ZNaEXpoedXSUqw5tnpMYCDbfipFwiYx7PSpbK2HIOLVY/BZh0JJ/FcHpduY31UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719
X-Rspamd-Queue-Id: BB1C3251B4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266163-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Action: no action


On 3/9/26 22:49, PJ Waskiewicz wrote:
> On Thu, 2026-02-12 at 09:16 +0000, Alejandro Lucero Palau wrote:
>> On 2/11/26 22:11, Cheatham, Benjamin wrote:
>>> On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> A Type2 device configured by the BIOS can already have its HDM
>>>> committed. Add a cxl_get_committed_decoder() function for cheking
>>>> so after memdev creation. A CXL region should have been created
>>>> during memdev initialization, therefore a Type2 driver can ask
>>>> for
>>>> such a region for working with the HPA. If the HDM is not
>>>> committed,
>>>> a Type2 driver will create the region after obtaining proper HPA
>>>> and DPA space.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> ---
>>>>    drivers/cxl/core/hdm.c | 39
>>>> +++++++++++++++++++++++++++++++++++++++
>>>>    include/cxl/cxl.h      |  3 +++
>>>>    2 files changed, 42 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>>> index 6e516c69b2d2..a172ce4e9b19 100644
>>>> --- a/drivers/cxl/core/hdm.c
>>>> +++ b/drivers/cxl/core/hdm.c
>>>> @@ -686,6 +686,45 @@ int cxl_dpa_alloc(struct
>>>> cxl_endpoint_decoder *cxled, u64 size)
>>>>    	return devm_add_action_or_reset(&port->dev,
>>>> cxl_dpa_release, cxled);
>>>>    }
>>>>    
>>>> +static int find_committed_endpoint_decoder(struct device *dev,
>>>> const void *data)
>>>> +{
>>>> +	struct cxl_endpoint_decoder *cxled;
>>>> +	struct cxl_port *port;
>>>> +
>>>> +	if (!is_endpoint_decoder(dev))
>>>> +		return 0;
>>>> +
>>>> +	cxled = to_cxl_endpoint_decoder(dev);
>>>> +	port = cxled_to_port(cxled);
>>>> +
>>>> +	return cxled->cxld.id == port->hdm_end;
>>> Is this the way you're supposed to check if a decoder is committed?
>>> The doc comment for @hdm_end in
>>> struct cxl_port says it's just the last allocated decoder. If
>>> allocated decoders are always committed then
>>> I'm fine with this, otherwise I think you'd want to a register read
>>> or something to find the commit state.
>>
>> Hi Ben,
>>
>>
>> Yes, I think you are right. This works in my tests and it is safe
>> because I check the region does exist before using it. But the error
>> inside sfc should then not be fatal for cxl sfc initialization and
>> fallback to the other cxl initialization possibility.
>>
> So I'm running into this situation I think.
>
> When you're testing, are you surviving a reload of the driver?  Right
> now, I can load and successfully create the region0 device.  However,
> following the same teardown path in SFC, I cannot reload my driver
> afterwards and map the region.  I get:
>
> cxl_port endpoint5: failed to attach decoder5 to region0: -6  (ENXIO)
> <driver> 0000:c1:00.0: CXL found committed decoder without a region
> <driver> 0000:c1:00.0: CXL init failed
>
> I'd be surprised if SFC in its current patch state would survive this
> same insmod/rmmod/insmod test.


Yes, I can load and unload the sfc driver and always getting the HDM 
decoder committed, what was the purpose behind v23.


I wonder if you applied the patch from smita's series:


https://lore.kernel.org/linux-cxl/20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com/T/#mdad81d3817def8baace77ead9e2e305e775cf51d


If you did, then not sure what could be happening. Could you post here 
what you see at /sys/bus/cxl/devices after loading your driver, and 
after unloading it?


>
> -PJ

