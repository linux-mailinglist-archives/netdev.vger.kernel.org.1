Return-Path: <netdev+bounces-187663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ABBAA8974
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 23:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703153B260C
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 21:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700DB15D5B6;
	Sun,  4 May 2025 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Fbi6LJFS"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11010008.outbound.protection.outlook.com [52.101.51.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7C44C77;
	Sun,  4 May 2025 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746394462; cv=fail; b=FNeyvr8uplKA96ABrUsxu8DTtuYCm+XWBGM5tZOKnXlinhtKAm2qbdT1nW4nrPlh3W3g2Z499dcD42htZqqcHR4raOARbIWjvIm928mfYmAgHUz3YYBvRj18pRHxjMg0e1dWsp68X4K1Ex4mZQbQsEgg0xt49FgCde0smkVPw08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746394462; c=relaxed/simple;
	bh=MHxKK1feaBWESjJWfKIbkeXZ64adFGIiS3g/HKbplqw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GqMtIu1nrmHjCFIKlf0XiB+Nc8MBKNMbumUXs2N1PawUPATgswr3XxPCMPnokRUcfX1PbYs1OiQSey9yAIOnGF7aw8tdSUBeLD1zZ7OdgtFfSpfuB8057VhiHUNExz+GK3gj3YqhIZwgfLco7izar1MVqwKxTLc0ThF6wqjm4K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Fbi6LJFS; arc=fail smtp.client-ip=52.101.51.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qU6aHm4cxHUqgOm+teFQEyPQ+RV1NUqBhTt9mkLH57Tf3aUe37nwnnLfWpNt4SUrxc8AN9uYi4Rr2t9SFcC/b+nHPBiVIeFktaNNCwziqT87pzWgXyT/y413GxjXVCVWZpGs4pTiynC9IBJGdJdk6bR0HgOKi0tidbvRWRfwju8RCBO3e2CC54F0zudlZdLO6ZQs211GnCrfxsp400Sf/1hRub9rAHbO3i1k/MHv8rLRcfhRS6jotBNtpvvQzdBJvyjIP7GVBPFnkkv+Ve0g8CPyUAmdjxrVJQkvmk8PjITx9GEfBCh4GFsMk6GOwLa6ECNrr0WUMYVjp+9+8ZyM7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvUhdbvpK2o24AT6M/rSGRu5Dugevq+IPqeVUtn5GrA=;
 b=aS6C/sufQt1PlExI+uyfNW7+6lgls4p/99eWjYRYeRM2JJS3/DTISDFyenO4A2qHKrvzY4rdl3muoe2CX3/YCVcoG8NEDpqk569Q0t042KRUnnVNC9rfQh6FZoFxpCoDJ0aj+9JBCUBFE3NzHcnHkiHC5qd/macVQBOrkqkAbSopTyvkGKdFfm06ICsb3f9IbQoov0rOouS85qp+U7hUkdvWEKD9cKJz+51qiNzfKkzvFbiwCq4kNDSYpXezu2dZqriZVEx/3ED/4HBrvkjR70ZAopQVgG7oTo9nBsihkNIX9yfUka5Xpj0j1GGjlLGqegICCfx8wBOZfXEqr+0rvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvUhdbvpK2o24AT6M/rSGRu5Dugevq+IPqeVUtn5GrA=;
 b=Fbi6LJFSItBxFRzI6+mTGb3zWdte7NqydTiA//aQ+n1CtgEXETejNbpYDOZFlzdWYtKzSTUC0+LAsK+4+Eypl1AMc40YP6IylFFmBI3IX6AlxGj9k9EFY5U/4yQiVhAkY+c89ecWX3pE+gSQMKGUEt0E8EQMNkURE2c+zbDWd9X76bZiiYVerlwic5e1m0cMBPFCteQlcD8wbzkDmCmKsVjvs6+/mw0bckTN8uAzxxcEBatYrtPAuTlnWMJAXNhfWnxIMm88Yb0wLcDFEV5OKrsngXADYOYf5/U14Jy1bzhRXptljD3Vk5Z9oCWS3qxWjU9jyhY2fUZgV5IumkAH3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by CH2PR03MB5175.namprd03.prod.outlook.com (2603:10b6:610:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Sun, 4 May
 2025 21:34:14 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%4]) with mapi id 15.20.8699.026; Sun, 4 May 2025
 21:34:13 +0000
Message-ID: <fd295c8b-c5fd-4fda-b5d4-3c261d8dbfeb@altera.com>
Date: Sun, 4 May 2025 14:34:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND] clk: socfpga: agilex: add support for the Intel
 Agilex5
To: dinguyen@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 richardcochran@gmail.com, linux-clk@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
 Teh Wen Ping <wen.ping.teh@intel.com>
