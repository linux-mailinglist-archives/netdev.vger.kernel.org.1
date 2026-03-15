Return-Path: <netdev+bounces-267955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKsvH7YHt2kALwEAu9opvQ
	(envelope-from <netdev+bounces-267955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 20:25:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8546292391
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 20:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EAE930053A6
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 19:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3CE37AA88;
	Sun, 15 Mar 2026 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K7Fry/mE"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020093.outbound.protection.outlook.com [52.101.69.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC21A073F;
	Sun, 15 Mar 2026 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773602738; cv=fail; b=SyciT3GmnpyV5lE/hdlgysp9oHeU88nkNPxCCHPEFv7MUxmKb4ukw/JimDcaB2QR0KBAbLHS/Xp0AAan3wHSTq4iMjPxMvb73rGUnS8gTEyKbfoFohh51asDZDt0FaFm6g2LQ0ZSWpmowKsfNLSwcpdHINfhPRkot1a8HfzvzIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773602738; c=relaxed/simple;
	bh=Y0+3lvUf5L4DwI4XmtSXwj5/a+lLNKr2HJZh/e0/Lwk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=noK8vI8V3FpoX2tu50oV/qN5NZ70RNm3djNuvtDKCRrMf8AZA02g8Y6Sx9rJvcAawQskhciW+uWNW32gBlDMjqmQvzlb7aka75hp+Mv4HG5mt/s4I+Ar1xLYuT1XY+V+8l7YX7Rhy3PeS+ZicV6KsspvGQQDlhqqq6GGDG+xacc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=K7Fry/mE; arc=fail smtp.client-ip=52.101.69.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPpZKCSKR9lQWxeG/nY6NwRtqLCJ4fflcoJg1yo9inNpchpsTpQ5k6CqKzOOpNpiqvJ06vlFFpqcvSjNNQwABG3A5YGDefc/JRyUfg1REPP/k8jHG4Bk7u8y2/kYscqoW8Y2mAfqkt0K2vqaAYbwcPIyZEEBx6NiTF897eDYIBVIS/Vce5yTTyiE6MsJfWHDIbixYP1QwynmhgozWv4RimQXensLRNt/NNXIeal053+NnZ80NKk1T5+C2GEe6RyrzAyL61ytxeg3x/QMTWiVHxJhxaqx/dbD/mQHtIJSdtqquayPplrY+H7yhPUPVsbFw6+eMM4+Y0R61aKTJ1xFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCeSyObV25oPF47N4W+zkBLe/LQx+ZH31BuxPu8eCW0=;
 b=RLh/CXlU+1SPY+cRtfUQoOEF/LCqVdo+lUDPxuVU4q7K/nGfA79M3gSREHBKBv6CQb7gCy2QbxrYh1bRHRK0zu5+yJDHYV8vi8bETujB3ynjMvqGwKXx4xVHRpNMctp9PRG7cdOKdNCUiGJR/52NZqlH7Q7m1oZTZfzAPXYYP/iIHwEzepMOya3ysq2qpK6Oj/8DpTWwhrAx0HMl3OKGRjM31W+7xUXAFtE1yLMjtNtiUjsYA58gsfUlyOB0lh8jC60rGa20jaJJIX8zyWfJKs3aSP7AmbFtcIOAf9n475Sm/f7i705mvxRuqyYKwNBv7Llgmf6kokqBDxO+lKL+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCeSyObV25oPF47N4W+zkBLe/LQx+ZH31BuxPu8eCW0=;
 b=K7Fry/mEyzEeFqcPAN/gfHfRk225WvxYCBTDw0KGXP9W67q0dZZXh5okkxAeJtLlYDsaPZcU4xtniXwCnh5moFaIhlSBEtCtowYTOim86qiwdSYTKsP6KOwnqbXqgSSdpLlX86FHYdYLM5DL5alRQMH+CWVMUbRdOUAv8TXtQzbS756oWgE5lX8Cd/z+CfncsQykk/RR+ikq2JV6uVGbdb+ZVi71gwbNUaLO3FfIHrLv2xMVr6mBsul8aDcXvK5IE5kGii5/16kmFouWmWcg7i/d9Lbn7k1+DYDl45udxqT/ITDF72RqfbqjPnj3hPVCcH8nElJ+s4vX+4Q84PK6fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM8PR08MB6355.eurprd08.prod.outlook.com (2603:10a6:20b:363::24)
 by PAXPR08MB7319.eurprd08.prod.outlook.com (2603:10a6:102:220::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Sun, 15 Mar
 2026 19:25:33 +0000
Received: from AM8PR08MB6355.eurprd08.prod.outlook.com
 ([fe80::79bf:15ff:6428:dea9]) by AM8PR08MB6355.eurprd08.prod.outlook.com
 ([fe80::79bf:15ff:6428:dea9%4]) with mapi id 15.20.9700.021; Sun, 15 Mar 2026
 19:25:33 +0000
Message-ID: <dd1f8981-b8ad-4a4d-b6c8-3333fb05c93b@virtuozzo.com>
Date: Sun, 15 Mar 2026 20:25:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/5] selftests: net: rename pmtu.sh to pmtu-test.sh
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Aaron Conole <aconole@redhat.com>, Ilya Maximets <imaximet@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org
References: <20260309152013.565216-1-aleksey.oladko@virtuozzo.com>
 <20260309152013.565216-4-aleksey.oladko@virtuozzo.com>
 <20260311201057.049950d1@kernel.org>
Content-Language: en-US
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
In-Reply-To: <20260311201057.049950d1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0140.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::19) To AM8PR08MB6355.eurprd08.prod.outlook.com
 (2603:10a6:20b:363::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR08MB6355:EE_|PAXPR08MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd52146-5419-43cc-82f1-08de82c8a0bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RCO1bljwtzUxoMs3u/NKETg89G+5CdxFrH6/S8LKZpSDEPQ6t50Uz0e+Am4mrMCqmfRbXwjcKzzZddK959obQVGIs58GO52bHCzKiCC7DnneoG/MijtQW4d7YDRxHOfNoBoshfqLmr+4e/IG5MkwULP25JQWiCE+PQ18yuI5BvaU61n5uSR1ePLv1Lr8RPWz4V3CpoXxsPaxwpmAFqMQ2s6NNAIh40nHssQiFQtjjfVcXjiw2z1K+kjlD5nyQQ6QEtnMXVaWm3AdMjrslbIC27JYImgEf2jsv+cL3mLZmEY/dnWxbgbxdRTGWGlTUoXQC7BnpF76KAINvNFlhqwgcnMraoabMMuyyMwodaE4D/VaRfJCyLWYp4xE0SEvcLgmFl1ekTve2XoZOJ5tdWcpShvSMtNZyyt02SeIltYlnscYSiPFFwWTQKRxq/R0NUQsWSQhYj9THVFT7/16mQtprH+CJgPBujNDco6+8njCjV0YG0HlEc8p1zZ+2XNm1imuDo/sUklHvPxSTemPZfLSvzJTIj2sHegJ5bXL8p/sBsr8cLoX6jbUGq/p6M4rH6Ajakd5xVinkf/n48FU5fw4H1THlhYb0o16/eytOfcV190NcD84qL42TLzw7DikaKWcLM/jun2FytUT0HV5Jnv8/Tfc1gnh02bLDoH4r1xLfvq8mN64KeUGbvORTCHVJNY3HexXJVa9FBgu7sjTcw+3ZatZ7glxU6HNZHw5JMinolQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR08MB6355.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFVYeUNCMlJ1WGpLNFowWEsyZXUzMVdkN1N5bDc1V2o2b2JBY2p2M0V2SUR4?=
 =?utf-8?B?dGNXNkVOczBjZGRXcG82Z0RkLzRDa0VxMnVDN3lxQXUra3ZWbHB2R1VlTEt1?=
 =?utf-8?B?bGxUTWVJSis4TW5TR1gvQXJGSjVKdWY2RXZ1VW9wa1JmM0YzVWw0M1pxRmlY?=
 =?utf-8?B?b1Jya0YwdGZBdUJzYnc1MVNkMzBULzVtdGs5cXlyNUZvbG9ZbEltYTdRaWRx?=
 =?utf-8?B?QWtYbG5Nbm5nSG5yOUhnN2dNOVJMNzBOaVFIWVFSdEdYLzNPMnlKdElKeXdh?=
 =?utf-8?B?bklFbkFVUW1WZXpwRWdXN0tkbnFidmNkUFY3cTlwMXo3UHFZRmJ3Rms2NDhz?=
 =?utf-8?B?ZmNnYldSZytGVDlQdVZwREJSWW1wUlhPdkRPdk9UVEptTXZLMzVWYUVkV3Zs?=
 =?utf-8?B?TXhMQmhvdUZDYmlqRXI3VHJHR1ZHZklWcVI4aFhzSFJGa3RhZE8weUU5QXNH?=
 =?utf-8?B?VUlHc1NUZkxXQjRUK2M4b1M4U3hFOGpCUGJ1bGJlc3FiMHllYlNselFRSFla?=
 =?utf-8?B?N3hNRkYrelhrNEZkbFlWOXNVR1hqc3JPZXp6TWxMNUx3YzNWK3dlMlptbVd1?=
 =?utf-8?B?QUFldkRDUklCVzFGeEdOSnZBSEtVSUJXMm13WEs0dXRkejkxaTlEdHZlbzVi?=
 =?utf-8?B?ZlZaTU5yNW5ZWWgySWQ0MmNJUEN0NU9NME9XNUxyMytFZUlKb0lOaHNjRE9q?=
 =?utf-8?B?TXlmdmMraHNVYm43clBQREZaQTNMV1hmSmwxQ1VYRDh5KzZKN1lEOFJHUnRt?=
 =?utf-8?B?NGhwMWU5Z0pkdGJXa3BhK2xWa0w2OUhnbVlBVWZMbzhLZ0p3RWtsNFUwRzdr?=
 =?utf-8?B?NlN2MENKbU1BckUzcjc3MlM5TWZVeW9IeVJiRmFxZ3Q4NkpZNnBBRHpnZkpu?=
 =?utf-8?B?M0FPUTBwbkcwT0l3WFpYZ1JVSkxOaklESFNrenozU0Jld1phQWNPSWNGN1VB?=
 =?utf-8?B?bXp5MkpqNHh5bUx0eFUrVEhYczkzdklSbUxDWUhZNG12ZXg2cnJFeVIzZ05J?=
 =?utf-8?B?cDJNckhtbUg5a3lxOEJjbjFuNThyaFdSc3VLbU1yOUk0VjkveEg3MkprZ3cw?=
 =?utf-8?B?NTRVdWZKODcrVDlWSjRaRVp3VFI4SmpJcGNxd2ZFeWU4ZzJWV05tVnRNSVpX?=
 =?utf-8?B?ZjV3ZnRCUXZ0SGwxZkk3My9OUjVJaDJickxPMFVRd0tmV0x4MmFsdG5rZVgy?=
 =?utf-8?B?TG52VFVSSTVQYVpsaHEydHJ5WlBGd0VKa2U4TDZVSUdGeWJ4UlhiL1hCSWE2?=
 =?utf-8?B?TVk3UWVsY2lYMEpic3FpNWVIbTdDWHAzMm5sMFhtUkl1SG9kU3NZa1NOejYx?=
 =?utf-8?B?Vm1DMGpQSjFHVjFJZUNLWGdMS05XdkxiZnJ6dHFKNTAvVFZqbWpXTUprQ2hx?=
 =?utf-8?B?QUlHVmg3aWFJTVFQaUVhQVpmSDRKMVArVStmYURSOWJDR0hsQ3l2MStJOUl5?=
 =?utf-8?B?MEp0SXFMblZ1ZjkrV2MzeEhRNE9sZ1E2OE9oNENkWFgwbHdwc0svbXNiUUxP?=
 =?utf-8?B?ZGx2TnlvOEJPZ3luYW1PUEJwNEdZeHdMTWtISkhkdEQxbmt3ZnRrdnFRVU9W?=
 =?utf-8?B?bkdpQnVUNlhZZHhyWEF4NUtVTmVjNGo5VHVKdjFIaVFtYUgvRHV3ZzR5Sm9l?=
 =?utf-8?B?QzJ5V05QNDRrVGppUE9CLzZid1VzcTFoOW5zUEVCN04rWDBFTjZrb0s2OXg3?=
 =?utf-8?B?ajAwSVViaWNPajhYak9EczhwNnhrMnUrVDJsempmbTVVT1JHYlpZU2NyZjM0?=
 =?utf-8?B?dG4yZHdOeDZhU0N1Q1hITk1MamNXZ3VSaVFFdEpFN3pDRVRUazU1T08zK1Z6?=
 =?utf-8?B?V2tvck9JWmxrV1ZXM1A5NXd2eUtzN25icXVFcEtoV2x0aXdxcmlyVGZhQU1W?=
 =?utf-8?B?NkRhaXVqQ0JhdVkwUHh6ZWxLRDlTZXlPemRSdWJENzB1U0ptUDdRQkR3Q3pw?=
 =?utf-8?B?SFBtdnFrdVdiQ2dqaWxyWTdaWlcrbWRTOGxCb3diNzVlOFh2M2tmb01ES0Iw?=
 =?utf-8?B?T0FSYjJWRE5uWFB6N2pzL1pVTis3dkltVWVNVlg0ZjJ1MzlyK0JiTnY3elRT?=
 =?utf-8?B?SWxZc3Y0UjRiTCtxTnJ1L2dubVh4VXB3ekhqczkxU2x6SEhkbUUwbHM3aFBk?=
 =?utf-8?B?cE84RE9aUzlXYjQ5dTJkTzF0dDBqOVZhNnpxVUl6TUlLY3dlL0JxNDMyWlk1?=
 =?utf-8?B?ZzUyaExEZkZ3NUxqQkNiSmtHdjRpOXcyOExkbktDa1cybDByUVdsc0dnRWI2?=
 =?utf-8?B?dU9BbHBaWVJBVWU4bk50RWg1NjFzNnVLalQzSWVDU3VZVkNmYkU1OEM1N3B1?=
 =?utf-8?B?TTBNNFRXUm1STmVPM2JEVzdnMjdPbVJ4TlljSzRjbnpEOG5zSkI3bStGamF5?=
 =?utf-8?Q?vI0jjOGNC6Fvs0WQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd52146-5419-43cc-82f1-08de82c8a0bb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB6355.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 19:25:33.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4hYT8ExQlRVqJMiUH1L3PrvWNChIdjNf4YFx0WsSB5twQw9vLC+HlgqtvFUTfkG05xTd0WpfYhZUTRafoNSYfY92nxBoze2jK3dnKsBTp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7319
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267955-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pmtu-test.sh:url]
X-Rspamd-Queue-Id: C8546292391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In v2 
(https://lore.kernel.org/linux-kselftest/f7t1pj9v8h7.fsf@redhat.com/T/#m80f10ade0ba8963ac6b09b8aba07163cb3e4cf59), 
I was asked to rename the main script for tracking purposes. Should I 
proceed with this setup?

On 3/12/26 4:10 AM, Jakub Kicinski wrote:
> On Mon,  9 Mar 2026 15:20:11 +0000 Aleksei Oladko wrote:
>> Rename the pmtu.sh test script to pmtu-test.sh. No functional
>> changes are made, only the file name is updated.
> Please try to fix the test ?

