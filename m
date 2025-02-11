Return-Path: <netdev+bounces-165206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB53A30F44
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C620D3A04B8
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7105F1F7060;
	Tue, 11 Feb 2025 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cNg4NYod"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F813D69
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286561; cv=fail; b=KgSdMe9fbuytoDuiRaIdzWblfhtmhTrSRH09Ki7zJ/KY+LUR4ST5ruP1ytd3B4QaaWj8skh/vCKpWjAOjWx/IGNuttRsM/cECrUTNowj6J1NhXIhfYrOsH7746kaUhdXOAeUILeQ8EcY9yFCBVj59OBfHB3IUqPPuZmKOUkoER4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286561; c=relaxed/simple;
	bh=YYnG4uqQMHyFecp9baGcDsKg7sLNYWzjLMmLOAbB27k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pzCGIacpIjCPBXvR/25E9jguHFstmU4O0vz5ACSf4zLSd0Ymz42jdCwtMaddMJJmFZSSaeRDARV+nVknF/RJZikEIxMmZx62exG9/KoL5hE81su7VyHZfRQ8utNYqerC8gfUkRzJy2XgWywjeS0xO4ZGgmOSFCG7XJYw5yFr0eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cNg4NYod; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7tiAALDnpCa7rcHFwCScIRHG99PeoYU8eFcg+eJqYyGQSRzKq7jIjBxqajH4afvg7ihzzG2/d9CQs+wnh4HINgzGoLkG5AFCIAeQ5OyG/A581zecVtGfvNYGtj+/c2G1y3fKOfUZzN2kFOAkNXbarSwwJokzFyl4EwVO4BEwKUbNRfyqDynrxZ6SZOTSOixYHKzjsaDmQ95gH9OeLJF1sDjRp3wsWHaXnjnJskKtdH2McsSmq9zAS29yyikwj4xFN7f6xwePunL7p/PtDrNlDIPaC5C39SmP5r0o8dpf+Wn2ZIZQxcDIjpEzOr1Vd8ZTYYXuzz5FwQf+NQuvuFqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2Hj1jxBHj4m1cV2heoW5/s9Dc6ZW/uONbrX4Sy5hz8=;
 b=MhQ2AnvVdSSHSyAWW00aJhaQ3GmtDqf4Hwf2c6OPi+JMGCsnsSem2blDQ4ZzO54n6wDFvKoAmFV2hUk2U6ApT3VVoHUWmO05NnUCIOLsHaojvhhK4CXmfQqBGZeP/7Q5ezw7F4zeyy187PYtGNqHfby5H8q1qic0CQi4PPO42Kw5xFyMU0d66g0AVbtHoltRF+C2YgSL2BU/t0lDVy+RnO6++B5FjCEoL14xwCQzjiZOhyxhnqkUv0E4faZwkR8Iyd2weaG9xPopNw3QLBDQrgqD/qDcOBtCudHhoulYhhzQBp69EWjrcXuI1fGUK+GBKfsLRcinUlLQkNyNvidecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2Hj1jxBHj4m1cV2heoW5/s9Dc6ZW/uONbrX4Sy5hz8=;
 b=cNg4NYodA/T9vohFYxN4BSeCKEN9TSZ6h23gwWbvQKqWCxqI9JJUiGCQVMem2UVxyx6D+6XVdtSuiGC+GyfWygr4BPRWbfNowNa0igydXqlHfE72ytxbtI9AtkrhwU1GYQ2Zwizbu4/oz/DCvLW8sLJ9zvAGkilyAava4mkNy2FrBFNfttuyF/AKTG8S1uOd7+SnKzydITk+yp/jP7B8dHJKvnRSnR+j4KBOIcvlm7Yw32fi7aGH1d/29VfKowCAITghrxvHagCwxYiG0eFcRYQnC7FujJmdl6kcNVWsLjh9f4BwtLt2puNAL44LGwfQNvFKxQqN+M52xWCgPepIvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 15:09:17 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%4]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 15:09:17 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	horms@kernel.org
