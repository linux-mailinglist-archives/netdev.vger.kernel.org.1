Return-Path: <netdev+bounces-166740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AC1A3725E
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 08:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC84D3AF1A9
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 07:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A624323BB;
	Sun, 16 Feb 2025 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GxMXG/yO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A47A2D
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739691468; cv=fail; b=Esx9tcAYeqhmezUZg6xFfLEyua7cuNAbCW/uxkGM8CcHKPK8VqDFuQyB2g9O59C74L3ja+sbcURydzI83uWee3LvfYi0zPR+QXurxHRBhF3oXHa7nIteMPJIwqhjUeVCjcjRbtabMDZAkcg22K0ddhNDoXaITHjhpqw9GSP9VuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739691468; c=relaxed/simple;
	bh=ZuYL1UIKuRqKwU2uGUq/OgfRn/6cjnce4fK+j/QquRY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=geNAOtOAgc3dC+WMXg22SKUS0K87DAN/bKBCedCIWNqFL05lghmzH+QtW8xHMK3AG09zR3U3Nx/NrtH7NnqktwoGoBa/ZejyM3kArMK+oZzbXU4+KQJE8OFNFUzuRaCPvXzpcXerXpyfK+aLklOjTpi50yi2R2L+CF5nayBkTXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GxMXG/yO; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0j8KWbDn1QHH5Gys2M154VB3a9t7ysF2kRM4DdnT8zq4a5Yup7+OUrqaaWT/0pHKzSUGlaHAyTBHNGxw4067CMkfasbAVK0eiyFJCFM8MGs/7QQN4ALY3gjlaDK954BLcB2FwrwnHPosf9dbURHnJpfd1kJoUI9KWS5e223OnBQEQoPgvAdqFfxK1qQWOByUCZV+Ah/Ycu71Z/4769qe1rR8xA28dB9myPdbgWOpaBWHXg9roPWd/0uP5E1rY0P0ml17zcoX+hlyqPTKOSibUTWUw0scT1BKhw/fMmlSzbrYxhyRM1TG0FPAiJt+Pxob18zAZz6BiQVlmdj5EL1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6Cldh3IKnFZlSDKXjuspy0YZp2pAxooD7YtjN44+EI=;
 b=pMaoRRhjGFKGMPkLxHufDDZ5VWESGmf4HWRY9A1A8r5mjvgHi9XPeNSTdCmNlCTjNEGFKhYH7PV0Kn3CsKJBtJ5QRAeucTzAMyfj3r1waP3rsQRBmco+o8dQebnFL3JxDfbZTOzzCP1jZ8WS8BVHv4e2b0VnxWqFgV9XUg833uPhXOMHYQaWE6XURmNZz4y8jCPgLwRbU4tNTzUKNN81agvjwvbgpOi3erB9k7Pl9dksYtjVJ1ocASTSHwFSF4NG6YYK6ChCmiPx8yhXJ7VImvLIMhC/vVzCVb2zUgGZCgw9A5E40kNAya5MlnsY6CwW7PP8Hb8NPQ4aFuGQQHj6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6Cldh3IKnFZlSDKXjuspy0YZp2pAxooD7YtjN44+EI=;
 b=GxMXG/yOp3Ur/rsVQP2HLkqy5bWIuab8S3ql0QPI4XzzHXRrj6BWEphXHrP2EQjRoJGzEkfZ4VxE4MMJYDSZGo5f6NcT304kICfo/+VVeh1Y5JAouph3MWPwq9JA+kDTlKCDjDciKA9EuZVRtMfN747knTuir+l2UIvqlT86HwT8IEsmOj1UcMkfZuKg6DylfNgVHMtla4kwgRAERT1RyETlUMsaROCugj1aHai8Cd27k5sxzC2KxkXzrybeTfyhcLmH0EECfoD/B7PZWysHsqUHUxQSeFGt2zsVTi2bG3kIGwOuBRrRfAgMGK3PuexJfYGyeLu1sC6a6+L0rcrRSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DS5PPFD22966BE3.namprd12.prod.outlook.com (2603:10b6:f:fc00::662) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Sun, 16 Feb
 2025 07:37:42 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8445.017; Sun, 16 Feb 2025
 07:37:42 +0000
