Return-Path: <netdev+bounces-273278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLRWEYixymkX/QUAu9opvQ
	(envelope-from <netdev+bounces-273278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:23:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEC335F448
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6442B300BEA0
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D51B3D300F;
	Mon, 30 Mar 2026 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ey2tGabH"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023117.outbound.protection.outlook.com [40.107.162.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D6377016;
	Mon, 30 Mar 2026 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891389; cv=fail; b=B4BOIMKzDOHKiweoYI6jyX12VDe5MtWl3DUYjCVqXQxEAmV7TOp2FhDlyqMKbJ8dpUng+v0cLZTvVZLR+xK3uKtEd6gUchy9EOiqlXqW53+qahV4VpPCyCgUj7rn/sB2cdOBKKee2Os5QgZzzgFMNNNkCbY67wmOOHJZ47R19pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891389; c=relaxed/simple;
	bh=b4RSMJIDznU1T0hb5+jRCb7yiM/1G/Bd+t9aravwK4w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rNzYakqy1e/qJhCB6WRDruxO4GWUEbS67Tc3fkrNgrvssIautzIcF4G+VTMl6CAaFFQ/ey9bNTnv2aLVqStoZfqCyc4sYFQEaD4IALtP5L+cmLxgrJE+vVeqGhvJKsVMg3eytM+lnQdjzgP6VnDuCWb8jIhkHKY9yaZa3ZrBMy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=Ey2tGabH; arc=fail smtp.client-ip=40.107.162.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMCcw9/fs35i+hZNsMyFJc1RvqXfjsG+dWXcOlDkCND94/KR1kpLDaiTPuAHYjpBlyZ7CudWu9vJAt6pLqw34wxqLCD7YUI2Zzz+UMclDl+o1a6Sr4B+CFp6HIJJ+xm74G1lrrUVe0yzCzs3ELorBe0nyo6cF1x3gddNAkOcgv4Q396G9Df9i10MB4J2QdlmV60GsySvQRT9DjToKY/lhEEwoHzykJqW9vhkxPqKk4x310e2InJusruOTDd0YadIFoho1F9WxNm9GUf25ru5sfRpBit9gR9wBUTspFBHKw9fuAGZg7vwFTkOPKgzuHU5W33pOVgiBDSNQeLbEWRTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cunW7FU/ihSyn93ri4xartF/2XbfasfJ4BuA/bQlxY=;
 b=qCVISjU15Ud/tnB/9eSSnJJIZzI92Md4nONac0oL8Dj2tWtUsNqN+LhGbfNukrIsh+sa7uwobNXMk9cqb+wZ1Syzv1N0LC+yFzfl+VIVH15wjfsKw46xdSlJ5qXHW2QKL/i2SBFjdM8U8smoYZIoViXQ1Aq1GMuVgrYkKMtI+mmOicRKcdj9HJwtxdzTMoX5FqFXYVm3TSdZpmrf/zBpR+HNkS9n7JL5EbovR25bw0ym5HZnSdctTRK6CsKH79BpQy3FMzATLZmzwype8azY9WHBpkEZSJ4XpvTEe2MQRpmdqkk2no1gwkBAC0EGZV7xHpdqqVGaOGMWLjgmT9v/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cunW7FU/ihSyn93ri4xartF/2XbfasfJ4BuA/bQlxY=;
 b=Ey2tGabHbsRa/BsBjn1otVrLzeZ103O494CCw72/il4V4iXtW++h6rbLob/KRyZ4wg8hok3xAk3mst7ETEcrd4Yi7aQmIb1eOQdDdtAFIQOqefI7p++Xz2OR0laYn3ko7Ah+YW624a4XsuoWh/pS7SE1vhZvDGJcwULsQrLpgItGer1nQeb15V6KardNhMPMiHuGDRsaxliiW7Es5nQx6tghj5LCvuGXNVgraYRV1ONdGZRxM2T6S8dwhv+h0A/vwXZ5u3z8S0DBuYlYUCkzRUS6NdOGz7DkpoAhcnngfs4DsosMT2vAUb2G2vAsoAipS46bzrhHZu1sfngKtZkI6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20) by AM7PR08MB5352.eurprd08.prod.outlook.com
 (2603:10a6:20b:10e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 17:23:03 +0000
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a]) by PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a%6]) with mapi id 15.20.9745.022; Mon, 30 Mar 2026
 17:23:03 +0000