Subject: [PATCH net-next v2 0/3] Permission checks for dynamic POSIX clocks
Date: Tue, 11 Feb 2025 17:09:10 +0200
Message-ID: <20250211150913.772545-1-wwasko@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb8b581-9aa1-4aec-3ee4-08dd4aae0db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V05pRlBwWTBqNTdyQm1lZXlvMDlOcEZSbXlSTmM0MjlxSEdZbG9TYUc2TVNG?=
 =?utf-8?B?UkhJTk9UTTlPa0V6dGM0VUxPcjF4a2tsczFROVFWYTFnSTh5WHpXUWVXTzdM?=
 =?utf-8?B?NVhEYnZVVktBOExjbm5neWYrVXdxK3pJcFI3YkM5NGU2VGxOcU43MkdEQ1Vo?=
 =?utf-8?B?ejhDR3ZKU1RNMVJ6ckgxVjh2dTlLYWpLdmx6cDNjQVN2MjVtTG5KWS9QdFpO?=
 =?utf-8?B?SGRndEgyR2pCbWk5bEY5ZEpuOFZkNk5mT1NPMUJFRkl2Ym9sNUloVDdCendy?=
 =?utf-8?B?UXhrK1RvRHE4MmQwb1h6ZnAwVkViQjZjUUpKeTBDNG5xb2pkVVlic3BqS2Vm?=
 =?utf-8?B?dE8xdld1L1h6bW43cE5YQ2UxdXJ3V3lQVUE3TGxqTmpkT1lWT3JlbEVIL2Nm?=
 =?utf-8?B?QzYxRUxmUFcrTlhNblRHcWx0VDliT1NDUlE2N0JLczFjSktyRVIxVjlmeWhI?=
 =?utf-8?B?Ti9LbHZmUFFZTHhKUkFMOTQ4c0dETXFyNFR1V3pwM1l2VFM1dVB5c3ZJN244?=
 =?utf-8?B?R25TcFg5UG1BOFVzRzlNUWZaRWJMOXJPOTJibXhldkxnUWtNVGt4Vit3QjVN?=
 =?utf-8?B?NlZkTVNSdlN4SDM0VHZPTnBuaWhQSExtK2U0M0VlN1VEQmxsTTdyd2ZCUVZU?=
 =?utf-8?B?WHVLTjZ0RHhpbm1LSmZDNXYxSlY1dXNLWEtuVWZVbFNFN1k5ZkhtT0VKUXEw?=
 =?utf-8?B?eCtRckgvZEN3QUI4bDN4aDV6cU9FSVlKOVBYeFpBbnkrVVFHbmNNSi9tMkMw?=
 =?utf-8?B?MmdpOERlbGM5bzhnSkJwTXZxR2NBQ1FRUm5pbVJsd0tVVW52SnBrQWhxcFhs?=
 =?utf-8?B?bFZuRmVDVGVBNFk5bGFyR1hBMW9RREJoeXBIMVM1eXZPV3c0NC9uL1F2ZHhY?=
 =?utf-8?B?dnhZMWNTbFJxQkRyL1NHM0dsSGFQL0ZZbmVxd3dNcEdtK2RMdWxVNHJObHp0?=
 =?utf-8?B?YWZKMk1JRFRDQTJTdFgwVlBkTi9sd0ZOTm9nVENFR0hBQ01aQ3dWbFAxSHBD?=
 =?utf-8?B?UnFSdkY4VlUwYUZTSEtCLzNaQ1BWUy8zUjhiTEhyY1k1MVJsQzhpMFpjYUdi?=
 =?utf-8?B?UHA2d3hLVFVJTVlGREthNGIvemZEdnYreWZzSmdYdnU3QmFOcTVvbXZ2V2NV?=
 =?utf-8?B?QjhNdU1ZMXRKeHBkSS9RTXlKOWFQUjhIU2Z2VDdzN09BWW1jRGxlYkhNQjBG?=
 =?utf-8?B?UkIyNUgzNVVXTkQ1MXAxeUp6cXM0WjhVVXlQODMwc1RmVnh6MEdzZU51dGov?=
 =?utf-8?B?bWJ2RGMxQ2FQQm1zTWpMOS9ROFAxZHZVYjJHTXFOZnhIWm52ZjZqZmExS2tG?=
 =?utf-8?B?ais1dHNvRXNwdlVpVkIvQ1ZFaCtQb1JNR3dBaHJvNnorblk0OFZ0dU4xY241?=
 =?utf-8?B?VzZwMUsyNWxoelhuTStWcDVNMWxCR2RPS21WRGs0U0QwN3JlR2FyRUdyY2lI?=
 =?utf-8?B?RmQ4SkFZdDBLbUlWTTZTemp2TFI2SDN1UHF5VDZPOUt1V1Rnc1JCa2d3bUJp?=
 =?utf-8?B?MDRYWUdCS3V5d0dsZkJSU2ora2liSWpkdy9VeTUrR0M3djRXQkxxMFZaQnFB?=
 =?utf-8?B?UWxxSkRGOFZWaWNSZ1lTSSs0WHlSQWRGSlFuWmI4aUtaWDVtajNGemZEWlRo?=
 =?utf-8?B?T01xRnFrd3h6WXV3cVBVdmYwL3NTVk51aEtuNFBpVTVZRkJPNFdjd1BkSUpj?=
 =?utf-8?B?UWVndElpV3ZYWlF6VzkvL1dhZFlCbFMvZ0psY0l6S0FMQmFac2RXRnpjZmlV?=
 =?utf-8?B?ZytWdzdnVmRzRXBRSDRteU04dllFdWdneDJQelNGendKTmtFZXcyOXoxWVVM?=
 =?utf-8?B?M3VZcHM3cEw2Wjlud3BaK1FReUhDRFBMYUJPODJUcEVrQ1ZHdlpKajNBWHgv?=
 =?utf-8?Q?2AFFEOQHGT6zH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmZyaENCZHhPNVdmdHlsV2xMSlBGaGorbjhEZ09velpOZWN2OGsrNmFoWUhn?=
 =?utf-8?B?YzV6WEtvb0FLMjFiRkNSS0NMd1JzalBIK3VQMzgreEg5Ni9KQjFIaGg1SkZh?=
 =?utf-8?B?bHdnbFMzZHp6WGdsb2MzOFRSc0wyNmx0SzdYN1hpZVdaR1ZBV2FXRUExT1R4?=
 =?utf-8?B?QlltUFp1WE5iR05tRXBmT3FMd3BYQUJrK2UwZDdUanVpaGhQcEZzaFNqZ3B2?=
 =?utf-8?B?Z2xrellFZXpvOFh2ZWl0MjQwajRLRW4ya1Bac2t0dmZWdlFqWldzYVBDV0R4?=
 =?utf-8?B?V3d4aDdadzNYa210akdhNFpjcXFNblJ1NUNMcEtDMDdmWC9obHg5QkdwcTdk?=
 =?utf-8?B?cGJaZVhDdEZINzhKeXowVkNGeHFxTDJaQlFsNUhXb05pb1N1dDZBNVY5aktW?=
 =?utf-8?B?WEloZzJhK2xycm1jZFFrdXF6b2UxTFJ0bWJNZXg0R3pvMEEvQzFWOXhDZXBp?=
 =?utf-8?B?RklXMXZPa2RwajVMcnZiNHl6ek9xTTJBMHM5ZEF2TmkzWnNMalBVdmJ0SDZw?=
 =?utf-8?B?VGVjeGs5ZEV3bElITkdCeG9OQ04yVkNUMjIwK0twUWFRZEZyVmlqN082L0NL?=
 =?utf-8?B?TU5aTDRabHV5Q2l6M3ZWeXpBbHBwdVg2eit1TnAyeTdaQzlCUmYyVisvQ3p2?=
 =?utf-8?B?eXpNY2NnN2R1VjJkVVdnMnowZHNrblZuR054V0cybm82Y0UvblVXTExGNzhK?=
 =?utf-8?B?R1VoMU9wTGxKS01TU0RZaXdWNXBiaVRZWVJmNFRLbGpNRTBSRUt2VllJdVYr?=
 =?utf-8?B?Y1ZhVU00cXNBbjYzekRYNmdzVXZQL1RqZ1JSWnZkNWE4TlhCVVl1NWs1K0VE?=
 =?utf-8?B?NVUwdDMrMW94RWRRMUl1TlhqblMwVGFQeFJibTNtTEo0ODFWTVJwRXNKQUR4?=
 =?utf-8?B?OFZpZmd0ckd5UlFORytPeGh4amFiZmtGNjJFRU1FdzI0ZXJ1aHJmc09ueDRQ?=
 =?utf-8?B?b1RTNU12UmNhOXFjK2lBZmpQUVFyQmxOWUc1K3daMVlVeVo0MjB3UllrL2t4?=
 =?utf-8?B?d0ZIN2JFUHZKV1VWNVF5ZE96aE9GVEVZVTFkMm9XWnFUbjVuS2o1SFVhazJj?=
 =?utf-8?B?U0RDYlpTNTVvSUhvbjhheXdDM1dIdDVBZWNxTzJUSWptN1JzS1dwU0VNRnJw?=
 =?utf-8?B?WlczWFc0VG90dENiUUhtWVdya0kvL0p2OEZMQTNHa3NjNmIxazBYZExCb1ZW?=
 =?utf-8?B?Q0tvc1JtNnQ1citGQmZ2RmRKT3pGbGFxeWZEY0Rla3ZUMzUyWFMxbS9DVDhk?=
 =?utf-8?B?MmtKQ040dFkva3BKY1N4U29DWkJQZm1pZ2VIcnZtWExKS09maGxqZEI3M1VB?=
 =?utf-8?B?dVlmbDhYU3BNdlVQMWZZTnJGanM2UmxERXNLU01CVlAxelA0NjdqTFdqMG8y?=
 =?utf-8?B?alo2d2RrZUJ4Yis1L2RaYy9PTEtDdTJhMzZhS1RiTm5LVGVpZEhBWm82MXRP?=
 =?utf-8?B?M0JtcGN1YmE5VmJWRHZWNU5IOU9VakRaUGtzYnoycWxXNWtuNzhQWGJYRDM4?=
 =?utf-8?B?Yi9pQm1ZbFNPcFJVY3RMSUY2cXg3RG1lNUd1Q0V4V0F4NHFNck0vcGplYXJZ?=
 =?utf-8?B?My9sZWR0YlhLMlN5akkxYzBQa3dMK1V3QnZiTWlnVGlxSWVBcVhRbGpaSjN5?=
 =?utf-8?B?OVdWRDQ1TEZRNGE5V3RibDNuZ1RxeTJxcnRYSVk1dk13Y1IwbTVVd09vWmdO?=
 =?utf-8?B?aHVwclgxdmlnN3ZjeUYyRFowaEZVcWRDeS9RV0ZmV0hiZ0ZNZUt0dVhmUm9O?=
 =?utf-8?B?MEVYc1krK2MyeTZqOVM5R09QQkllZ2lPSTNiWVVKakZxd2dUeE53Z2hBbnc0?=
 =?utf-8?B?SGd0aFFxcmVlamxkNXBIQkRycFB4SUhUR3FJM1JmWnR3a0ZIOHJFK3FSTDBH?=
 =?utf-8?B?T0JuM3o3MGowNnVMNkFvKzRCc1ZsaXJCNGV3ZGZEVkxabnV3QUM4MUpoYTBC?=
 =?utf-8?B?eVJLZGwxT0FDbjNvNTlLd2c5RDJsZkhhS0tldVh5MnR2ZjhjdDdFby9xbC9n?=
 =?utf-8?B?SXh2OHRhYkhrWWhpRTN5STdGOTlzUTYrcTdjQU1Za3cyZjlVQnR1VnZ6Vm41?=
 =?utf-8?B?RkhHUWEwTE1ocUhabHBIdUVFRWgxZUtWdTRhbTA3aTBGQlhQR1BWcTdHZnhk?=
 =?utf-8?Q?WWw4fgreDJ/+Hszo4vCo3ep4Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb8b581-9aa1-4aec-3ee4-08dd4aae0db8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:09:17.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkvHlpXmpNnx6WrkMe6QAeDKIPhTYWAVN6iBpRpP/pOWE73ECz6QQ0NaBDS/3HFtLhG04SUIZCLtPjqOhQcYpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357