References: <20250417145238.31657-1-matthew.gerlach@altera.com>
Content-Language: en-US
From: "Gerlach, Matthew" <matthew.gerlach@altera.com>
In-Reply-To: <20250417145238.31657-1-matthew.gerlach@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:40::33) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|CH2PR03MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: dc100e8c-d4cb-4893-a110-08dd8b536a2f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzcyOTZxcy9sT0hQRkd5VUo0VGJaYW9JaEFhUUR1bHl5SFJKY1Z0azdNKzVw?=
 =?utf-8?B?a1hPM0VuSDBDNHdNOGxiU0duazYxUEl4TkZ0ZSt5SlFaTnR2RDJYWm1UbXM0?=
 =?utf-8?B?RFlxUmRhbUN6UTBjaDVmREJiRG5rQXpzdXFWSW9TenpaQTgxa1JITDFvZSt5?=
 =?utf-8?B?aFhvenpROUF4UVZkcG43Q3pwOTBKZ3hRaGdmMDNZWk5KSkE0enY4dG9GaVRm?=
 =?utf-8?B?Qk5ncVBpZTdQWURtNExHRHRvWkdma1dHa20wVkdiSXIrWnBJRnI4aUliWnpU?=
 =?utf-8?B?NGVsUGNMamtTQVNBTmkvL205SU5KQWtPZkxEejJPeUZaK2F3QjlsNDEzcHdn?=
 =?utf-8?B?RmdWaUo2MnFvMlpiQVRNcGUxd1lwVGN2QzBNV3p5ajg3N1dtYnllVGFSbVdD?=
 =?utf-8?B?UW9wQlJLQ1NyczZwZEdQWWt6anVibldnK1EzQmw0aE9SL2ZxREdVZ3ZjYUN6?=
 =?utf-8?B?RjZ1RmR1YXQyRlZGU1Vnb29td3VQK0JvU1FHaTVkMGFXY2N6bHBaOG0vWlZw?=
 =?utf-8?B?b3NrVjQwaGNmLzNQTEQxOUZBRVJDendjWk5UNjZXTzNHK1JwT0RsMFRnQTVl?=
 =?utf-8?B?QllzaFRJODIwL2F3ZDRnbUlvZk1LaHpEVFptS0toZHdNNTJEZHhhc1RXUXBI?=
 =?utf-8?B?aGVHSUloelhlOE4wZEtHc1JlSHc0blBXblppWXVOM1J0dzYyN2dieHo5TFpR?=
 =?utf-8?B?M1lSeWhHQlNWVWd5Tk0wcWZqdWhTMWlJQlZ5Y3RmSkYvUDMzVFkwWDZOUnBC?=
 =?utf-8?B?ZkozNmNtd1RwOTBlS1lXYmlLQ2FGcjM0dTRrK3FGSEh0bVVleE16cXhBdDZq?=
 =?utf-8?B?cVF6S1ZsTGRmbkFsdGRBaHhpRGROYi8wQjJrZm42MWZFVEFLYVBKKzdOaGlG?=
 =?utf-8?B?TFB2MUhzZWx1dXpIVFZPbWpHblR5NjZUbmZTT3VvUTJkejdWQzgrZXhwb2hH?=
 =?utf-8?B?WGlQZTV2SUVxc2hqUjlzSG90bk5UNU5LbmlUQnUzaUJIYUtMcy9ETFJHWlFx?=
 =?utf-8?B?NlVXNWRYYnM3VmVVb05ISDNFYUc3dklaeXdjNWNxNysxWG84OUhCbUp4NjFx?=
 =?utf-8?B?aWRNRUZVMzBtYkpqZm81cXJIMngvMlJJZ1MrOGFVbWpEbXIyalJ3ZVY5RnJG?=
 =?utf-8?B?a1A1Zlh6M2xlVUNvaTcwM2E0SWEveHB0RmFxMFBSdWk3bXZUQzZwemlsNTlZ?=
 =?utf-8?B?YjR2YitKczM0Q2lnYTROVzVkWTF2dTNSQVl2NWo5b3IwR1cvOExuOTcyUGhN?=
 =?utf-8?B?UVpaMXQ5dkxBbVdwb0VXcGFMQlM1blozcnAwcDdOcVZ5bzNYejR4TE9wWHBR?=
 =?utf-8?B?YmpaRHpFTWhHWG9zNWpZNSt0ZXY5YlEzZlk0QVU0S3I1TUFtaGYxd1RpMWdP?=
 =?utf-8?B?ZE1UVjBWUU9WcE5sMmZ6c3F2QnFnUFdYVWNjeWpmMWdabDBHNmw5czAvMDMv?=
 =?utf-8?B?MGwvb0VjUW5malZkMFFudUtXZHFVdnZhVGx6bWxib05lbGw0cWdHT01PZEdE?=
 =?utf-8?B?WkRBdXk4Q0FFWUNmdE9sTzlNck8zMXdJaG9MZHg3MkVNaUovRnRLRmdnMlhC?=
 =?utf-8?B?NnVmMTJwWk44bHNmNHRLaG5Xa2xLOUd1NStXbForNGRmT0s2eWorYzNaMTVw?=
 =?utf-8?B?UXcwL2YxUVNnRUx6VjJjM0phd2d2SGU1UnltWDJ0b0RaSTRXUGpFWGY0dFho?=
 =?utf-8?B?SDZMa0JpQkNLUUNrbG1tdHFaWWx2aWVoQXM4ZVlQQXI5UzRSbFY3ZlUybTZx?=
 =?utf-8?B?akZ1bzZFR0pvck1DWFRsZFhpdllsVVpMcnZ3bk1icUEvdG1mSjZYOEM1SThz?=
 =?utf-8?B?bWdFQjNqbUpOMENhV0tWamcyYmRUL3c1cjZlSldyanZUSm9Gd3laUGZDQjJv?=
 =?utf-8?B?SUpscjFlQklZeHBvS3pSVkk5MFlKd3kxRFBrN3hYU3EzSEtuTW94UCtkT3Ro?=
 =?utf-8?Q?YahP7d82Zjk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkYzaktKYmdhSUNrOEhOWFV6YVdVZU5JWEdJWU1panMwZzFYZjQvV25XUmdG?=
 =?utf-8?B?RDNzeStIaUFuOG9ia1Q3ekRvUDJVWElnVlc2VUIwazdFK1Y0dEpzY0czUnBJ?=
 =?utf-8?B?R3U1ZTFBMGdpTytEUW1qdkdIRWpBMFZMbDBZMUNZT3QwK2dwVnpsZklKNWpU?=
 =?utf-8?B?WmxNSHJUR0xXcjlCVjM5RGZnYTAwd0pCREU3Qnh4UmdhYzZoZUNYYmJteGV1?=
 =?utf-8?B?Q0RDOUNYcDY1OTZjT21KcVZPcUV6ZE0yeEJ4TWtPdmRCUGRad0xLaHpOSzFQ?=
 =?utf-8?B?WTZKRFdJK0F5TDNKVWE4OXkzcXltT1V3WHl6SERoWXNnV2cxa1NtWFB3emhU?=
 =?utf-8?B?QnErYlVhQnQ0ODJVTm5sZ05oOWFIQmJZR1ZHMDNRampPNnZIejNZTG40Tnky?=
 =?utf-8?B?MjhFcUJFb3lkdkUyREN2RklrV2l3WFQ1ZWNYT0U0MElYWUlBVS9FSHRMWDZ3?=
 =?utf-8?B?REhYU1M1a2tuVktjdW9hMVdpOUZqL3NQSFVyb3h0UUl5YVBQa0g0TGo5Vllh?=
 =?utf-8?B?SWJrOVA3TFBUNTRtL1lMbXQ2WDdIVmVLODdwR1FMSzYwTlRkOFNuOWkvWjF2?=
 =?utf-8?B?VDF2QVlrMXpiNmp0RXNySlpSQURWWDBWd3R5MURqZkdmV1lwOXJhVWo1ZUxq?=
 =?utf-8?B?U0gvMHIvaDdUeHhMYXB1SDYzVk03MGtUcmE0bnYzd2pYSkFnejF0QXVHMGJo?=
 =?utf-8?B?NlY0bzlQWTlhWGQzanNvcTE4TGtrSm9mWHpUZEpjQTU4djYvVW0xYSt3RUti?=
 =?utf-8?B?ZnhreGw0N1FNbnhFVm1YVmdJbDFHNy8yWkJiQ1pJRFZKQmRkTEl0dDVpWVg5?=
 =?utf-8?B?WWR5dWVaMXpabnQ5SHZBQ283RmtTb2xRaHJQL1NZeCtuT2w2UEFyYURyVVM2?=
 =?utf-8?B?YkkraXFGZnZMSVNOV3VGdkJyT2U5VHlNSkROeVpnWDZTcUpwaUZORjc4Mk9V?=
 =?utf-8?B?TGlpeUJTM1ZEZlRJUFZYbE1pQ0twbHBLNDN4d29aMnByQVBvV1ljTnFVV29x?=
 =?utf-8?B?R3NIVTdVcWp4ME0wVUVVbEdjUGp5Q3VqS3RUdUV2bWE0YTF3WGtxeVBlaGRV?=
 =?utf-8?B?SHRaUTEwejZibG9qbnJidldEa0FtWEl2VlFHeFN6d0NKT2E1TGMzQm5lYnRT?=
 =?utf-8?B?ZHFPSW10bVhOYWlWd0tWeDRTQlR6a1k3aUNqSUV6Q0I5ZVFJRmxCeFBhS2Za?=
 =?utf-8?B?UGVJdXgzY2xjTnJodDJpcVAvdE42RHAwVGsza2hRZ0pYZnViRXMydkZ0UE5C?=
 =?utf-8?B?eU04M0lpRFJkaHk4Q25KQnZPMDBlZHROWHllZ2RReWtJUjVpMTd5eGpPekp3?=
 =?utf-8?B?dkpDQ2hnMmNsSmhnRG5WS3pFVFR2T1JVQXA4cUNrM2wydjJJaGZjN1FxZFFw?=
 =?utf-8?B?SlVkeWNZUUh2Ym1HZkxEVEZFUHd4VmlIbi84emliNUhhUmQwNVlHQ0loYUpC?=
 =?utf-8?B?aGtVQlZUZm1HZUhDb0tTRVREeGZiTTM3V3g2TkRyM0dqQ0U5dHdvTmloV1Bi?=
 =?utf-8?B?UXdFVnlqRW5UNTVxWEhDekNUMDVsdVVmckpLUmx6V1RmN0FpcGpaNUw5d1Rx?=
 =?utf-8?B?ZVVSbUk3aldRY0xaM3pSamZNUlk4cUdtWUpNWkRKNVdNeVl0YkgzUnE4VmtT?=
 =?utf-8?B?Y1RMN2NKcjRzVWl1SDRTdk1vczR3YVoyMGd3VGxwbnhUVzUvdXJLTlhiSGlT?=
 =?utf-8?B?OS9EeXo5YzZFTWdvSWdRZjdLKzRZR2p2V1RvcGxmZG9SbXYyUU9kRDBHSTFo?=
 =?utf-8?B?Z3ZlY2ZJZFl0S3hZN2V1Z1RjMUVzaVBhUjFjc0VOVzdvbUY4K081L0ZRSzBL?=
 =?utf-8?B?TVR5UjBnZ3I0WGl3SlVTQUpVTGxxdnR2TUsvc2htWE80TmZKUGoyeGdrajI3?=
 =?utf-8?B?Rm9URGpEL1NuaCs5NHh1ODZkOXRoS25oVjBXbjY1aEhSVUNaNzRBQk83cVVr?=
 =?utf-8?B?eitJRW1DWlIxcFRoN21COTBYdGo4OFE0V2lBMDZlNTZTUFBzejY0UWJhNmc4?=
 =?utf-8?B?cVE0a2pQTk8wbkxwVnc3enMyeHVvSTRWTCt0VCt3Q05naFl0bHUveCt3Q1E0?=
 =?utf-8?B?bU5Mbkh0cTQxV1VOU2Q4NHQ5UUdGd0w4bkk4WitZMkVaSHZCeUk3Ym9jempE?=
 =?utf-8?B?WFRLMExOODQ2RXpxV2IzeUl5V0hjWTNwSnVhOUpONzZUTHFwQlhqUHovamx6?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc100e8c-d4cb-4893-a110-08dd8b536a2f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 21:34:13.9126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLprUKdJ33Nx6ssHWIWfHMmBj7BQOrauT9XT34dqrR09QdaGBTHy6n3u7GZ2QrAO14BF/T9IRBJYkHNY6tk/h5DGC/vNYYQmzCq5tsI2gpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5175