Message-ID: <d4305d64-2632-4714-8291-d948c515c34d@virtuozzo.com>
Date: Mon, 30 Mar 2026 19:23:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: fix skb_ext_total_length() BUILD_BUG_ON with
 CONFIG_GCOV_PROFILE_ALL
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260330135337.937540-1-khorenko@virtuozzo.com>
 <20260330135337.937540-2-khorenko@virtuozzo.com>
 <9e6d5484-3670-40fa-8c09-201b76cd0088@t-8ch.de>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <9e6d5484-3670-40fa-8c09-201b76cd0088@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::20) To PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR08MB10708:EE_|AM7PR08MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: c719452f-29e4-4467-bc83-08de8e81000c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Qd56lK6v7jVmxrneJQlM066TN1ANZ/vEqSuK6WC8emSvTQroWJAoopZhc4hbm3RMaDMdnxI1uD2bJURlZU0fgsvgCBFArwWtlncyhI7cM6nUiDC7Qfk/huzP6xrfcWonIRnJ+WBZ2jNZSToW29QqmkofAiybXoYmbPuxS8oDYz7gyFfDIWKO8Eg6J8cIbjPIgM0QknNdIjhD1qMV6CyvAQkXzS4ROhdDoEonXC7nn2mbzN8iEeqwLxyAytmsY7eY+faiOVA8KcxZUjqnPVMS8lyWhykBHmGg8Qdh/0SOb2Dhe+OalOy9B3sxl3cJUgfDG/4TByTQ6pQNSQt7d+Tg0pol2hNmmWaoSihlVkNzMWuWyN6juz9gbgG/iSnYVnjvozBpothgwGWrMVcoavw1hsA6YXePKiU5J2WwibuoWU7ffwpMCqZ92VB1uoafQZvE8FYK4R2i7Qt8hS0siY/arzjJwISHIeZdAL/0kZMWbkyAFIsMKmYteyrjeqL99gXXRKKwDJ5c2gu2qoDgog3Pomiw87kqgRED2+8/SmNm7U14hnLBsV6YZhwuSjdf0CHaEazHUMpJoS834Df9+Z1SNb7mKKm87SWz23aly6g82N9N859qYIbT2fau1xmE24sNoiBSy+AsLwydJ5mRRcKJ7QhSLzRjvDEd6S04ObaFQtbw8cJcT5CHefQih6BbmBgMTDgPCeOjSkK9VO59uxGviOPJ+Yyl32R/8itCr/4VKIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10708.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEJGZ21zZzdOTC9rNUU4ZmxJakpBM1dRVGxPNitOZ2s1WncxK2tZQUc1MXVK?=
 =?utf-8?B?Ryt6b0ZvenppSWpvb2dnU052aHgybDdpUzIrNnNETmdEbjExcW9lOG1kZjEw?=
 =?utf-8?B?blc3UGRsa1ZndTNGLzhNV21UdTdWR0dZUWdqTUszWFNwWGxMczBDOHhzMUpi?=
 =?utf-8?B?RWNEQkdnUW5SU2M5bWQwMXFhNWk3bkRqSGh5M0VMektOU1lRcDNXYUhRUGZq?=
 =?utf-8?B?ZjlqNmE5ZnE0ajRna2Q1NjNjbEhUeGNvVmFEbEpWWDlGY1p3di9Mck1pN2tI?=
 =?utf-8?B?cTQveEFJRVB1QTdZeTh3RFhlb29rVmN3L1VkRUJvRHhXd2wyaDdsOW1iZXJ6?=
 =?utf-8?B?VEptTUc0UnNXdFVuOUJUMGtvdHU4M2dscWpDbWw2NFBFUmYrMEpadFc5SVJX?=
 =?utf-8?B?cjNrR1BoeW9JWXpXVEpBVERHZUcxMS9HMDVUV0V3VzNDelh0elZNNUl5OXJD?=
 =?utf-8?B?ZkZIcjZCVU1MTTI5bTlrK0s3MHcwRW9PUXZSYSsrbnpxQ1BPWFgvMDA1SzVq?=
 =?utf-8?B?dWNTVWZES2wzYnlvMGxVZzRlSUpMSGsweVg5WW14aDkwMmZzSy9SK0V0NEh2?=
 =?utf-8?B?RXk3MWN3OFRmNm83NktzeGhWMlQyS2ZqVHhoQ2JXdG1WaUprMTIySzV2VXNO?=
 =?utf-8?B?eEU3ZE9NSFhaODc4TGp1WjM3QnorSm83Vkh1T0hYYWJlaXE4UFN4R2dnVU1P?=
 =?utf-8?B?eVlPUWl4UFdWclRQMkFGMTFvNGNWcXg5V1VRV21uV1AxS053dW5kWm5PQWFm?=
 =?utf-8?B?c0NzN0dnSURkUE9UQmxTVm1nU0p3Y0krRXZvOWJtRmZaRmZWT0I5UXgydjRs?=
 =?utf-8?B?R1dKc2F5TE52eXNQVmFSNHRWR2ROb2MveWhXQU92bW4wNEVLUzdEeEJjZlNR?=
 =?utf-8?B?S29xMTB6ZFVtM1QxL2lkYjd1cWY2V2xlckdWbjRjdEhvQWZ2aTBtQU5xenVv?=
 =?utf-8?B?TTNrN0l4azJ5ekhiN0c1OGhrSUVHZUo1ZnVJM0hkUVdMVXl0blZPOTNsblZw?=
 =?utf-8?B?TExLa3J3Qm5zaG1hQWUrRGxnL0VKQUh4cnZ2MDQ3aEdRTitkRzB4aWVpMFFY?=
 =?utf-8?B?V24wWVBWN2lwUjgwUGQwYTRsYjB1bHRGSHAzUnNERisxSmdqS01veFgyWHpD?=
 =?utf-8?B?dnV1SG95OTYrL0hMSXRJRDQ2L3ZVbHZna0ZFdTZyVlVDaDBKM2NKWnJvdml6?=
 =?utf-8?B?ajFUWmRINFN6UzNuZjlueGpmY3dodkNlaUhmbGJJcHdXYWZqNmxLNWpxQmIv?=
 =?utf-8?B?bUMyNHh4YzZGSGZaT0U3dEhpV2wzQWwwbXdRMUZnUWYvWE9QUEJYUy9FUlMy?=
 =?utf-8?B?MFNEcWdMRGgxYkRhVFlxTXJNUDJWQ3pBRXZzbFA0NjE5WHNCUkJTSFI5dVhD?=
 =?utf-8?B?c09rMnJqMzdVd1RWMTR3VGZZdDhrWE5kWFFxK3lJS0MvQUFVNmh3NmRIM3lW?=
 =?utf-8?B?N1lmejdPMXhlVTI0M3BibEg4VndFaDJnblo1Z25JRzlBN0xQUFY2RnlyT1Nl?=
 =?utf-8?B?S1JJU2cyaXpVbnFSelNsNUNENWs5aVBXVmpuVEhXWlNxT0JOakM4WTJKM1da?=
 =?utf-8?B?VUo0ekxRQ2JYRFZ4M2F2SDNTUG1waHpicW5XVUNlcUUwaWtpOStwdVZtYkZk?=
 =?utf-8?B?VFMwMzVUWXV4U0NRRmFFMk5rNWhQVWo1WVFPYWpNeTRNWFhlV1ZwWnN0TzN6?=
 =?utf-8?B?WEF1WGQ4MWdlV3UzbkNaaXZUVy9JWGFaRit6T3VzWHd5SXJ2ekN3MVVwaUkr?=
 =?utf-8?B?REVjVUc0QmpTTUt6VC9GRUVuTHN3a0x6UTVEMmROVTc5emp3U3FvZWVYaHhH?=
 =?utf-8?B?V2VwczhCV3RYbG41blpRK3E5RnowY090Y1l1NmVwMGsrQWxQNnlvdE1qdC85?=
 =?utf-8?B?WjBVSG5iMFJqMVp3VzlVZkNlL2RXQXY4WEppWEhkVXZoclBzU1EyakcvZTJn?=
 =?utf-8?B?QlBhdkJXWGNaTXVBTU0rYTZWM2UxWUprdDBNUzFIT25OTTVzbW82UDVyL2NP?=
 =?utf-8?B?SXZNSWZrRWw1cEdmeXV5MWpaeWZkTlVlYk5jY0V5YmhtdVBaVlRPdjFkY0ZO?=
 =?utf-8?B?YmRHMmlzVFpWMTZYVkNwS29idUNlaStpcGdVeGxTenN0U2doUXpPMXlyMFls?=
 =?utf-8?B?OFprSDBrVlk0S1ZwN1N0WVhIalFENzRldWFWelhDd1RGTDNONnRPbTlZcHNI?=
 =?utf-8?B?TmZqRW9QSHJvWlJuR2JRRUNiRmxlUWhKN3dzb01nWjZqM25rWXIxMlhrcVFo?=
 =?utf-8?B?UEdtenFwTS80SHd6NXAxcDFVNEswMWo0VnVmTytsODI3dE5EM29uWGh1KytQ?=
 =?utf-8?B?dUIvdHdpYTdsS25MS2s2YmlGR1hHajVVZENEUy9YMENLRjhlNnZtQT09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c719452f-29e4-4467-bc83-08de8e81000c