Dynamic clocks - such as PTP clocks - extend beyond the standard POSIX
clock API by using ioctl calls. While file permissions are enforced for
standard POSIX operations, they are not implemented for ioctl calls,
since the POSIX layer cannot differentiate between calls which modify
the clock's state (like enabling PPS output generation) and those that
don't (such as retrieving the clock's PPS capabilities).

On the other hand, drivers implementing the dynamic clocks lack the
necessary information context to enforce permission checks themselves.

Add a struct file pointer to the POSIX clock context and use it to
implement the appropriate permission checks on PTP chardevs. Add a
readonly option to testptp.

Changes in v2:
- Store file pointer in POSIX clock context rather than fmode in the PTP
  clock's private data, as suggested by Richard.
- Move testptp.c changes into separate patch.

Wojtek Wasko (3):
  posix clocks: Store file pointer in clock context
  ptp: Add file permission checks on PHCs
  testptp: Add option to open PHC in readonly mode

 drivers/ptp/ptp_chardev.c             | 16 ++++++++++++
 include/linux/posix-clock.h           |  6 ++++-
 kernel/time/posix-clock.c             |  1 +
 tools/testing/selftests/ptp/testptp.c | 37 +++++++++++++++++----------
 4 files changed, 45 insertions(+), 15 deletions(-)

-- 
2.39.3