Message-ID: <d882be50-303a-4ed3-b781-8b2935f0db00@nvidia.com>
Date: Sun, 16 Feb 2025 09:37:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: move stale comment about ntuple validation
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 ecree.xilinx@gmail.com
References: <20250214224340.2268691-1-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250214224340.2268691-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0022.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::7)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DS5PPFD22966BE3:EE_
X-MS-Office365-Filtering-Correlation-Id: 03319f9e-426e-43f7-49f9-08dd4e5ccb9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmZaN2R3RlZKY3phYzNSTThIN1loazV2K1hzQXFRRGZ3LzE5dUUwTStMZ2RQ?=
 =?utf-8?B?a0JzUGZRTjEvdnZVQ3BBa09reHgxQmhXYmZkK2RkOEpBYTJiQ2NqMDA1cjJM?=
 =?utf-8?B?enNNczZJOERLWDcxT1V5QnZ3cHlYcHN1Q0RQVFRVS09WbDJ6QkJuSlhwUHp5?=
 =?utf-8?B?UG1rVEpwNm1hN1Y4bTJQS2pJbU9RNEViSVZKelQ3dGhHb2FwdXp2N2tDMHhX?=
 =?utf-8?B?ckFEMnFYVDUvWElwREltaVdFN3A3bEpLTTBCREZLT0xiNGI2TmhNeXRvd29F?=
 =?utf-8?B?b2dHMlRGb3FMc3UvanVwdUZNSmJQeFZLU29XemQrVGUyM3lzcFBveklJdWcw?=
 =?utf-8?B?ZEdCVkVlQXprQk5QdlFob1JOTzlzY1FZK2tXNHF4SE52OGNESHRwcmJoRURL?=
 =?utf-8?B?T0YzTDArK0grU2hmZnlMWEhWZzNFT29BS3RWMzV3OXJBN2x4dmFuNUZ5Ym5u?=
 =?utf-8?B?UEJEb3FFbG5BbWp6M0ZNWkZUUGNtYWFJTGRQSUZKdWQ2blhyS2s5eUd0akE0?=
 =?utf-8?B?bzBmWVVFZUd3NGRSdXlsWUk1UVFDbFhVZTNYbmxkdFJsVVVDZ0ZRSVp4Ylk0?=
 =?utf-8?B?TVJXZEV1cVhGaUtLSUV3Z1g5U2VtTWM2Nng4eDRycGE5cTJqZHZUaURURVEr?=
 =?utf-8?B?RHNJUUpwdkJVcnBNOFo3SmV6OGE0UzB5Yll3STdnMmlwS3dTckh2dS9jNkVT?=
 =?utf-8?B?K0gxUm9sV0RvQlp3VHJoVEVCRTBqZU9tOU9Vay82dVc0SkFmTHhDbGtaWEZV?=
 =?utf-8?B?OGZaNzRoQkMzc0Q4cU0wY0pqSzdNYUlFU0FEYW5aZVNOM3M3YWU5YzVIOWdR?=
 =?utf-8?B?WEkxeHNrZys0cnlRVjJOZ05lSzR4bFJjcTNJVU5YVWZ3MFllb2FmNk11Wk1R?=
 =?utf-8?B?Y1RQVGM0cnIrYTcyU3JxVWtrdHRwazZ5VFUra2pHR0NHK3ZWekZOUFBXL2lk?=
 =?utf-8?B?VFFWby9Bc1V5bzNnekYzWWdtcXhRM2E5c3A1ZzJHb09FdnhUREhpWUs1WGtz?=
 =?utf-8?B?bmtudElidERPNmZ6VzFkcnA4TmZYbFVzTXRKbWEvUW13bzBWVE9xNHowSjE3?=
 =?utf-8?B?L1ViTG9WZjV2OGZFSzlsSjg1WXdRT09HSmk1cFRsUjFPVTVHWmdlSis0SDhR?=
 =?utf-8?B?Tld0QlRRb1BpaWk3UUpLelRPcEErRWVNWVJpZ3E5L3gvbXRXUjN5K3BETStj?=
 =?utf-8?B?ZXZ3UXQzT1ptaTZIUkUzR2N2ZFVvSlpQYWVjcEFmRWY3SStLK0QzQW5RdzJh?=
 =?utf-8?B?d2dLSWsvOURqUXZPaFhLdHRrbVZWbW16QkNPVjRMQ3dRaWovNXZqMGxnQkRu?=
 =?utf-8?B?NGwveDRJR1pVZWVEVldLeDRGQm1hSldYYWJjUjRtbnMwWjBSY1d4Z2NONXVx?=
 =?utf-8?B?R2RwQm9kdXdvK3NUc3ozczl0V3U0WVVpcU1KTkY0L0lnOTB4MGxxZHlVWDIv?=
 =?utf-8?B?V3VLNS9GL3NUYnp4aUFtQTVtejVWZ3FhRVhVd0FnMlV3UDNhZnhJbENEV3JT?=
 =?utf-8?B?MFZoUTNYbC9RSnhmbElQV2FXakJEb1BCNlBjd2xFTWprTDJTczZLcnIzN0pP?=
 =?utf-8?B?Rmd3TkZrUEFuZ0N4SXdXWmxJVEJjQWJPNzNqNTNqWmNjeWlNSVd5a2xNSnpp?=
 =?utf-8?B?UmNMaFdJREYzcFZPNDlSY1A2RmtiNWl1eGJNTXlJVmhmYXU4bnhrSHZscXNJ?=
 =?utf-8?B?WUV5MUV3bGNvY2FPbUJHRENZUitObjV6L3o0Ti9QdGJoYlh0VzRMQ1o3S1pM?=
 =?utf-8?B?K1lpNmxuVExGcnJ4WTdVVEZGT05sNWtkRWp1eG9TUFd2S016WEdBQ2xXSjNO?=
 =?utf-8?B?eHpIZDUzblE5TEZiWHp2eFAvRmZ1Y1R2aTNPUnRIQks1b3daMFprSEFzeWZh?=
 =?utf-8?Q?iEi1iv8GIW2/B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWo4dFdzeWNSVGYxOHBZTnprUHpCWGJzUC9PWUo1Z2ZPM21kQXVKeE1CVDQ5?=
 =?utf-8?B?bFJYb3pOMUhwUEJWTHFSUS9EcWRYTjVFakllcGQ1ZWg0ZXY1RkV6Y3BqWFN2?=
 =?utf-8?B?T1lWalZsUHMyaXJBUUxUTDlNd09BQnNySm5KVjFVcXJ0b2VmSXNaVGJSUmM1?=
 =?utf-8?B?Mis1ZWlVYnpJRVJLcEZETENBRXJ6RzIxb3NkMmlPUmpZVzRRWkxlU0lkeUFj?=
 =?utf-8?B?bFZ1SmhiOHhNWE5MYjQvb1JPVmlvcWxiQkFCYkJ5VWdvVVJ5UWdsTERldUJo?=
 =?utf-8?B?T3BTVzlmNHhuazRHWXFiVmxwT2VmOEhlcDZuTWdUYVZYalNrL1ZhU1VXampR?=
 =?utf-8?B?TEZBK1lKMURneW9jdXJPdGFEQU44Q3dpUWkyN2hlUmJsT3llcmNFd3orWGRk?=
 =?utf-8?B?MWFlTHVZdjdUbERyZ2pqOENENTlaYnJHVnJGNFRBODVMRmh5RGZXRWdjSEZL?=
 =?utf-8?B?V2pra2lvbEN4OEFZRHB6bWFBWHpHWG1TcGZBQnByVkFGNStnRENncktITVFT?=
 =?utf-8?B?K05hMEVSWWNsQW9nNFp3OUs3M2pLQnRJZ2ROWGRoMUh6SmNIZVJwMFFjVzlD?=
 =?utf-8?B?Ymo4N3hHNEQwUjNUS1hXeG96THpaQnJpYjd2aldvQzBVRC9tK254dlI4Y2VD?=
 =?utf-8?B?aUorNUlQLzIvcWhQNjd1SDVSQmdlNWFyalJjdjJPeVk5WVYvYzllam9rWGxn?=
 =?utf-8?B?Y0ZVK29Hc0xKdm5IZlBRWEVTa01UZG15alVTelhMRXEwOHA0V1BzcUhZVFlL?=
 =?utf-8?B?MXJlSllacmMvRGdOTGN6TU9ZQndxRGw1M3J0cHJPaU1RNUxiQnEva1hSK2Jj?=
 =?utf-8?B?SmZSUGp2b0NUQjFvMEhoU2NFWG9DNm94dlJUOWhIVS9wdk5EaGpLc3hxRlEv?=
 =?utf-8?B?ZEk3MkxzbE50Y3l2Wlo3dU9kd0Q0NkhpbFNvTXBobHNoNlgvVU1hVXRqbVJW?=
 =?utf-8?B?ZmFvckZLUzZmR3F5RTN1NHJPQm5Ic2lJbm1kZ3pxczA4UUlFUnFZYWUyTjl6?=
 =?utf-8?B?UFpiYmtManAyV0JTV2JXWGFIaEoyZDJIYnJlSXZpczQ2YzVFRE9JUFY0U2da?=
 =?utf-8?B?SU9zQUxJWXliOG1PK29haUxtcFlQUkxXc1hqU1diZXVTdGtxK1F5QmhPM25G?=
 =?utf-8?B?VCt5c1RKQVhOWnpiM2QwaXpZZ2s0bGdkS3FmYjExcFFwSTd6YXNjaEFlYlRh?=
 =?utf-8?B?WVNUZU14UXBsYnZaZmoyWHJlZ0NsZUx3cysyTlBBbjhVRWFoNXk3ZDBhcFFS?=
 =?utf-8?B?ZnRpdmo3elJCT3NqK2VFQjN4Sk1rdm1IT1FDbCtWSlRrQThMYVd4cU9mUGRa?=
 =?utf-8?B?Sy9HTGQxdmhrR2p6eFIrbnhtYy9IaUJjaFNObDVsb29ydGRrWGt3YkQySndB?=
 =?utf-8?B?V3Foc1JZYWdXQ2M5Mk9OMS9hTDRGT1o1ZXloTEtILzhxS0w0STJmRWRxSEU4?=
 =?utf-8?B?UWtFSVM3V2lEalFXVkRjUmJ1bVJaa2E2dFFLVTV4ZHBUb29nVlNQMVFHZ2kr?=
 =?utf-8?B?N0VSUkp1cDl1UDlSOVhDOWtaQkJXUGU3S1k4SVM0R3hSQWtvS2kyYWFBeDJh?=
 =?utf-8?B?OVMxRmZFVCszSnlqeEZVam1TSWFBREdpem9CajJtRUY2QmVvS2ZlZWpGMXVH?=
 =?utf-8?B?ZEFIcVNNbkc0bnhiRHBmVURxQUlQMTc3K2hsL00vb1lNN1NrL3pBM0tkblgx?=
 =?utf-8?B?cGsxdVBxK0Fjckp5Q0RFZlErV2lwV0IxRW9LR3QrTy9rZ2grZ1BYcnFyVms4?=
 =?utf-8?B?M1o4Ry9vMEdsdGRoVndpVE9aZVg2cnlYZ1J0ZUpsamdIclh0RDl6NnFtZlI3?=
 =?utf-8?B?K0ZnMTF6UEpMQXZLT094Vk1FSnpFenR1VmRpZFVlVGEvZmd4RTk3NXRqYUYv?=
 =?utf-8?B?czU0amxUMS9LeXg4VjVpRWFRZ3pXOFB1L1ZxYzJSLzAxNm9iVFc2a08xNFhN?=
 =?utf-8?B?bnRkaTRGMnVwd2tLb1dwUWgrNWJERHRJU21PUXRnVnczTFVnNWc4VTNBWkdr?=
 =?utf-8?B?NXVEc3lCaUVITEJ3NUlQT2Y3cWlEaklWRTZueGxuZjZqTTR1bHJkMDBQWWlQ?=
 =?utf-8?B?dzkySWc0bUlmZTJEZXJ5NW5PVnNTZnE5QXJaUXZUNVhiY3dMU2pteU0xWjhj?=
 =?utf-8?Q?ef0o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03319f9e-426e-43f7-49f9-08dd4e5ccb9f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 07:37:41.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RRraLmcu+5oW0SU7YPdo1fC56TGnco3kL7x3eD3Pwqzr6JZh9SuQDyXRrttBMj0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFD22966BE3

On 15/02/2025 0:43, Jakub Kicinski wrote:
> Gal points out that the comment now belongs further down, since
> the original if condition was split into two in
> commit de7f7582dff2 ("net: ethtool: prevent flow steering to RSS contexts which don't exist")
> 
> Link: https://lore.kernel.org/de4a2a8a-1eb9-4fa8-af87-7526e58218e9@nvidia.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks,
Reviewed-by: Gal Pressman <gal@nvidia.com>