X-MS-Exchange-CrossTenant-AuthSource: PA6PR08MB10708.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 17:23:03.7286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yzLDmz0e9PRdFDxYi5V2vnGvgXB6m0YMQ2csevktbluDsoTnFickiSVj+CpRJ5x9Z3HpE5qSxUw8YPltlMbYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5352
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DKIM_TRACE(0.00)[virtuozzo.com:?];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273278-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.565];
	R_DKIM_TEMPFAIL(0.00)[virtuozzo.com:s=selector2];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khorenko@virtuozzo.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_DNSFAIL(0.00)[virtuozzo.com : SPF/DKIM temp error,quarantine];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,weissschuh.net:email]
X-Rspamd-Queue-Id: 6DEC335F448
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 16:48, Thomas Weißschuh wrote:
> On 2026-03-30 16:53:37+0300, Konstantin Khorenko wrote:
>> When CONFIG_GCOV_PROFILE_ALL=y is enabled, GCC inserts branch profiling
>> counters into skb_ext_total_length() and, combined with -fno-tree-loop-im
>> from GCOV, prevents the compiler from constant-folding the loop that
>> sums skb_ext_type_len[] array elements.  This causes the compile-time
>> BUILD_BUG_ON(skb_ext_total_length() > 255) check to fail, even though
>> the actual computed value is well below 255.
>>
>> The kernel already has a guard for CONFIG_KCOV_INSTRUMENT_ALL, which
>> causes the same problem.  Add a similar guard for GCOV.
>>
>> The number of loop iterations matters: with 4 extension types (as in
>> earlier kernels), GCC 11 can still constant-fold despite GCOV. With 5+
>> types (after SKB_EXT_CAN and other additions), it gives up.  This is
>> why the issue only manifests in recent kernels with GCOV enabled.
>>
>> Tested with GCC 11.4.1 and GCC 16.0.1 20260327 (experimental) - both
>> exhibit the same behavior.
>>
>> Note that skb_ext_total_length() is still correct at runtime; this
>> change only allows the build to succeed when GCOV_PROFILE_ALL is
>> enabled for coverage analysis.
>>
>> Fixes: 5d21d0a65b57 ("net: generalize calculation of skb extensions length")
>>
>> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> 
> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

