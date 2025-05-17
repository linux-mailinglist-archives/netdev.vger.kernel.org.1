Return-Path: <netdev+bounces-191301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF3EABAB30
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 18:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB603BEFD1
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 16:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C131FDA97;
	Sat, 17 May 2025 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b3EEhLxd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rqmh2xbP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60F1DF99C
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747500027; cv=fail; b=e8h3yBH/0AImKFAaAr1hMkMfB+qEw+BrHc9G5i5lIXHffcelJKTk54PhVAd8UzHmQFpiq2yks3uRZr7h8df2jk4LcTJ3fRNuzIhAPgFQT4n3uv2eL1rxyV35+Q5BZ9wvzKYcGbvpp+P+gG6+KnRz24vI02EFOlw5SqGp3mhMyrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747500027; c=relaxed/simple;
	bh=6HvrgI/DQABxKVK5VoP+6lOdWYGj0EiKh+BTjd3dAag=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QjhfhvjxSwIbweieYG5/CimeLTdXx7+GJAHGo/DBqpcSjPM2RTSc+FWOeOLrJABWR4JgH2ZQa8mWyU2cGC6eqIQo3YOiSBQ5d+srBLJP2Q6MKe4q7bEAKq+asITfZRy5EXiLTDXgtC60IvfOTLMGGyc9a8Ed1i5zq9OTdUdhgtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b3EEhLxd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rqmh2xbP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54H3Ouo4000833;
	Sat, 17 May 2025 16:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kz74CTOYTcfJgekPCRFSpd1VtePw/uX61qTi4nj1xdw=; b=
	b3EEhLxd+Jc07Nntl3UVhrFdpvaQeSKhs9HJOXv9VMLL+1PH7AQrYxlXDps8HwI3
	1kDeAY0gdycHwWdHD0u16MapN58OlA0wdfwk2W49fBwS9sVBlXrMEK30KYuUwuFk
	ueJEUS+8260XPEiksmAPXm2gX8p2wrfj/95uuskXYnnO8pEgWh2vyi2G8H1DfrmP
	J2rb8J02KEnnUPxuKffzJFSVBv84HZrj3Ba1SYHw8XzzZPwCJW0HLmRan3vhwUvW
	tU2qx2fTKT8xSDE8QbX2bRZMA51ZE1F+xpZ2sHtg1oiYZ0wMqITChpaXzE72itKG
	oV967WpzzDkC01KEaddh4g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjge0em9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 May 2025 16:40:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54HBKig1029084;
	Sat, 17 May 2025 16:40:02 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw53v51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 May 2025 16:40:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOWntVl33WrJ+VBfhrpfC/lVLr7cvXPSLFsfzIMLdT7FynceBaaMJREj8q1XQBbK0Qlo+uArlq71MDX0NL/vgnY25Hryhn9/3sRGwGTJ2NaZIjf8n69MZz0p6QfOql0jhczjm/NQVbTL6XzvtsB9ir6KYELb1m9LI0nfQXXVhXqohFQEg5PwHk3qAlxiwGa4/nyjRgWatb0nMJPHdPHcQEid7U7nh/0TO7xGFYvSsoBE20IxZfrvU4UhR/l0lXP4bl7Xfj/AWk3y/LDNrrZR/fwDZyp4FKyYoOK2HXg7pPJP2V+SYpHLgViPbcqBt5RbJrU2DUxayYTwUUFKnZlldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz74CTOYTcfJgekPCRFSpd1VtePw/uX61qTi4nj1xdw=;
 b=rQPeI93W1ThKsOaZ0d84NIco/l6STQJakItmOOHjx82uaGL0eWeb30M7QwgRq49Cg18AcaA5KXhZI0z/VDdB4skT1vfT6cEIGocCO2BU8iB/oola6NR+sm4pyovOoviM27DgGx+opkP9MXncqhmy/YPrhfEM4AQJuLcs8Xk0u7A2rkqlYC2Um7gm4lzASm7gkQ7Ywl7CPHRZimyOa/y0kFJoJyig86tv3rA2ROOOoxfbq7aEKfppbYwpOgrQR/stVzHiTcvRiMic/y0s4AyTb621CX5olBlvQ/kJcTbv6gIaIeieh/n8YJ4Hq+DKNFi7v0XRvZhU+jlxa5NCkwdCYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz74CTOYTcfJgekPCRFSpd1VtePw/uX61qTi4nj1xdw=;
 b=rqmh2xbPXcl0pt1PzmKLdJ+rujpvDBZgKwHms/R2uTiIrugdIvIDKWrlHEM5t+BAeWmxg6lWftlMvdW40WvZLRY2+0yzJCHDozLFrOrmvWaoJSjCpX5y5mjcoIyrUTCdRecbwUkOkDvJlQKxZMI53ZsY5OpPYy1aCWRLXxx0EzM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS4PPF6C5A39D55.namprd10.prod.outlook.com (2603:10b6:f:fc00::d26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sat, 17 May
 2025 16:40:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Sat, 17 May 2025
 16:40:00 +0000
Message-ID: <48aaf181-b7cf-45d1-ba60-bf90ad45d842@oracle.com>
Date: Sat, 17 May 2025 12:39:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: RPC-with-TLS client does not receive traffic
To: Jakub Kicinski <kuba@kernel.org>
References: <0288b61b-6a8e-409d-8e4c-3f482526cf46@oracle.com>
 <20d1d07b-a656-48ab-9e0e-7ba04214aa3f@oracle.com>
 <62cbd258-11df-4d76-9ab1-8e7b72f01ca4@suse.de>
 <7014c4fa-fa99-45d4-9c3b-8bf3ff3f7b38@oracle.com>
 <20250516162716.340fb97c@kernel.org>
 <8ABF3663-1BDD-4B87-8DA5-AB39774B1B89@oracle.com>
 <20250516165355.6efb470e@kernel.org>
Content-Language: en-US
Cc: netdev@vger.kernel.org, Steve Sears <sjs@hammerspace.com>,
        Thomas Haynes <loghyr@hammerspace.com>,
        kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
        Sabrina Dubroca <sd@queasysnail.net>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250516165355.6efb470e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0038.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS4PPF6C5A39D55:EE_
X-MS-Office365-Filtering-Correlation-Id: 5263f443-8d9a-419d-47ce-08dd95617712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MW44VlBleFdTZ2w5UnZJWC9uY3lMWU1OZlk0SXFuM01YVXRqYXVrSG5HejEz?=
 =?utf-8?B?UmFNQTJuckNpNkVKWUJhaUxjUmpjVWFidXAzcGVyUXI3TTROYmVkcWRoN1pL?=
 =?utf-8?B?SkN1eHRnLzNyLzNUWWUvVE9pRHBtU3VubHg0aDFub0trNGp6Q3FYUEFnN1Zp?=
 =?utf-8?B?L0dKemg3YnZldkdWNWhOeWxSdlVsU2gxNHpPOTFpM01ZNEExVWlKKzVoM0l5?=
 =?utf-8?B?eDl0a2tCVTNpYkVRbC92UU1LdnY0RDJNWXR5SDB1YWw3VStqZ2U2MU9OL1Mv?=
 =?utf-8?B?YUdaUDdGS3ZwVnpWc1NOVGF1VnkzM2s4akE0TEZEUmxwREF1WjAzakJvMzFn?=
 =?utf-8?B?aXJJYTRTN0t3Yy9XMDZlS0pSYVhkdmMrTTRDN3VpTzV1VklhNjFFV3VDMGMy?=
 =?utf-8?B?K2RSZjNFU1FlUGJTSDY5UWwxd3NUVnpwTTl0cGd3NTVLNkdycFNNaFN3Y3Z2?=
 =?utf-8?B?WkpWZ0hKZ0lZZHJZTlAwS285NFJDN0VqWExOamZ2TGZRcmpHeFpCajJOMlBk?=
 =?utf-8?B?K0lrdzNuSmhja3ZEVzVxbGNWVFZhQW5xMkNBeTQyN2NCeFFYWVZ5RDVTdmM4?=
 =?utf-8?B?M3QyYm5aczdxZzE1VUZ0ZEw2WWhVMWtFWGdQOWpzelhWZzNwTVhySjNRWHZa?=
 =?utf-8?B?ZlBxSWJkZTllY2RKWDRnRE80WllsWDdrN1FoekZZcnErN2NGZXoycGpJYi9D?=
 =?utf-8?B?a3hsNFZEWGd6bjFheE1uc2d0RU14b29vcklJS3dmbG5vMjZSeUMySml5T2Rt?=
 =?utf-8?B?aEM2YTlkTjdRTlVqTTY4SUZFU0NVWnVCUVhJNWlvWUpGWUhpbmVTS1M5cEdP?=
 =?utf-8?B?Nlk5UVE5YXczRjNlNHlMdUMvQnhPUFJYNmo5TExBbkk1ak83RG54RUhRYUtm?=
 =?utf-8?B?N2VIYUdLYTVoWm1IT0VTcm1rMW5pZFYxL2VqQS9uUndzTWZQdlNLN1BDWXhY?=
 =?utf-8?B?dUExNVBlUG0wQVpmQ0lNSXVQWktuMnl4c3o3aGRqeTZxZVA4YlFlTW1UbWF5?=
 =?utf-8?B?WmxhcHo5MGhadU44MldhY2F1NGV1bWd3RnhyaVE2MmFKeWNxZ1I1SjdLd0dR?=
 =?utf-8?B?b1YzdlgrdThGNkUrK2x1K2IwMDU5TU1DMzdZZUUxMzkrWDMwM1ArVVJrNDg3?=
 =?utf-8?B?dDFObS9jcjJXUGp5T3FneFR4L05ZTTRFRGc1NE56Z21wd0FKb0U2cGtiN3c0?=
 =?utf-8?B?WGRJcDRsNUdNQ0h0Q1A0STJ1TkpOa0puVVdCSnh6d2M5NWx6bmlXM3VsTlpC?=
 =?utf-8?B?c2xpT1ltWXg4ZExRMHA2dDF6eHp5OXZkMFIxSkJRY2tDbXJ5TTRyMUpyTG12?=
 =?utf-8?B?cVBQcHJkRzlWcTZ1cUVVZ1g4SVB2Y2ZwS0VtZ1BDRmhzM2FHMG1tWENqK1Uz?=
 =?utf-8?B?UVE3SHROdkpBVTJtNFNlQy9LTjRFdlZPT0VQNGJUL01pb2xvaUJ5MThRVVZO?=
 =?utf-8?B?YjVBR2NQU241MXZBejJFajZmd2VsRG4wUFZxUVhnd0xpb0tmcW1zU2R1ZTNj?=
 =?utf-8?B?TExLdnRQQmlkd3d6RFlGbURheHNiUHBQTVZuTW1xMzdNVXFYdGtqUDBXK2FF?=
 =?utf-8?B?VDJPWjNyRnNjbkZGb1gzK1ljSE5QNjRLbDFpV2tVUFIxMDBsU0QvYlRYMUw3?=
 =?utf-8?B?R1lyWXBFL0tBeDVSbUdkS0lnL2hReFNIbndiSEtXNXJyUzZOM0J4SThYcjBo?=
 =?utf-8?B?dHZRTHBKU1dNNVVKZ2wyMzYxZTFwN3grZm1tZFhqZ1h3dDdpdUUra2o1V3Q4?=
 =?utf-8?B?NnMwYTYzNmR1WmpuUEUxeW56N3pWUkVKVk92YytmRlhKVFdtVFNtL1RmQnMv?=
 =?utf-8?B?aXZZbERTVWN5bjhWK0tocTd2SUNSSkl4RDlTTWhGTlo4MXczVzdVWHhBVThH?=
 =?utf-8?B?TWNLU29ya2p1U1A1TWtzSzNrWWhqTXh3UHZZYllVTXpOdGN2S3lnYkhld3Bl?=
 =?utf-8?Q?0s6b4E7JfVs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmFEcTFpYSsyWHlEcFpBM3lTc1A1RVdpd3JWUVVsTVUzYnF1RDZUeFZNTnJj?=
 =?utf-8?B?NWRZTVlwd3pQL3pGVTJaQnJ4YVhZNnJCRWZJTEdieGlOUTJqeDY0S3ZaeHpO?=
 =?utf-8?B?T0hQN0VvNWNqUllyVWtWcmNiRzM0c01GSmNkTUtROXVxVDQvTHpUcWcyeUkz?=
 =?utf-8?B?QjR3ZVJLVzU5UDBFRGlTbVlxdWlmV0RRNitSbVFMb3lFZkJqb2xnNW9naWw5?=
 =?utf-8?B?elAwcUF4ZnVTOS9PSXdtNUJ5dE1ZL3hRNnVHRTZwMDBEM1ZPSDdjUTZzZDEz?=
 =?utf-8?B?cm9pa05FRE9mdmhWVE9kMnJrZlpPUTg0Zzl5Qm02NG44aTQ3dFFlYU1LYVVv?=
 =?utf-8?B?N25OclFUUGVYUDZxMnBwT1lWMnNOYW5hZEcwUGczVlBuZHNJc0pVdVF5TjE3?=
 =?utf-8?B?a3ptSXdLblZsempvendRL3lYcjIzcmtQdHVGdFFNeFdoZVc1RXpWMjJBcDhC?=
 =?utf-8?B?OThYcWdZdHdjYTJBNWNCR3FtYmVwRkhYTmo3VksvSGs3MkZJWjFScjZlNEl3?=
 =?utf-8?B?ZVN5Y3JuUnJxYTQyZVROR0RYeDl0Y01RdTExSXZGWWduclVlQzQ2cUg5YVRt?=
 =?utf-8?B?SXpWajZnckd0aGZIVWxyWXVSUEpqUzVXZWc0Q2cxYS93ZC8xVUpGVkVIeTNa?=
 =?utf-8?B?UmhRMW5wUlpOWTdWam5QQnlTTE1GZ2ZZWmhYdFBGSVJQM2pIc0FYd0JuOUVr?=
 =?utf-8?B?S1pBYTc3YXYzNGZTV052VFIvS3RBTHNVRzVmMXJJYXY2SDI0bVdSWmZwMjd3?=
 =?utf-8?B?SHYyTkVQN1V0ZHkxNXQydFF3MlNkUVNGdW4zOXB4b21TdTJwWlM3c1J3ZG9h?=
 =?utf-8?B?aVFyQWVVVkpoc2lEUHNsb2kvSm5YNkpBRmhpcjVUcmZvRGYzL1JMYXpNNmpx?=
 =?utf-8?B?d244dnlqWmNycjFYVFlObTU2SnV0dDlBL3QrZVNRdHYyVlhXQXhRcWI4ZzUw?=
 =?utf-8?B?c0VlY0NhdkZ3Sm11amdzYlF6QWlBeEF1amV2Qk9ZQytvOXdFSENLSFFpRkR1?=
 =?utf-8?B?MkZLUnhTS3JrWThSVFVQMXk1cG85WTJzY3B6eUU0NFE2b3FDbnYwVEwvczBR?=
 =?utf-8?B?SDB3Q1BlN3hzY1g0citGbUtScXJmQmtFeUpTNzJlb0EzbkhLM2dxUEVEc1g4?=
 =?utf-8?B?SXkrZ2ZHakw3VXpFdW5kMUkyUHJQTEoyMkNuNTdXSmd5eUxiYkJCQWkrNHh5?=
 =?utf-8?B?OVRUTzZKWUN5Q2xRczl5dXJwRi9ZeTNpamNVdmRUQlUxNEVxbmJsdjUyNVUz?=
 =?utf-8?B?WUQwa2FZTm9DbVVYQnVvVlpDWFpURitsZmU2Y3Z6dTJzUlVHRXRYTFR4Rm1m?=
 =?utf-8?B?dEJWdmRKSFh4azBQaUJHQlRabzdOQU5oRE1kY1BQb09jM0VkZW5XbzhzVDZD?=
 =?utf-8?B?U1NVNkJqM1M4bndjRVdaMTlwWnBlakNaMFc3cnp5a3FjdlNLMVg2eC9LOWVS?=
 =?utf-8?B?am5RT3BtQnh5ekVVT0pXSzkwbWI0TnNlWE9yVXArcXNnOGJNTGQ2Rk5ScVlI?=
 =?utf-8?B?QVZTVFRJTkkvSC9VbVVydUcxa3E2U1gxbEdYOWJieTFKS2Y0UVZzQ1l3OExZ?=
 =?utf-8?B?U3orbXJPNnFvbE5MR2p6ZGRucjVUQThLTGdLUUQvQjVsWjZ6c3lqYUJ5MVVk?=
 =?utf-8?B?K1VyUzAvQkdyMUVyRUdZTmxBTUtEZXRyS2dGN0ZVTVE1ODV6UkVIRFUrb0Z3?=
 =?utf-8?B?SE1MdGtLREJQTzU1dnQrcmxQbW90cGFhamJYWmtEVWJMQUlLelVZaHJTM0tH?=
 =?utf-8?B?dnlyTVBpZDYxeDhjRjdxQkxRZ3NONGJHS0RGT05qckVwbXBWaytkb0lJSkdo?=
 =?utf-8?B?dWFaSFRETTJ5UVZHVStCckx0V2RoTnlSQ1pGQklkOUl2SzVvSjdCMkNoNStq?=
 =?utf-8?B?NnNiejk0QzI4eGFxRXpqODdxa2FtVVQ0dXBKKy9xcGhFdnhId0p0T3VRRks5?=
 =?utf-8?B?ZEQ0bnVsUXkxWi90c2tIRmlDNUUrL1Nub29WVGQyU2NFd05OTCtSbjE5Uzhj?=
 =?utf-8?B?UFlhbWV3aTM4Y2txbDZTMWF4TmhGN3RnNm10K1lWTE9vYTMwb0lJdS80Qys3?=
 =?utf-8?B?U3RNTm9qQ1BCSnl0L2NaM2ZiTXducTFRZVVPQk1aSzBLN0hRU082S08zRjAw?=
 =?utf-8?Q?GNTO37czHi14KZtiTTEqT7sgj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t8k2esAM5ovIeDz10mV46PNwkL0TR1bGXXUvntCo7Fa6x44jbcWUXKhX1xhpBg/Tk5MpyDFNsFoOa3nzV8kDl8ZtXaZuqPB62mPxNURGvRpZr3kKOzdM6GNiT+6pBkyaQiwZ2Rjsar1+NkiQuMIxBeTtM5WR7FHso1K2YpFdRicvBfLZlcUcoXNDOvia7iWzQzOaJdgv0lrtoJCd9JP6EsQNmjqcsF8luXr2weTAgl00mGOpNy9g1SEzkWrgoyjYt3mg+Qt/abBKz1HzgmKbppU1CL/S65pvYSo2vRee9TUVCeFrW7FmaedZzlMo4bToXAhy7iB8l5B8vwSnBUpUtQU6lQ9ZwPToG/GmxWcxgEb+Exa46Ca7BGx7/pLH/xjzab9z1bSx6BDdRakQqFDBbwxdIIw8K5HQRUlXxfO0kKuvVJ0POd60bGcTqEJD5MTHw2R1HgDFsGpOTjHNA38+UBbtCdUjt/lfVqIavASzcHC1kHqr0BHkdBYzxLB66R0nhOtEVL+ovEwgunlOXrNadp0dIohgTGOC6EvJxo/Q/wQstDcq8SaHLlePznFVUiiNzlPAG2W0BDlQVczMFDIUx439mtG+RlmLD0R+zrjVoSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5263f443-8d9a-419d-47ce-08dd95617712
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2025 16:39:59.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJB1f4oh9nWmfYNd7YG6MGjhbceBP8fkK5u7CO69eHkF32Vp8M0LrTXpaWcv9d3AV+zLNETXozdjYSZGbgbceQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6C5A39D55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-17_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505170164
X-Authority-Analysis: v=2.4 cv=RamQC0tv c=1 sm=1 tr=0 ts=6828bbe3 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=oGgHy-b2bHzLCiE--38A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE3MDE2MyBTYWx0ZWRfX+Z0uB3vbkMB/ UiCC7MuW0F8g+7sImjQnV9OA5cx5YV7zdgFQlX0ZNpaB2vCJqPJypNexbagHPRiUkgIv7Zzi5Ec N2571Nr59dxYjJyuRUpNV5gRg8Y5TrGril1TyfTdaDXjMQM9cJRbC3pZSg/55hfpVG+P/PLZDIb
 z/oIGJ9B4iC9/V/U2sRBWoxLlbP0k6U5BFUdYXyedeM04Z3vbZxK2KkQ5VptCUTA5Oh9jM9M7fr 3TJC2cdDUSsVVQoKqybDXytXvBdyX7vQawq6TiCbNLHsOYYgp+atDKspPBC0vUvrAveaGOFlVJM ZqaIW8l6svg7uSh6xf3p02qAmbYaRjpyRAEWeFqHbZtx0JeCI9G7bp3KDraXgxPxjxM2ES7zxV6
 ya80eEZhMF7jldeIZl99nCMGsxBSaC+fa5R/mXv8uyviIkSr1HkdmtE5YkN6MMPYFJM3NXPF
X-Proofpoint-ORIG-GUID: a9aaStRzjeupErcQoabwjPKrPWnpx04n
X-Proofpoint-GUID: a9aaStRzjeupErcQoabwjPKrPWnpx04n

On 5/16/25 7:53 PM, Jakub Kicinski wrote:
> On Fri, 16 May 2025 23:38:18 +0000 Chuck Lever III wrote:
>>> ﻿On Thu, 15 May 2025 11:05:21 -0400 Chuck Lever wrote:  
>>>> It looks to me like the socket callbacks are set up correctly. If I
>>>> apply a patch to remove the msg_ready optimization from tls_data_ready,
>>>> everything works as expected.  
>>>
>>> The thinking is that we can stop reporting "data ready" once we have
>>> a data record, because reader must check for pre-existing data when
>>> starting to monitor the socket. I suspect when you say "everything
>>> works as expected" you mean that the next chunk of data coming in
>>> wakes the reader and reader catches up?
>>>
>>> Could you point me to the exact code path that handles the callback
>>> installation? Does it handle a socket with data in rcvq already?  
>>
>> I’m away from my plaintext MUA at the moment, so HTML only, I’m afraid.
>>
>> xs_tcp_tls_finish_connecting() is where the data_ready callback address is modified.
> 
> Hm, yes, my intuition would be to add a xs_poll_check_readable() 
> after connection set up to check if we raced with data being queued?
> 
> IIUC sk->sk_user_data is not set up when the first event fires
> so xs_data_ready() ignores it?  We can't set user_data sooner?

I think the answer to this is that sunrpc never sees a data ready event.
The value contained in sk->sk_user_data is therefore irrelevant.

Because tls_setsockopt() sets strp->msg_ready, when the underlying
socket event arrives tls_data_ready() is a no-op. That terminates the
 ->data_ready call chain before xs_data_ready can be called.

The handshake daemon sets the session key by calling tls_setsockopt.
When it hangs:

function:             tls_setsockopt
function:                do_tls_setsockopt_conf
function:                   tls_set_device_offload_rx
function:                   tls_set_sw_offload
function:                      init_prot_info
function:                      tls_strp_init
function:                   tls_sw_strparser_arm
function:                   tls_strp_check_rcv
function:                      tls_strp_read_sock
function:                         tls_strp_load_anchor_with_queue
function:                         tls_rx_msg_size
function:                            tls_device_rx_resync_new_rec
function:                         tls_rx_msg_ready    <<<<<

The next call to tls_data_ready sees strp->msg_ready is set, returns
without doing anything, and progress stops.

In the successful case, tls_strp_check_rcv() simply returns, leaving
strp->msg_ready set to zero. The next call to tls_data_ready can
then process the ingress data and call xs_data_ready.


-- 
Chuck Lever