On 4/17/2025 7:52 AM, Matthew Gerlach wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
> driver for the Agilex5 is very similar to the Agilex platform, so
> it is reusing most of the Agilex clock driver code.
> 
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>

Is there any feedback on this patch?

Thanks,
Matthew Gerlach

> ---
> Changes in v4:
> - Add .index to clk_parent_data.
> 
> Changes in v3:
> - Used different name for stratix10_clock_data pointer.
> - Used a single function call, devm_platform_ioremap_resource().
> - Used only .name in clk_parent_data.
> 
> Stephen suggested to use .fw_name or .index, But since the changes are on top
> of existing driver and current driver code is not using clk_hw and removing
> .name and using .fw_name and/or .index resulting in parent clock_rate &
> recalc_rate to 0.
> 
> In order to use .index, I would need to refactor the common code that is shared
> by a few Intel SoCFPGA platforms (S10, Agilex and N5x). So, if using .name for
> this patch is acceptable then I will upgrade clk-agilex.c in future submission.
> 
> Changes in v2:
> - Instead of creating separate clock manager driver, re-use agilex clock
>    manager driver and modified it for agilex5 changes to avoid code
>    duplicate.
> ---
>   drivers/clk/socfpga/clk-agilex.c | 413 ++++++++++++++++++++++++++++++-
>   1 file changed, 412 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
> index 8dd94f64756b..a5ed2a22426e 100644
> --- a/drivers/clk/socfpga/clk-agilex.c
> +++ b/drivers/clk/socfpga/clk-agilex.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (C) 2019, Intel Corporation
> + * Copyright (C) 2019-2024, Intel Corporation
> + * Copyright (C) 2025, Altera Corporation
>    */
>   #include <linux/slab.h>
>   #include <linux/clk-provider.h>
> @@ -8,6 +9,7 @@
>   #include <linux/platform_device.h>
>   
>   #include <dt-bindings/clock/agilex-clock.h>
> +#include <dt-bindings/clock/intel,agilex5-clkmgr.h>
>   
>   #include "stratix10-clk.h"
>   
> @@ -334,6 +336,375 @@ static const struct stratix10_gate_clock agilex_gate_clks[] = {
>   	  10, 0, 0, 0, 0, 0, 4},
>   };
>   
> +static const struct clk_parent_data agilex5_pll_mux[] = {
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_boot_mux[] = {
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_core0_free_mux[] = {
> +	{ .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
> +	{ .name = "peri_pll_c0", .index = AGILEX5_MAIN_PLL_C0_CLK, },
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_core1_free_mux[] = {
> +	{ .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
> +	{ .name = "peri_pll_c0", .index = AGILEX5_MAIN_PLL_C0_CLK, },
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_core2_free_mux[] = {
> +	{ .name = "main_pll_c0", .index = AGILEX5_MAIN_PLL_C0_CLK, },
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_core3_free_mux[] = {
> +	{ .name = "main_pll_c0", .index = AGILEX5_MAIN_PLL_C0_CLK, },
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_dsu_free_mux[] = {
> +	{ .name = "main_pll_c2", .index = AGILEX5_MAIN_PLL_C2_CLK, },
> +	{ .name = "peri_pll_c0", .index = AGILEX5_PERIPH_PLL_C0_CLK, },
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_noc_free_mux[] = {
> +	{ .name = "main_pll_c3", .index = AGILEX5_MAIN_PLL_C3_CLK, },
> +	{ .name = "peri_pll_c1", .index = AGILEX5_PERIPH_PLL_C1_CLK, },
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_emaca_free_mux[] = {
> +	{ .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
> +	{ .name = "peri_pll_c3", .index = AGILEX5_PERIPH_PLL_C3_CLK, },
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_emacb_free_mux[] = {
> +	{ .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
> +	{ .name = "peri_pll_c3", .index = AGILEX5_PERIPH_PLL_C3_CLK, },
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_emac_ptp_free_mux[] = {
> +	{ .name = "main_pll_c3", .index = AGILEX5_MAIN_PLL_C3_CLK, },
> +	{ .name = "peri_pll_c3", .index = AGILEX5_PERIPH_PLL_C3_CLK, },
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_gpio_db_free_mux[] = {
> +	{ .name = "main_pll_c3", .index = AGILEX5_MAIN_PLL_C3_CLK, },
> +	{ .name = "peri_pll_c1", .index = AGILEX5_PERIPH_PLL_C1_CLK, },
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_psi_ref_free_mux[] = {
> +	{ .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
> +	{ .name = "peri_pll_c3", .index = AGILEX5_PERIPH_PLL_C3_CLK, },
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_usb31_free_mux[] = {
> +	{ .name = "main_pll_c3", .index = AGILEX5_MAIN_PLL_C3_CLK, },
> +	{ .name = "peri_pll_c2", .index = AGILEX5_PERIPH_PLL_C2_CLK, },
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_s2f_usr0_free_mux[] = {
> +	{ .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
> +	{ .name = "peri_pll_c3", .index = AGILEX5_PERIPH_PLL_C3_CLK, },
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_s2f_usr1_free_mux[] = {
> +	{ .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
> +	{ .name = "peri_pll_c3", .index = AGILEX5_PERIPH_PLL_C3_CLK, },
> +	{ .name = "osc1", .index = AGILEX5_OSC1, },
> +	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
> +	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_core0_mux[] = {
> +	{ .name = "core0_free_clk", .index = AGILEX5_CORE0_FREE_CLK, },
> +	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_core1_mux[] = {
> +	{ .name = "core1_free_clk", .index = AGILEX5_CORE1_FREE_CLK },
> +	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_core2_mux[] = {
> +	{ .name = "core2_free_clk", .index = AGILEX5_CORE2_FREE_CLK, },
> +	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_core3_mux[] = {
> +	{ .name = "core3_free_clk", .index = AGILEX5_CORE3_FREE_CLK, },
> +	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_dsu_mux[] = {
> +	{ .name = "dsu_free_clk", .index = AGILEX5_DSU_FREE_CLK, },
> +	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_emac_mux[] = {
> +	{ .name = "emaca_free_clk", .index = AGILEX5_EMAC_A_FREE_CLK, },
> +	{ .name = "emacb_free_clk", .index = AGILEX5_EMAC_B_FREE_CLK, },
> +	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_noc_mux[] = {
> +	{ .name = "noc_free_clk", .index = AGILEX5_NOC_FREE_CLK, },
> +	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_s2f_user0_mux[] = {
> +	{ .name = "s2f_user0_free_clk", .index = AGILEX5_S2F_USER0_FREE_CLK, },
> +	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_s2f_user1_mux[] = {
> +	{ .name = "s2f_user1_free_clk", .index = AGILEX5_S2F_USER1_FREE_CLK, },
> +	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_psi_mux[] = {
> +	{ .name = "psi_ref_free_clk", .index = AGILEX5_PSI_REF_FREE_CLK, },
> +	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_gpio_db_mux[] = {
> +	{ .name = "gpio_db_free_clk", .index = AGILEX5_GPIO_DB_FREE_CLK, },
> +	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_emac_ptp_mux[] = {
> +	{ .name = "emac_ptp_free_clk", .index = AGILEX5_EMAC_PTP_FREE_CLK, },
> +	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
> +};
> +
> +static const struct clk_parent_data agilex5_usb31_mux[] = {
> +	{ .name = "usb31_free_clk", .index = AGILEX5_USB31_FREE_CLK, },
> +	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
> +};
> +
> +/*
> + * clocks in AO (always on) controller
> + */
> +static const struct stratix10_pll_clock agilex5_pll_clks[] = {
> +	{ AGILEX5_BOOT_CLK, "boot_clk", agilex5_boot_mux, ARRAY_SIZE(agilex5_boot_mux), 0,
> +	  0x0 },
> +	{ AGILEX5_MAIN_PLL_CLK, "main_pll", agilex5_pll_mux, ARRAY_SIZE(agilex5_pll_mux), 0,
> +	  0x48 },
> +	{ AGILEX5_PERIPH_PLL_CLK, "periph_pll", agilex5_pll_mux, ARRAY_SIZE(agilex5_pll_mux), 0,
> +	  0x9C },
> +};
> +
> +static const struct stratix10_perip_c_clock agilex5_main_perip_c_clks[] = {
> +	{ AGILEX5_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0,
> +	  0x5C },
> +	{ AGILEX5_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0,
> +	  0x60 },
> +	{ AGILEX5_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0,
> +	  0x64 },
> +	{ AGILEX5_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0,
> +	  0x68 },
> +	{ AGILEX5_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1, 0,
> +	  0xB0 },
> +	{ AGILEX5_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0,
> +	  0xB4 },
> +	{ AGILEX5_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1, 0,
> +	  0xB8 },
> +	{ AGILEX5_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1, 0,
> +	  0xBC },
> +};
> +
> +/* Non-SW clock-gated enabled clocks */
> +static const struct stratix10_perip_cnt_clock agilex5_main_perip_cnt_clks[] = {
> +	{ AGILEX5_CORE0_FREE_CLK, "core0_free_clk", NULL, agilex5_core0_free_mux,
> +	ARRAY_SIZE(agilex5_core0_free_mux), 0, 0x0104, 0, 0, 0},
> +	{ AGILEX5_CORE1_FREE_CLK, "core1_free_clk", NULL, agilex5_core1_free_mux,
> +	ARRAY_SIZE(agilex5_core1_free_mux), 0, 0x0104, 0, 0, 0},
> +	{ AGILEX5_CORE2_FREE_CLK, "core2_free_clk", NULL, agilex5_core2_free_mux,
> +	ARRAY_SIZE(agilex5_core2_free_mux), 0, 0x010C, 0, 0, 0},
> +	{ AGILEX5_CORE3_FREE_CLK, "core3_free_clk", NULL, agilex5_core3_free_mux,
> +	ARRAY_SIZE(agilex5_core3_free_mux), 0, 0x0110, 0, 0, 0},
> +	{ AGILEX5_DSU_FREE_CLK, "dsu_free_clk", NULL, agilex5_dsu_free_mux,
> +	ARRAY_SIZE(agilex5_dsu_free_mux), 0, 0x0100, 0, 0, 0},
> +	{ AGILEX5_NOC_FREE_CLK, "noc_free_clk", NULL, agilex5_noc_free_mux,
> +	  ARRAY_SIZE(agilex5_noc_free_mux), 0, 0x40, 0, 0, 0 },
> +	{ AGILEX5_EMAC_A_FREE_CLK, "emaca_free_clk", NULL, agilex5_emaca_free_mux,
> +	  ARRAY_SIZE(agilex5_emaca_free_mux), 0, 0xD4, 0, 0x88, 0 },
> +	{ AGILEX5_EMAC_B_FREE_CLK, "emacb_free_clk", NULL, agilex5_emacb_free_mux,
> +	  ARRAY_SIZE(agilex5_emacb_free_mux), 0, 0xD8, 0, 0x88, 1 },
> +	{ AGILEX5_EMAC_PTP_FREE_CLK, "emac_ptp_free_clk", NULL,
> +	  agilex5_emac_ptp_free_mux, ARRAY_SIZE(agilex5_emac_ptp_free_mux), 0, 0xDC, 0, 0x88,
> +	  2 },
> +	{ AGILEX5_GPIO_DB_FREE_CLK, "gpio_db_free_clk", NULL, agilex5_gpio_db_free_mux,
> +	  ARRAY_SIZE(agilex5_gpio_db_free_mux), 0, 0xE0, 0, 0x88, 3 },
> +	{ AGILEX5_S2F_USER0_FREE_CLK, "s2f_user0_free_clk", NULL,
> +	  agilex5_s2f_usr0_free_mux, ARRAY_SIZE(agilex5_s2f_usr0_free_mux), 0, 0xE8, 0, 0x30,
> +	  2 },
> +	{ AGILEX5_S2F_USER1_FREE_CLK, "s2f_user1_free_clk", NULL,
> +	  agilex5_s2f_usr1_free_mux, ARRAY_SIZE(agilex5_s2f_usr1_free_mux), 0, 0xEC, 0, 0x88,
> +	  5 },
> +	{ AGILEX5_PSI_REF_FREE_CLK, "psi_ref_free_clk", NULL, agilex5_psi_ref_free_mux,
> +	  ARRAY_SIZE(agilex5_psi_ref_free_mux), 0, 0xF0, 0, 0x88, 6 },
> +	{ AGILEX5_USB31_FREE_CLK, "usb31_free_clk", NULL, agilex5_usb31_free_mux,
> +	  ARRAY_SIZE(agilex5_usb31_free_mux), 0, 0xF8, 0, 0x88, 7},
> +};
> +
> +/* SW Clock gate enabled clocks */
> +static const struct stratix10_gate_clock agilex5_gate_clks[] = {
> +	/* Main PLL0 Begin */
> +	/* MPU clocks */
> +	{ AGILEX5_CORE0_CLK, "core0_clk", NULL, agilex5_core0_mux,
> +	  ARRAY_SIZE(agilex5_core0_mux), 0, 0x24, 8, 0, 0, 0, 0x30, 5, 0 },
> +	{ AGILEX5_CORE1_CLK, "core1_clk", NULL, agilex5_core1_mux,
> +	  ARRAY_SIZE(agilex5_core1_mux), 0, 0x24, 9, 0, 0, 0, 0x30, 5, 0 },
> +	{ AGILEX5_CORE2_CLK, "core2_clk", NULL, agilex5_core2_mux,
> +	  ARRAY_SIZE(agilex5_core2_mux), 0, 0x24, 10, 0, 0, 0, 0x30, 6, 0 },
> +	{ AGILEX5_CORE3_CLK, "core3_clk", NULL, agilex5_core3_mux,
> +	  ARRAY_SIZE(agilex5_core3_mux), 0, 0x24, 11, 0, 0, 0, 0x30, 7, 0 },
> +	{ AGILEX5_MPU_CLK, "dsu_clk", NULL, agilex5_dsu_mux, ARRAY_SIZE(agilex5_dsu_mux), 0, 0,
> +	  0, 0, 0, 0, 0x34, 4, 0 },
> +	{ AGILEX5_MPU_PERIPH_CLK, "mpu_periph_clk", NULL, agilex5_dsu_mux,
> +	  ARRAY_SIZE(agilex5_dsu_mux), 0, 0, 0, 0x44, 20, 2, 0x34, 4, 0 },
> +	{ AGILEX5_MPU_CCU_CLK, "mpu_ccu_clk", NULL, agilex5_dsu_mux,
> +	  ARRAY_SIZE(agilex5_dsu_mux), 0, 0, 0, 0x44, 18, 2, 0x34, 4, 0 },
> +	{ AGILEX5_L4_MAIN_CLK, "l4_main_clk", NULL, agilex5_noc_mux,
> +	  ARRAY_SIZE(agilex5_noc_mux), 0, 0x24, 1, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_L4_MP_CLK, "l4_mp_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux), 0,
> +	  0x24, 2, 0x44, 4, 2, 0x30, 1, 0 },
> +	{ AGILEX5_L4_SYS_FREE_CLK, "l4_sys_free_clk", NULL, agilex5_noc_mux,
> +	  ARRAY_SIZE(agilex5_noc_mux), 0, 0, 0, 0x44, 2, 2, 0x30, 1, 0 },
> +	{ AGILEX5_L4_SP_CLK, "l4_sp_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux),
> +	  CLK_IS_CRITICAL, 0x24, 3, 0x44, 6, 2, 0x30, 1, 0 },
> +
> +	/* Core sight clocks*/
> +	{ AGILEX5_CS_AT_CLK, "cs_at_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux), 0,
> +	  0x24, 4, 0x44, 24, 2, 0x30, 1, 0 },
> +	{ AGILEX5_CS_TRACE_CLK, "cs_trace_clk", NULL, agilex5_noc_mux,
> +	  ARRAY_SIZE(agilex5_noc_mux), 0, 0x24, 4, 0x44, 26, 2, 0x30, 1, 0 },
> +	{ AGILEX5_CS_PDBG_CLK, "cs_pdbg_clk", "cs_at_clk", NULL, 1, 0, 0x24, 4,
> +	  0x44, 28, 1, 0, 0, 0 },
> +	/* Main PLL0 End */
> +
> +	/* Main Peripheral PLL1 Begin */
> +	{ AGILEX5_EMAC0_CLK, "emac0_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
> +	  0, 0x7C, 0, 0, 0, 0, 0x94, 26, 0 },
> +	{ AGILEX5_EMAC1_CLK, "emac1_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
> +	  0, 0x7C, 1, 0, 0, 0, 0x94, 27, 0 },
> +	{ AGILEX5_EMAC2_CLK, "emac2_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
> +	  0, 0x7C, 2, 0, 0, 0, 0x94, 28, 0 },
> +	{ AGILEX5_EMAC_PTP_CLK, "emac_ptp_clk", NULL, agilex5_emac_ptp_mux,
> +	  ARRAY_SIZE(agilex5_emac_ptp_mux), 0, 0x7C, 3, 0, 0, 0, 0x88, 2, 0 },
> +	{ AGILEX5_GPIO_DB_CLK, "gpio_db_clk", NULL, agilex5_gpio_db_mux,
> +	  ARRAY_SIZE(agilex5_gpio_db_mux), 0, 0x7C, 4, 0x98, 0, 16, 0x88, 3, 1 },
> +	  /* Main Peripheral PLL1 End */
> +
> +	  /* Peripheral clocks  */
> +	{ AGILEX5_S2F_USER0_CLK, "s2f_user0_clk", NULL, agilex5_s2f_user0_mux,
> +	  ARRAY_SIZE(agilex5_s2f_user0_mux), 0, 0x24, 6, 0, 0, 0, 0x30, 2, 0 },
> +	{ AGILEX5_S2F_USER1_CLK, "s2f_user1_clk", NULL, agilex5_s2f_user1_mux,
> +	  ARRAY_SIZE(agilex5_s2f_user1_mux), 0, 0x7C, 6, 0, 0, 0, 0x88, 5, 0 },
> +	{ AGILEX5_PSI_REF_CLK, "psi_ref_clk", NULL, agilex5_psi_mux,
> +	  ARRAY_SIZE(agilex5_psi_mux), 0, 0x7C, 7, 0, 0, 0, 0x88, 6, 0 },
> +	{ AGILEX5_USB31_SUSPEND_CLK, "usb31_suspend_clk", NULL, agilex5_usb31_mux,
> +	  ARRAY_SIZE(agilex5_usb31_mux), 0, 0x7C, 25, 0, 0, 0, 0x88, 7, 0 },
> +	{ AGILEX5_USB31_BUS_CLK_EARLY, "usb31_bus_clk_early", "l4_main_clk",
> +	  NULL, 1, 0, 0x7C, 25, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_USB2OTG_HCLK, "usb2otg_hclk", "l4_mp_clk", NULL, 1, 0, 0x7C,
> +	  8, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SPIM_0_CLK, "spim_0_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 9,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SPIM_1_CLK, "spim_1_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 11,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SPIS_0_CLK, "spis_0_clk", "l4_sp_clk", NULL, 1, 0, 0x7C, 12,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SPIS_1_CLK, "spis_1_clk", "l4_sp_clk", NULL, 1, 0, 0x7C, 13,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_DMA_CORE_CLK, "dma_core_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
> +	  14, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_DMA_HS_CLK, "dma_hs_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 14,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_I3C_0_CORE_CLK, "i3c_0_core_clk", "l4_mp_clk", NULL, 1, 0,
> +	  0x7C, 18, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_I3C_1_CORE_CLK, "i3c_1_core_clk", "l4_mp_clk", NULL, 1, 0,
> +	  0x7C, 19, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_I2C_0_PCLK, "i2c_0_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 15,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_I2C_1_PCLK, "i2c_1_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 16,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_I2C_EMAC0_PCLK, "i2c_emac0_pclk", "l4_sp_clk", NULL, 1, 0,
> +	  0x7C, 17, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_I2C_EMAC1_PCLK, "i2c_emac1_pclk", "l4_sp_clk", NULL, 1, 0,
> +	  0x7C, 22, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_I2C_EMAC2_PCLK, "i2c_emac2_pclk", "l4_sp_clk", NULL, 1, 0,
> +	  0x7C, 27, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_UART_0_PCLK, "uart_0_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 20,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_UART_1_PCLK, "uart_1_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 21,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SPTIMER_0_PCLK, "sptimer_0_pclk", "l4_sp_clk", NULL, 1, 0,
> +	  0x7C, 23, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SPTIMER_1_PCLK, "sptimer_1_pclk", "l4_sp_clk", NULL, 1, 0,
> +	  0x7C, 24, 0, 0, 0, 0, 0, 0 },
> +
> +	/*NAND, SD/MMC and SoftPHY overall clocking*/
> +	{ AGILEX5_DFI_CLK, "dfi_clk", "l4_mp_clk", NULL, 1, 0, 0, 0, 0x44, 16,
> +	  2, 0, 0, 0 },
> +	{ AGILEX5_NAND_NF_CLK, "nand_nf_clk", "dfi_clk", NULL, 1, 0, 0x7C, 10,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_NAND_BCH_CLK, "nand_bch_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
> +	  10, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SDMMC_SDPHY_REG_CLK, "sdmmc_sdphy_reg_clk", "l4_mp_clk", NULL,
> +	  1, 0, 0x7C, 5, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SDMCLK, "sdmclk", "dfi_clk", NULL, 1, 0, 0x7C, 5, 0, 0, 0, 0,
> +	  0, 0 },
> +	{ AGILEX5_SOFTPHY_REG_PCLK, "softphy_reg_pclk", "l4_mp_clk", NULL, 1, 0,
> +	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SOFTPHY_PHY_CLK, "softphy_phy_clk", "l4_mp_clk", NULL, 1, 0,
> +	  0x7C, 26, 0x44, 16, 2, 0, 0, 0 },
> +	{ AGILEX5_SOFTPHY_CTRL_CLK, "softphy_ctrl_clk", "dfi_clk", NULL, 1, 0,
> +	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
> +};
> +
>   static int n5x_clk_register_c_perip(const struct n5x_perip_c_clock *clks,
>   				       int nums, struct stratix10_clock_data *data)
>   {
> @@ -542,11 +913,51 @@ static int agilex_clkmgr_probe(struct platform_device *pdev)
>   	return	probe_func(pdev);
>   }
>   
> +static int agilex5_clkmgr_init(struct platform_device *pdev)
> +{
> +	struct stratix10_clock_data *stratix_data;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *base;
> +	int i, num_clks;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	num_clks = AGILEX5_NUM_CLKS;
> +
> +	stratix_data = devm_kzalloc(dev,
> +				    struct_size(stratix_data, clk_data.hws, num_clks), GFP_KERNEL);
> +	if (!stratix_data)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_clks; i++)
> +		stratix_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
> +
> +	stratix_data->base = base;
> +	stratix_data->clk_data.num = num_clks;
> +
> +	agilex_clk_register_pll(agilex5_pll_clks, ARRAY_SIZE(agilex5_pll_clks),
> +				stratix_data);
> +
> +	agilex_clk_register_c_perip(agilex5_main_perip_c_clks,
> +				    ARRAY_SIZE(agilex5_main_perip_c_clks), stratix_data);
> +
> +	agilex_clk_register_cnt_perip(agilex5_main_perip_cnt_clks,
> +				      ARRAY_SIZE(agilex5_main_perip_cnt_clks), stratix_data);
> +
> +	agilex_clk_register_gate(agilex5_gate_clks,
> +				 ARRAY_SIZE(agilex5_gate_clks), stratix_data);
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, &stratix_data->clk_data);
> +}
> +
>   static const struct of_device_id agilex_clkmgr_match_table[] = {
>   	{ .compatible = "intel,agilex-clkmgr",
>   	  .data = agilex_clkmgr_init },
>   	{ .compatible = "intel,easic-n5x-clkmgr",
>   	  .data = n5x_clkmgr_init },
> +	{ .compatible = "intel,agilex5-clkmgr",
> +	  .data = agilex5_clkmgr_init },
>   	{ }
>   };
>   