Thank you very much for the review, Tomas!

> Would it help to mark skb_ext_total_length() as
> 'notrace'/'no_instrument_function'?

That's interesting.

"notrace" did not help, after all it just disables ftrace instrumentation in the beginning of functions.

But! i have also tried __no_profile (__no_profile_instrument_function__) and it helps!

-static __always_inline unsigned int skb_ext_total_length(void)
+static __always_inline __no_profile unsigned int skb_ext_total_length(void)


__no_profile_instrument_function__ tells GCC not to insert GCOV counters
into this specific function,
so without GCOV counters in the loop body, the loop becomes "clean" and
even though -fno-tree-loop-im is still active globally,
gcc can now constant-fold this clean loop.

As a result skb_ext_total_length() is fully evaluated at compile time and BUILD_BUG_ON succeeds.

Thus we can probably use this hack and create the following patch instead:

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0e217041958a..47c7f0ab6e84 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5145,7 +5145,7 @@ static const u8 skb_ext_type_len[] = {
  #endif
  };

-static __always_inline unsigned int skb_ext_total_length(void)
+static __always_inline __no_profile unsigned int skb_ext_total_length(void)
  {
         unsigned int l = SKB_EXT_CHUNKSIZEOF(struct skb_ext);
         int i;
@@ -5159,9 +5159,7 @@ static __always_inline unsigned int skb_ext_total_length(void)
  static void skb_extensions_init(void)
  {
         BUILD_BUG_ON(SKB_EXT_NUM > 8);
-#if !IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL)
         BUILD_BUG_ON(skb_ext_total_length() > 255);
-#endif

         skbuff_ext_cache = kmem_cache_create("skbuff_ext_cache",
                                              SKB_EXT_ALIGN_VALUE * skb_ext_total_length(),


Tomas, do you want me to send the v2 patch with that solution?

--
Best regards,

Konstantin Khorenko,
Virtuozzo Linux Kernel Team


