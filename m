Return-Path: <netdev+bounces-231287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FAFBF6F63
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF3D34F11E5
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33B833A013;
	Tue, 21 Oct 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="ZToboN3u";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="rBlF4gOR"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay10-hz1-if1.hornetsecurity.com (mx-relay10-hz1-if1.hornetsecurity.com [94.100.128.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBA133C52B
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.128.20
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055386; cv=fail; b=d+iz40Pb9qMES4xZctGwU9J1YE4C2W6xsArCjqVaZ9PdUfQPOt8QKCqTBqtUl/QeTLR3UDnIXFbKalZ75p7UgVcmXjROwj6OUVb+m9kWIMb8ByPwevRgeYp/7ijcP8k/33dtw8nAQMnhcPJ6zdbiRwogq54g5CssIT5frsj1te8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055386; c=relaxed/simple;
	bh=yyNPreDR1H8Lvai/ToW6hckuIkouZXN8eFCGct+lrb4=;
	h=From:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type; b=pZ3pvHcv/XILRCGQNmgzMcNAqxj4tWzmut10gKCl1Oof3xVAFbO94EZrYtftcovMzfc0l3hvRvV4fFWlkacz/Ww1AXVbxFY0wthpTbEtdq18eb4SDI1ITq4fP+rm/EFlPHJqQXZH0CfsYZ8N6t3EJDKDdA1InlBEN3Lay9BBgHk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=ZToboN3u reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=rBlF4gOR; arc=fail smtp.client-ip=94.100.128.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate10-hz1.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=52.101.84.119, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=db3pr0202cu003.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=td2l+RSFouZySvonviPU9tUxkRcmnoQWhJn+xWVCmrs=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761055335;
 b=nNqd10l4t1rG0+4gTmuSYYySwQvEw77W3UJDcAjCBI3S/PzSbYmrRKn/QZdrutiT4rnt1k0N
 49cEMa+1QgRWZ888AZEW0HydhGKTw1JT9Al+4kWkHaUwyzdnzjCehkQSguwwgcp73s2o1R/dnKJ
 e+Wrk+F8chA2Q4mygH2iBw1zMyyBQm0qO3h1Uqrh1bt084Au25nyoM1PTp792zUwdRphfHaL5Fe
 0pF3+hYOQSUvsS7mGJ47UD79YhCxCTvZJqSZUOaSPqMs+c8n9gsHCEbnCICgNZf5GFpeDs1M7Zc
 5DQsOaU9XI6fQt+hnoKWBH5mGuAYe8ICHoaKQhB3uoM7w==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761055335;
 b=ih6js2dIBrIYsGjmTEWRqq2Ta3o/Di6EuJeye7HXGCosWwzIpyGmDqDupqf73ExAUp8xlBa/
 6ehjdKDw07KvFT1uUCObal/rWGbIKD7lSn3cX/wDROjnSznpjFBKHYygxwpkGeTw5uWITYjAqhq
 c2Rv990xmMaWlQO+MaQitCVbg4HtQw2EWj7okihCpdzxr1aV0m+1zs/zT5YXpXQmLdNTOy0IMpq
 AaYoFRITvvmIuTerhrag9T2ObK72+RlsDKe46VfJKCXaCXwtKwbg9PQvCH28kWJQPXm9dOMkegm
 CfcRvMTgCubgQInF478AvkBr6jo1salmuarYI+w8xkyNw==
Received: from mail-northeuropeazon11020119.outbound.protection.outlook.com ([52.101.84.119]) by mx-relay10-hz1.antispameurope.com;
 Tue, 21 Oct 2025 16:02:15 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A65VV7PDlhmbNpJecYEXqrzzGI3X1n7w+0r8WAFZinAPRp/21PYjkgUN3im2MyMDElXzsylj87ml9gA2C6nHMwO/cHMdXuhgXf+ZpuhjP5U7jQOnW+Ck0I6PnFl8liMhM+wKSqTCrmrVpVLpxaiXOHfFoIa1pj8/ejZGACmRvuSMdm+E4rLQPT7dKIcAVwkLJ+mdEnNMn5lKfSafzwO9flq5bnaljwoyQtKiOlalQa0URfzPlg99uzp90jb4WNBD+tnrzlUFh2RsNJaRuqLXXZ94DdY9/VFBUqxQOpgeIakZzOVpOp/sEgpsuKt3FOhvVnEJoWnAzlX1jcQ0FjDWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVXybzGyQdVK5SkzEeuZIGQbDyXGEqA4oSwoPz6dMXU=;
 b=FjzTcZwLgIfnZlqKhJYDScsL6HQVJcty5+yYKsO2B7FsLuVNozDxQEimq4/CpRpbeW9n9QBk51H0dzRNhxieXrNhlu7sWwpo+ALtwGeF6rm0wzEqQrGWNAZd246w+qP2Xrvyvjm9Hrs9JB840IEaiN5EsjFHgZBKMxRqg7iRuSY9hsvCwA2KQ1iMHTGEmBlvdpYA2y2Q5u0mbHEhsmVSd2Lbm4Aufw0TBYp2cA4jeyEhwA47XcbZt2HjGJLaJxEbvV+iVA9ojFcbXjLLfmmUs2JHNZJWCqF7J79M/Sn9NZd6NoxYP+CIl785gUCi2n2h59v0WZGr9/s8gzdU4qKSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVXybzGyQdVK5SkzEeuZIGQbDyXGEqA4oSwoPz6dMXU=;
 b=ZToboN3uifKwRkDVn1bO8tK681HQu1mOOsdUO/aOnRnleYwAl5UvJGdY2UhhbcU5wcq6c7g5O5nZVA2gSZgGFpC16Gq0N9hV8399FlF150n8To8pMsYMnDjUYu1GZtqN91a9Xb9b0hZiZMuS4DcKXvif4oV0Mj4+1qQ5GcaMFQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by AS4PR10MB5941.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:519::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 14:01:02 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9228.014; Tue, 21 Oct 2025
 14:01:02 +0000
From: Johannes Eigner <johannes.eigner@a-eberle.de>
Subject: [PATCH ethtool 0/2] fix module info JSON output
Date: Tue, 21 Oct 2025 16:00:11 +0200
Message-Id: <20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de>
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOuR92gC/x2MQQqAMAwEvyI5G2hKpeBXxINoqhFtpUURxL8bP
 A47Ow8UzsIF2uqBzJcUSVGB6grGZYgzo0zKYI1tyFjCIDfuaTo3XWJIuJYU0TjryHjvKTDo9ci
 s3p/t+vf9ADTrs+BmAAAA
To: netdev@vger.kernel.org
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761055261; l=1823;
 i=johannes.eigner@a-eberle.de; s=20251021; h=from:subject:message-id;
 bh=ab2aBiZkhVnAZht6n7kZykR4lr6thnnuBZUY5CjmYLc=;
 b=tCr1LYbkM4bLikfwHimZfAd+/HWdfre14G+W57AfSv0YWrl0aYRn0zI5w1tnjaUSF6YvDrMnY
 u92kr6mzTEiArzLoVEdgunaxci1v9L65wd/q0aj76kqJnI8WX/zAynZ
X-Developer-Key: i=johannes.eigner@a-eberle.de; a=ed25519;
 pk=tjZLx5Tp2iwCN/XmbFBW4CrbjZnFMF6fyMoIgx/dEws=
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|AS4PR10MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2b7eb6-aee8-48d4-ba16-08de10aa44e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG82YTlieE0rcjM3ZjBhZ2pwTVI3RFRSaHRxbDNYMUd1MDA5ak5SR2txazZH?=
 =?utf-8?B?Q2NmREc4emwwS1ZJOWdYc3RWb1ovZXYxSlY5ckJCR3loVVQzTmdTS2ZsUHdJ?=
 =?utf-8?B?R2JJb0QxeDZpM0VPczB1OW56aVNnL1IraXAxMDJrejV6SVByS2hySCs4NjZ1?=
 =?utf-8?B?U2RyVm1HOWFBUHZYbDBBeklxOUlBWnVzenYzcWl2bUhnVThaQTdNNkkwSjVk?=
 =?utf-8?B?SWY2OHhYSzJBWHozM0pIYnZBRXgzaWVHVlN4cWJySGhCTG44WkNWdXlDMDJ1?=
 =?utf-8?B?dEk2UVFpajR6azR1OG1INVFhKy9SRnl5N0tkQUcrQkNUTUkvM0ZKTGkyZjd2?=
 =?utf-8?B?b2FIK1U0M0N3K0pINjRhSnByWkdYUXA1REVCby9GMDlNNUlLTitwTFI5ZFZW?=
 =?utf-8?B?allaTVViZkNLVTRuQlQ3MC9uOUhJeFFPOEdNSUxVNWZtRWJMU2JSQjF6cDhZ?=
 =?utf-8?B?alNKSThHMmxiSmRYSDUxUXBPUFZBV2NxYnJZdkdMeS9KUzNtZVlCV2FKQW1p?=
 =?utf-8?B?bmRsQmFQRUZFc2tOUlJCaVFwT1N4bjd4MFVrR1VnS1lrYkM5aU5sMGxLdkd0?=
 =?utf-8?B?WlZEMXVvZklWTHdRbWNualZ1cThHNmsrQ2RiZDF6S01HRktBRko5Y3Rkb3dO?=
 =?utf-8?B?VjFraisrKzVnZndvZ3pVTWxnOVZPMG5pNjFMUERxU1M3MHVZVHdraHByRVly?=
 =?utf-8?B?SEtheXRFWlhsa2lmcUdNOTVvbHo4UndSM3h1a05yeGtrUWVRem1NWmlJRGxH?=
 =?utf-8?B?S3RXMm4yZzNwS0dDL0l6UkZBN1h3YytZVWtDWTN3cEJ5eERyQ1hQZXpIVUtk?=
 =?utf-8?B?ZVN0VjQ3bWh2Zys4eGs2dHRKdjI5STBUMVYrSkhDbWM4SW9GS3FPSHNKMEE0?=
 =?utf-8?B?a3RuTVdSVUN5UFloNmxnbGZLU3IyNHNId0o2L0lzVmVmRmdtazJML3VJWXJX?=
 =?utf-8?B?SXNheXFlRUFUMFdad1E2ODI5TGtFTFkxdGZjNElQT0RyajRZTDRpeGFScUg4?=
 =?utf-8?B?eUZLUnpNb0I3MlM0a0RBVHJIUHQ4aHdVMXljWG5TelFaN3VIYU5saWtLQ3da?=
 =?utf-8?B?N2JCSWhPWGpvSHptMHZjM2JuZERzVXNtZ0w3TFpiRWw2SWU4aDRHbjkzRW1l?=
 =?utf-8?B?TW11azBaT1NxL3N5bWQ4enMyckMvWG8yVHNjUEduSFhNbm80T2R1OU16a1Js?=
 =?utf-8?B?UldKZEFjczc4L2VkS3RhaWk0Z2ZkZTIrb2tJSnBrSWhqY3BzS2dZRE5hZm9Q?=
 =?utf-8?B?VHozdjVOQWRrU24wczdPdXFuQlIvVUFmTG4vcXQ4RFNtQllHVWJQV05xbnJp?=
 =?utf-8?B?NmFGZ25MaVJXYU5JazFNUE53NUxFVVNQcFozVEZFWEdVMlNsYXFKd3dwSDda?=
 =?utf-8?B?QUpWUUkzN0NUU2lNWEJoZkpOSzQ5Z0Y1OEVqSVpGY2lxODdPU3l0UEtwSi9m?=
 =?utf-8?B?VElWMEkrS1pyL3kvN09zUWRHZzhkelo1WSsrWnRXekdub01YVzRuSExYeDFu?=
 =?utf-8?B?dWRoVkltTDRFOUFxQnQzWGhCcFo3OGpYUEdsL05hdjVKbzI1ajhnYWZtQ09i?=
 =?utf-8?B?djhvTEtEbVpVWUxBSUZWb2FwYkEweHNEVGxBOGNsOVpwdjJObk1zcVpBTGNE?=
 =?utf-8?B?a0pyeDk1VzZaaGtCa0lzUk0xNVBza1loaStFWnBncVdocEZYbWpPcTlZRk1w?=
 =?utf-8?B?OHdSRkg3Qk5SOVBaRS9NY3JCUGU5UUQvSGwyUXloUXNUaWhJbjhWcnNDZ1FO?=
 =?utf-8?B?Yk1RWHRZTndPb0N1SGxaVVlmaVBSUlZpNW9BdDRTbzVUN1kzKzJ0L2N4RUov?=
 =?utf-8?B?TDFYeVowdCs5d211QTYwOUtYaldrYTU1ZDVVU20rUXlNQ0ZqeE1OS2FPTE0r?=
 =?utf-8?B?S0N1ZHFzanlNMDJlcWtXSXNHQ3BKdWhZZXZtSkJWNTZ6VTV6R2dpRHowOTVq?=
 =?utf-8?Q?ItyU37I1tcVLbe7mkcwzXR7S7aRnmR0W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHBNQ1AxZWx6SWRIQjNHK3RlUmZUN2h3V09nWk9INk9veHpuZFpnZGhObFFP?=
 =?utf-8?B?NTVVSngrMkJwU2NXYm14QmJXaURjOFpseUpzUjU2WXdNS2RQK0pEUkU2Wk11?=
 =?utf-8?B?OEl6eHhrU2c5N1NqK3h3eXJLa2h5UmdnZnc4S1UrMmJiNUE1YXEvSHpyUkdU?=
 =?utf-8?B?RU10YmlodW93WDhzMGNsOTFGVnVxRWtTMXVWKzF5YzBYVmR6cVZaYnl3RU5x?=
 =?utf-8?B?M3dPSWNxMjNuR3crQ2Mya1ZPNXNUei9hL2UxU1hjUTl1Wkwxc01xVTZCanpQ?=
 =?utf-8?B?NDRpYzMyN041SGIwcUdGUGxMdDN4SEZpcEk0bEJMaGRhbW1oU3FnZHUyeW50?=
 =?utf-8?B?anl5QmVGU3FCMGxCM09wVmlvWElyUGF3djcvNThnUi9wT2V1Zk4zS01YWEpw?=
 =?utf-8?B?c3R1NkpVQktlUFd5ajEydFI3VU9kZ0k0N004MmQyc2ROUGg3UllvMThlMDlP?=
 =?utf-8?B?QVhKVzZHT0Q4QVF3aklsN05maUUyRSsrSUNEcmZhcFZ0cnQ4azdGZ3BDQ0xi?=
 =?utf-8?B?bklwMEJYSElNeDJvSGdub3ZwZi9HQzkxR1h5MHByYytVSUJnbWQ4U1cwS014?=
 =?utf-8?B?NVd4OHEwQ2JDSGJTdmVjSXNYekk0UWoyVWt4c3FzVms1WE1rS2h2dkRtRXo2?=
 =?utf-8?B?Y0luN1IwSlk0RFFpNzQwSzZtdGJkQ1gyZHZHdkg4TjU2bzczY1BnWTZ1eDc4?=
 =?utf-8?B?WmlmcTdoSnpYb2JOTHVKa1dEckFBSWI3VmllZTdaK0cwbWxDTkFpbWdPNkp2?=
 =?utf-8?B?bUpWYkVINVJSN2V1UWlxZWpraEp0ZUZ2a3lCYzJuMDhvNlFiV0tZMDZvWUQz?=
 =?utf-8?B?d2dqRnF3Qi9IZytsSkg0R2Fjb2p5M1BId2lVTjV1dnY1VzJxb1d3QkhnYWk4?=
 =?utf-8?B?WGJteFovMmRQdldFc0R2Y05SK0s0dGhEZEhqZFlySTFjR3Y3UDV2NTM2b2pz?=
 =?utf-8?B?SUJYeHJFaXNXWjgxakVYMFozWThKc05iN0NNTjBzcEFDeGUrNytsL2szVUIy?=
 =?utf-8?B?R1ZHUDd2cjkvU3JTSE1pTCs4WnNrVGxzR1hSbVhmNlFJdEd4ZkFrejRNYzRt?=
 =?utf-8?B?N3dQMmNZQndJVkxVa0IrT1NoL28yMGR5Rndkb2ZBTk9GYTVtcU1MQnNudXMr?=
 =?utf-8?B?emliQVRqZ2lVR0lSWFJnMGZPRVVBUldmbXZBRCtWRDdOYk5jdGpLVjRaRDJI?=
 =?utf-8?B?UHUxM2wvc3BwSG8xcjEzNnRqcnRoZUk5UVoydDFadzRDR1ZLUVR0VTJSSnZC?=
 =?utf-8?B?YWZwK1VQUHIvbFpWb3BycGo1QW56N3M0OUNYblhvSTEraDA1U3pIM1plNkV5?=
 =?utf-8?B?OUhYNDBQNVR0V1RYTFIxbk94WGlDd0xTWUhoSFZEdmtKRDVvUVFqWDArSkFR?=
 =?utf-8?B?RUthUzVnMFJBS04rRE1acGJKOExJVDlIZjhNNWMvZU5IbWZ0NUZlN1QxUUxk?=
 =?utf-8?B?cXlTczRBNVdKc2REV0ZLZkFBbkJYczMwNkh1dXQ4OGVUNlFDVUJSY3l0RW9q?=
 =?utf-8?B?NXNsa0JYSUU5dFh0K3pQc2hxaHYzbU5RY0ZucFZURUMreHNIbUhnVEZmeDBm?=
 =?utf-8?B?NWViRXEvQSs3TVhONlFTU2pSNk1UTitPT1NybTUvOUlSK2tkRW04STNXZnNK?=
 =?utf-8?B?QnVYL2J5K01jQkZuSHRUUG84by9ENzA2WTFZOVl2RXJ5OWJud1d1bVM2My84?=
 =?utf-8?B?Njd4Nk1HclBHL0RVMFcvcXE1M3IvcGFOREZmSXl1cXFONmZyeDBsdFBiWnZt?=
 =?utf-8?B?WnZ6cEl3c29RUE9Ga05POEZjYnM4dlM0WHlrUzdkYU9nZGEvMG1BZi9OVDFN?=
 =?utf-8?B?WUlOWXNQbHhSMGVBd0JJK2ZadlZJTDFRQ3d1SForLzFWU28rVG5MZ2twUTRh?=
 =?utf-8?B?aGdvVi8wemZ1S1FGM1l2eGtiZGxsN1BiWUtxQlh2anJoY3VHV1d2YmdJL0ow?=
 =?utf-8?B?Vit0MFlmWUZlYVJtczhiQlRTYTkyS2lRMTRQYUQ3TWNJaEdOSGx3aWNrVnlz?=
 =?utf-8?B?VndUaEJUY3RnUFZGUVdOeENSYVBJOGI5SzQrMTUwdG1lY2g0dThmQTR6SC9U?=
 =?utf-8?B?MS9TZ1hQYjhIaDA0clJmb0ExVHVxdllhUk1LOFBGV2FlbEh6RFF2QU1IVWY4?=
 =?utf-8?B?STZzMzRYYThTcGFPOGpGM1d0cUpLR3ZjNFQ0S1gwd21hanBVR09wUTNaYVNn?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2b7eb6-aee8-48d4-ba16-08de10aa44e8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:01:02.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjdZAutuGVTuyxrnUkdsP/Tns3VNSZIYO8dtYaC82r88twfw655r3f+i5BWuG/sS5IP1iV5mG07vwz+Kkcg7Ou1Bzg4B3jfoNG1fHRO9Xls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5941
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----5A71D6C5D61B60EE32F9B4CCFA8A2110"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay10-hz1.antispameurope.com with 4crYrX6FZNz2dVGX
X-cloud-security-connect: mail-northeuropeazon11020119.outbound.protection.outlook.com[52.101.84.119], TLS=1, IP=52.101.84.119
X-cloud-security-Digest:f25ca334f98c41bd190404c80c1942e8
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:1.782
DKIM-Signature: a=rsa-sha256;
 bh=td2l+RSFouZySvonviPU9tUxkRcmnoQWhJn+xWVCmrs=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761055335; v=1;
 b=rBlF4gORzz+1Ys5JHW6h2m0PAU9NT1QQpBFI7wf0f4yoKzQy4f4ZlH2NViAoxDQ+WVJWb5Nq
 PbvTteaowMGTP6qE9+JFrCSqZ9YeFIB+lZ2oYmi1mZLM3vvh1/L5qiKzVSnr4eF+tI6HIwAL6lT
 wsFogrC0egzMRPO/QKUvvQsHWou/GaYezhAuDj4+1KgyENYIBahXQSI3mgXCFfYTsMuJNTcQuVt
 uMiLeNtYHzUi4tUZNki2VNV8kINz9x/zNso8at0Fiy3Pfp/szyv8sNqqRMZkqcSDvTDTa1uRold
 q+hu/0bYdjhLutyelDqVXvPeD8gjTux6SGLmKOeyCwgUQ==

This is an S/MIME signed message

------5A71D6C5D61B60EE32F9B4CCFA8A2110
To: netdev@vger.kernel.org
Subject: [PATCH ethtool 0/2] fix module info JSON output
Cc: Michal Kubecek <mkubecek@suse.cz>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Stephan Wurm <stephan.wurm@a-eberle.de>, 
 Johannes Eigner <johannes.eigner@a-eberle.de>
Date: Tue, 21 Oct 2025 16:00:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In one of our products we need to show the SFP diagnostics in a web
interface. Therefore we want to use the JSON output of the ethtool
module information. During integration I found two problems.

When using `ethtool -j -m sfpX` only the basic module information was
JSON formatted, the diagnostics part was not. First patch ensures whole
module information output is JSON formatted for SFP modules.

The same keys were used for both the actual and threshold values in the
diagnostics JSON output, which is not valid JSON. Second patch avoids
this by renaming the threshold keys.
This solution is not backward compatible. I don't see a possibility to
fix this in a backward compatible way. If anyone knows a solution,
please let me know so I can improve the patch.
Another solution for the second patch would be to rename the keys for
the actual values instead of the thresholds. But this is also not
backward compatible. I decided to rename the threshold keys, as this
aligns with the naming used for the warning and alarm flags.
Second bug is definitely affecting SFP modules and maybe also affecting
QSFP and CMIS modules. Possible bug for QSFP and CMIS modules are based
on my understanding of the code only. I have only access to hardware
supporting SFP modules.

Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
---
Johannes Eigner (2):
      sfpid: Fix JSON output of SFP diagnostics
      sff-common: Fix naming of JSON keys for thresholds

 sff-common.c | 50 +++++++++++++++++++++++++-------------------------
 sfpid.c      |  4 ++--
 2 files changed, 27 insertions(+), 27 deletions(-)
---
base-commit: 422504811c13c245cd627be2718fbaa109bdd6ec
change-id: 20251021-fix-module-info-json-0424107771fe

Best regards,
-- 
Johannes Eigner <johannes.eigner@a-eberle.de>


------5A71D6C5D61B60EE32F9B4CCFA8A2110
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIQNQYJKoZIhvcNAQcCoIIQJjCCECICAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggw7MIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggYjMIIFC6ADAgECAhAl
5qzXGH8Da+FSta/hHFZ+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIzMDcx
OTAwMDAwMFoXDTI2MDcxODIzNTk1OVowLDEqMCgGCSqGSIb3DQEJARYbam9oYW5u
ZXMuZWlnbmVyQGEtZWJlcmxlLmRlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAwEFNcbuq7Ae+YCfg2alacqHWh08bvE6bFOZZ1Rxl1w/sFuXUwJ8o+gbB
TA/mmITzst+fnsjwMmrjtCecn8wILPitSD2wXy+yiaWmn8ywuBBw8toRX0xSMgif
KM494f9SSFjJDOgZGmAG+umMO6v5KNA1K0wSWrlZmG0yC0pzp6FFVVyMnp4/vJh3
6BuYgOf0s7KK5ShCQ4mKOD0dOOcMTBFHcQuD8d2Ha9lH5KzF4CVR6W3p+DUs2r6o
WwSPc0MrTqq0Ci9KPaKmvxzMQRZqSqa5ySqyw4guw0vnPYwtS0BEYZM+mL/5BwAP
Uga7nUg/9tjzyEgUY3tmimfWD0UIi9oDHT59n4s5iriWcnZNS5dAWnu7NqEBs+w6
lpWo2g60mmxPULNnwSUYxqdfXn5udIde0boYLKfEy11JC9xkshXBgLPhq4xTkbWs
fkoH+EQyEdep5AhaLeTsJHpw0tp2whpeH9Fwck8tx/nWtudo7bfYZUF4lDtyEHmi
p7UJa6x4LKEO2XFlY5v6ZOfVAm+zqNWEdDGO3bfv3HO5ciIHjXHLVFx/XI73OVsC
aObazBuEcqXafTK9ThLS5Sh4uZ3nLv3n5m8m/UUUKbOmOI7MTId7WlP9hOeNAzEu
SiA/n8VFk4RO7iwajXximGU/0rxuUJtN7RJFumksH7sbO5ypjCcCAwEAAaOCAdQw
ggHQMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBSz
BXMVnJ+omSJdNUgpzP64lg+gRDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIw
ADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1Bgwr
BgEEAbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0
aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCB
igYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28u
Y29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAmBgNV
HREEHzAdgRtqb2hhbm5lcy5laWduZXJAYS1lYmVybGUuZGUwDQYJKoZIhvcNAQEL
BQADggEBAMJhsGQW6C4UBZr7OpMg/n65GOd5Iy7i3vXW7gO7sgPe1pHYi1LJZ68J
lB9sP93yDViPMJ4Cir+/QqU7AtLyKkf+oo8nQTlx5gQeJnftZ/O6RkCS20I18GxC
aRDRRwD2JViL5Dk9uB87sV5DlOZV8w2VNWh+mm8wZGonaQ3NoNX+7jHcF5QX23Hx
x8ikwfv4jj3qajpv1l362Wl5FySKhdEXB/hhyxLjMfHEYs8PKHnjeWGbMPnqyTtt
xgnK+Gtmc4fjSlRf8Nzpr/q3iPppdSOmVk1lGmaGTJ+7ItiA1OTcFf7Atm8GomFp
QXdyoI/DW3zj355K+YADYhwhosfaQY4xggO+MIIDugIBATCBqzCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQ
Jeas1xh/A2vhUrWv4RxWfjANBglghkgBZQMEAgEFAKCB5DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjExNDAyMTBaMC8GCSqG
SIb3DQEJBDEiBCD0CykpnVN+c9GZIIthME2G0g99dSnM417lWawiT9iirDB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgA6jsgxLTQL
DhhaQVu233zIbMhFJsXvbcCe83edcIoT9OFpaMpli9vRCG6GL2sJ1NDO03esZIur
0nVoyRow0SY7j4250y7XC5xpHWmQq687PpWB6y1TUjyTaPi3H9wYyVzuiH+IqGuw
cezJN/l5rYQ8iYCF2g139xRQvUagf3hdGLOOUvZ9zXL/0jqzxt9nGoQgaM+3bYSQ
OjYImf8bw0hothEModgrQMOTAGonyVWZvaG2iuonfBTNIe/UdBy17o1KVP+HzRET
Et7l2V9BZ8jJ/aulD9evN7E9pE+PiCGpv+TNYYcaUwgsx/JvxQG3hd1t8dTaCWNx
yCW4/dpUazDSYBAGwlycragjOMX2B1Lp3w7YjZp8LA0xqQYPRqUO7o2DrQj6L9ch
65malj8UGmyWIet/vbNsU7wzdMRNnb//tFDwtJzvE2njEyd3wRwf/wGcB78THm8y
ZpH4ql2p2WFGgmnxnJWOkLqKVPYbZz97L5+HpPG4cght97fKyKM+I7/37WNnRGfK
cP0hxcgGntptG9kqpky428yXZ35flBEoGRCg2UJdmXzHRfue4GPYo4gOAZihteZc
xCrdFqvW8XrrB77wDLI5l5z6BcGIjcwZzOp/9RjhVqiuWJhG0zYGSxHdNDnEKYAH
gywCNDn90CsERqeJZZ90o84WoaTwDf0hUw==

------5A71D6C5D61B60EE32F9B4CCFA8A2110--


