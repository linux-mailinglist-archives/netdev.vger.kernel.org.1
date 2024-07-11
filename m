Return-Path: <netdev+bounces-110784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF71692E541
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36F51C20B26
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CF4155C8F;
	Thu, 11 Jul 2024 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="fk37KLr9"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2130.outbound.protection.outlook.com [40.107.215.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060FE29CF0;
	Thu, 11 Jul 2024 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695537; cv=fail; b=QHXK4RkzwZJK6XAnML3ZDQ9z+bH3aMz1dXWJbOWppFbTvw0rAhiatrfxx2F17F91TjCDet+OxUcm0TAueUggNnhUDt3Tojs7UNBPo/qxtI6+mwAMYnSy6ZpSh1q9ALJ2l/w/J1pw/V3JjWJWOHkwWH5vqgjibq+ZnwgTtN/KPBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695537; c=relaxed/simple;
	bh=5FkTn9x+bBTQwr9+JOXgDgotK1NfKiEgMyYBpBrupDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YTMhiZp/32c4bxmDk3ZqqVl0Gl6D1A+BVufv6dakPGnUx346mx9KLM/jOTKskzJ4BaQdAjnGzc4Ecuq04BhGsKemfaLk2/TN2y4w7sA3ZM4zU/vNB3lmwcE9GgN6RZLW4/gkTULqfskhpUqJo2s7+1iWUC8FBUTex6SM4xQKnCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=fk37KLr9; arc=fail smtp.client-ip=40.107.215.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnJOtFG0gBIgfs9dlHniuRb1BzSIzhu9cHyTsUFfn/ozk8VPReuGWr1DH7lO19LCz9vCkjpEpcyXN3yYDlce6vxKcQOge3YHu+/sE5GtwY2LIfsCfIscngp3VM3G+hKEMp2/fvU7dW308BxYHh6TYCiYc3i/8NFnsGNav5etNLnyT1NpJi7D2bsbG76nhvUEmgiidGr+y9zOqQZJuhF+PAWjSs7K2i6uoqZEUewwBmDAi84/Cem3C3B8NL3CZV+FrbdjRxtErai4CyeKEWJpyPmn1mso7pF5djn+PJXjkx/aQRhbt0ZGz2I/96UE95as4+xT9ksBOsDHpqkCzpH9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/GgphnZtUp/ZCrBam9+stuPR7qMFcKl0T0H5pLTDU0=;
 b=H069LXVyPKcArAufnkcNQSRIgK14ee3K8PY22R+0zQHr8lC7U67A/jZ1O/LzWU+XimO6BfnwCGmsdRuLw1eY+OWFtSOZUly0ZOJxQR4OkOkp0eUHXrYa4qiqLY0BZv2RNTZ2cyOly7skQJB1FfhpNwOtXvB/9n8cds+p42PzUJX9ar9SIHlLVOtfhe36SePgPBBwAqQo+X1flw2sq5NFh2ja2wV4kEzkK2o+ZwTMBRkjrYsXjXom1fV5d+hepnFFMWfzDkDJlsb5t/ZbM/DVhfYvV6bREM8A641YESvHjPP+LwuVuhZpmoFh9wD7iFfYSfqewXmfNAQ+FSiSTCJO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/GgphnZtUp/ZCrBam9+stuPR7qMFcKl0T0H5pLTDU0=;
 b=fk37KLr98UHwkwcYftmoV2roRX7tVvlP/CqTMs49vY4jhehPdH367EW/oonoJBN0rjSqNx42W3pUBPpfA2gWNti7bnhrmV6eGkfyj92NwOZsd0b/A8hoOUH0NNzpNsfaIKoHjD2Vgua2+OFvtNPn9eKC18xIt4rtZLWvmIU0uMbNvakhjFzFYgEBm0dFFJ5KVGMvEwgvnweokqEVTpt9+toO/wUhW1ky0tMFO9JfKaWS797Fib/qP14rKUyj4tfgLRbi1p33scnEru6F5wQR5vKV5NEBm0bAoQDEERj7zNTsOF7i4giTnJnse06gejMQZRfvQBlL9447OpqZqy+3Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by PUZPR03MB7015.apcprd03.prod.outlook.com (2603:1096:301:f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 10:58:49 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 10:58:49 +0000
Message-ID: <def67927-3ee7-4e63-a802-9eccf9f60257@amlogic.com>
Date: Thu, 11 Jul 2024 18:58:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: net: bluetooth: Add support for Amlogic
 Bluetooth
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
 <20240705-btaml-v1-1-7f1538f98cef@amlogic.com>
 <4f677e02-a7d3-4d5e-9d80-88169f8ff201@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <4f677e02-a7d3-4d5e-9d80-88169f8ff201@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::33)
 To JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|PUZPR03MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e8719f-cfcf-4d78-3779-08dca1987174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHkzcVV6VVBFb0xoWHBsZlR3S0Y5MDdZeXBrV3pwWERYZkczSTRWYytqYWVR?=
 =?utf-8?B?TG42L042Tk9vNEtHVzZFTFJFQW1BaWJzSmdQL2I4Z0kyc1F0VEVHYWk4V2NP?=
 =?utf-8?B?dENCV1J2QUNsa3hhbU5pbFpUVDFmd2V1NG82S1FJKzlDQklxQkludkhMTmtE?=
 =?utf-8?B?ZENaZHh5c05VSmlXcUgvdmdacjdtSStKU1duNmtxZkRqdGxRZ05ySFNudHF6?=
 =?utf-8?B?YWpYQStRZWcyQzFOeTJ1SkdIYVVQQWNYS0IxT25McUxKaW1iNlVuRDhIUDQv?=
 =?utf-8?B?ZlQzTzUvd0NjOHdRbU9VRFAvSy9iQzZ6ZmRaMldIWElkVXNkZEhiTU9BQm85?=
 =?utf-8?B?c1dUa2k0aEFrQ01PNmJOV1hJZlg2TjBpMHhTN1BVb0F1N3hQUjZLSVdVMjJL?=
 =?utf-8?B?bkFPWmQ2NzVhMVVuVjZOSS9sZ0tHQjJEL2oyWDBiNHhuQ0RzMEhjZkFFQjFW?=
 =?utf-8?B?SVRkQkhxejNtNXIybThqbHljRDdBb0JXR0x3cUJJL1kraitYcXFJR2Q2NGJT?=
 =?utf-8?B?akJFSndlY3JValVQVURMQlZTV095Q1RQQXFnbnpyK0ZaQ3NDV2U1T2VRd01h?=
 =?utf-8?B?eGptOTdZbVhKaksvWThHc0JDbTFWU0NIN1JxdjdHMWdJL3UrSmN5QmN6Zmlo?=
 =?utf-8?B?cFd3TE4vSjI4NkFtaUJrNkdPT0h6Q01URkhFQzBLdDluVWk5T0ZOcDgxZ2J2?=
 =?utf-8?B?dlBTSUpjZHJVOE1UZTY1bFlYTFoxQ1VvMDRuajdwYnRqeHFpbktpUUZTM3R3?=
 =?utf-8?B?dzBaQzRTd2x4Z2EycHhadWt0aGlGOGtwUVZ1SVdWYS9TeWh0aGpkd1hmRXo4?=
 =?utf-8?B?Y2NFclF4L1ErWkNzZjJxeFZrUEJjeEtrdldwWjdXam8vWmQrMWYwS0txdnVs?=
 =?utf-8?B?bnBpUFJTUURTRDFudHpUd3lOK1d1YUFyK0wvbXk1Q2hMZ2k4YVpwVjZUMXVI?=
 =?utf-8?B?TlZPTlhXUVdBYjlUQnZZUWxtMFNNcWgyM09tSFhiZzliNzNsNGd1dVA5TXhW?=
 =?utf-8?B?ektYNnMrdkc4SWJRdENMcTVHOVZZSnNLRGw2S0ZjaVZCc252R0UvYmxQVVpC?=
 =?utf-8?B?bkR1WDR4M2hJd2dRdEo2V2p5ZTBwV21EeHRWOUt0cEhzcS9OMWEzVE5keDdt?=
 =?utf-8?B?c0xTNWJ0Ylg5UC83TExJZXo4dlRMM0dVck15aEp3Mm90YVZLM2dVTVd5U28y?=
 =?utf-8?B?RGtZaVhIWXJndzRpSVpMeXc5WW1QMUp4Q0Zvd2lVbzVJdTdQZVpSSmFqdVlW?=
 =?utf-8?B?QWJycDY4SE5sQlRsSXpkcEJJS3pYRERIVDRrdENhVnE5NWMzRTBSMUJzQXoz?=
 =?utf-8?B?bERwZEN6WW5HaFpkYzFEYTlISDlGc0pyalVqeW9wbmphV2huZWVQWHkrU3pB?=
 =?utf-8?B?S0ZoelBMWU5ISlBSU0lRRFBvTTlxQUNOS1lmRUdYanFpeXd0WXVjSXprRU8y?=
 =?utf-8?B?d0tSYys5U0dTM0dNUW5TRlF6VVQ2Y3hEUTZLYjMza2tTcWFnQld2cVU4SDNn?=
 =?utf-8?B?eENHRklVRVEvRzMvZ0U4c0NPZmptaGFYQTZvcFZUejFQeWExMFpqSzk5TGd4?=
 =?utf-8?B?TThSVDZNcXllcEFtR3BRTEkzL2xQL2o5OFI2RlBldG82bEZPaE5SNWN5L1hk?=
 =?utf-8?B?SGVEcWhrZUVaYnZnT2hjNVFDSk52dmpLa3lEYzEyYXhFYWtpSEV4T2JHUVBT?=
 =?utf-8?B?ZWpNT3JGaThTQ2RJbzZkZ0hqR1ZyZ3o0eUN0WlR1MzNlOEs0MzRDMjlsK0Yw?=
 =?utf-8?B?S0dFc2FiSGJYcXJ5RnVodzZ0T29obzF6WGV6eVZPaGsyU0FvTEo2VDZNQkgw?=
 =?utf-8?B?enNUa2NBRlRWRzk3OWd5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzhDRTFNVUhXWG5IMkRJMUZBVDRzMko5elpReEFnUVEzenpFSFRZNlVXRmZK?=
 =?utf-8?B?cmhDSEpiTEpoMUltWHpkaFlZVzRTMnF3UXQyek9HWEtxK1pNaUc0L0JHMjlY?=
 =?utf-8?B?UXQ3anBpZjI1TFhLR2UvSkR6TVdRMmJPL21EaFdVbFM3YWhkekxNWDNYV1NC?=
 =?utf-8?B?WVo0VW1QSWxGTDdsbFk2S3kvQU9HbnN2b0hLLzY3RUZzaVlKVzRTcy93ZW1O?=
 =?utf-8?B?MXBRTmdkVmZEYVZ5MmNYYUJlTVNja09OYmFHUFBsMnIwUWJyY1lxQ2drRVh2?=
 =?utf-8?B?b01FT1VDb0hZMFJveDJvdlVWb3B1ZWxJc3ZNbCtScVZ3cEp4U2dBQlBLZE5C?=
 =?utf-8?B?OUVMclpaWGc5Y2pmdjJEM3ZyVzBFVmUwWjJtd2hmSWN4eXF1V0lUYytzUm9l?=
 =?utf-8?B?YTFucnZ4aVFMWDlYZzlMZG9wYy9WMnBjRTU1VStvcVV3OW5MQzBkc3EyZUFU?=
 =?utf-8?B?ejVja3FGa1dJTWRuclpSekR0ZnY4dkJUNE40dkt6Z0FuUGhnZytjQ2wrdVk3?=
 =?utf-8?B?cFF6c2s5M1hiSkNZUUpud3FpRXB4ZXdkRlBWWnhNVGFpT2wreWxTM0g0Z0JK?=
 =?utf-8?B?UkptbHF0Ymd2NERiNVlCeHJHeS9HR1ljZTFUelcvQzRLcVhMaHNwdkdZcDhk?=
 =?utf-8?B?WE9lOVkzY0t4OEVtR2orem9QbXpoYzV1eitjcE82SWRYSEE0dENnQkE1Z0M5?=
 =?utf-8?B?UVplV2pyOFdlY2I2SGJGeXBYa2ZCTUZta29pN2kvdnRhTmp2VEZhOGhpOGt5?=
 =?utf-8?B?VjJIc3l5bUtUY082aGoxNGFMT3B4azB3TWhZUFRQdjlnTWxEYW0vbFUrRWJh?=
 =?utf-8?B?NUU3VSt3dUtvNGR5QmZTdlFseHRuRFk0VHRTbFRpYk5GaDRFTmJQOVVqQlQw?=
 =?utf-8?B?R0pyc1lpdzdsMThKVUdqMXAxOXk3Mm5RNmtpc00rVitqVjNsNm03S2NTdXFh?=
 =?utf-8?B?aXlNamkrbmlHaFRGYzVFc29naTdGV0tpbmhNeGk4K0VnS01aWkxlNm83Mi9n?=
 =?utf-8?B?UzZJYzZqZkljVjRXejNLNXNZTE1wVk9lTlh0SUZncy9aaVdERERvZ3dHcmll?=
 =?utf-8?B?K2JIckhYMzNPV05sSTVIS25vNzRXN1gzR1RLaG1jVmczNEtMcWhNMHl4dXRK?=
 =?utf-8?B?eFN1QzIwZ0ErMkJIdkFMczgrSjFoSTJzREswN0V2QlBSRGZsZUJCdzJ5cnRR?=
 =?utf-8?B?OUNEZE1Xd2hRVkNTQXpJa1NsYzdUY1pjdnJhdkQ5UTZmQVpYSzFlUzlNc0w4?=
 =?utf-8?B?cXA2TmNqODkwS3BoWFlBcnRaeDdnRmtRSFptTjdMS1QwZWhLY3pidnU5bnNR?=
 =?utf-8?B?MG0vOXNTUjFsN0huOEljNmJxOUl0enkvZ1NoZUd1L2dkSTJRMmJ5cEZnazRQ?=
 =?utf-8?B?QzROcGVjOE45MXladXJ2Qi81bHYvb1RDNTh2LzJpcUhvQ2lmamRMYUN3QnZr?=
 =?utf-8?B?Nk5HbkkwRElqK0ZUNUdhWjZmdjNkS3pDOHZLYVB4NFZWNFlFczlaQ1libzdx?=
 =?utf-8?B?dDdzREhKUFRmbXJ4c2dOc0ZVNENlSzJhMkNIcEJVcVptODBtQWJrdnZ6ejhT?=
 =?utf-8?B?Rm1RWElKNUxsOURMTTdqTzV4R2NXSnowc2NTYi9QUWVqcGsrRDFMZmtSVTY4?=
 =?utf-8?B?WDVvbmxEOWhmbUswMS80Um9jeWdpWDdlMmUzR2dleXVIdHpYQUJCa1ZOZitI?=
 =?utf-8?B?S3dxaXhnYUVNaW03STFNMlY0cUtvbHFieng3TWlLUDVCL29aMks3ZVV4cHhD?=
 =?utf-8?B?cVJlNE5jeGJVSTVPQkNLQkl0cUlacHAzSCtCaHhpZHhkeEFsY3hUZURIS1U4?=
 =?utf-8?B?djkvbWQ3UVZTNkJpQ09ycVIwM1RlR1A5K2ovdlFJQTBwNHBmRytOTk1jM3pM?=
 =?utf-8?B?UUYrRkx6Szh6eWxvVFlYaXhnZ1hjNmhzTHUreHFIVkc4YjRrV1Z0VHRvdnVu?=
 =?utf-8?B?SkhwSmRGcFVoU09uclN6cjliQk9tTi9VaXQ4ZGoxMXUramJ3c1hWb042b2Jz?=
 =?utf-8?B?Yk0rSEZ1cWtQTGFwNGtsTmZ2cWdwbzA0YkpYdk5DdjZTWHM5QnpMb3plQXRE?=
 =?utf-8?B?bHIwb0srdm02VW1nWFNRalMxRUMwQnNVNUh1MERlY2lzbGF3Y0syVi94aUk0?=
 =?utf-8?Q?+J9c0S9dIlszofS3ZIuybtUnD?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e8719f-cfcf-4d78-3779-08dca1987174
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:58:49.1381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 040u94nFv8meTTjH8DP5CJfxtXYWtnOapJ7EwcM5pbN+xd/VYoLKwzr+8c9d3nH2HMhK5YIBZF0ykRVqEmVQlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7015


On 2024/7/7 21:08, Krzysztof Kozlowski wrote:
> [你通常不会收到来自 krzk@kernel.org 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>
> [ EXTERNAL EMAIL ]
>
> On 05/07/2024 13:20, Yang Li via B4 Relay wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Add binding document for Amlogic Bluetooth chipsets attached over UART.
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml  | 62 ++++++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
>> new file mode 100644
>> index 000000000000..d59e3206af62
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
>> @@ -0,0 +1,62 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2024 Amlogic, Inc. All rights reserved
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/bluetooth/amlogic,w155s2-bt.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic Bluetooth chips
>> +
>> +description:
>> +  This binding describes UART-attached Amlogic bluetooth chips.
> Do not say that binding describes a binding. It is not helpful. Describe
> the hardware instead.
Well do.
>
>> +
>> +maintainers:
>> +  - Yang Li <yang.li@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: amlogic,w155s2-bt
>> +      - items:
>> +          - enum:
>> +              - amlogic,w265s1-bt
>> +              - amlogic,w265p1-bt
>> +              - amlogic,w265s2-bt
>> +          - const: amlogic,w155s2-bt
>> +
>> +  amlogic,wcn-pwrseq:
> ??
I will remove this line, add regolator.
>
>> +    default: 0
>> +    description: specify the power sequence used to power on Bluetooth
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> What? I have no clue what is this and have no clue what to say here. Drop.
will do.
>> +
>> +  amlogic,firmware:
>> +    description: specify the path of firmware bin to load
>> +    $ref: /schemas/types.yaml#/definitions/string-array
> Srsly, it's third case in your bindings. Do not re-invent the wheel but
> use existing, common properties. How to find them? Well, git grep or ask
> your colleagues...
I will change "amlogic,firmware" to " firmware-name".
>> +
>> +  amlogic,antenna-number:
>> +    default: 1
>> +    description: number of antenna
> Useless description. Do not repeat the property name but explain what is
> it and how it is used.
>
> Or drop the property.
I will change the description.
>
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  amlogic,a2dp-sink-enable:
>> +    default: 0
>> +    description: enable sink mode with controller
> Again, not possible to figure out.
>
> NAK
Well do.
>
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +required:
>> +  - compatible
>> +  - amlogic,wcn-pwrseq
>> +  - amlogic,firmware
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    serial {
> Drop
Will do.
>
>> +        bluetooth {
>> +            compatible = "amlogic,w155s2-bt";
>> +            amlogic,wcn-pwrseq = <1>;
> Joking, right?
Well, I will remove it.
>
>
>
> Best regards,
> Krzysztof
>

