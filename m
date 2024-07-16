Return-Path: <netdev+bounces-111650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAF3931EFA
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 04:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFC21F223B4
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 02:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5D9B641;
	Tue, 16 Jul 2024 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="S9Rc+s1U"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32226AC0;
	Tue, 16 Jul 2024 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721098153; cv=fail; b=PrM48pKf55WXg0wzc/ej8MyrSxNEXh2PfUuCR6pwBJvsl7no0KlAMOdydPPJ5TignniGaQlSfisKR1mmCk4MCSAWQ0nuRfIYOGQYfhyN6H0ihm8FrAE1XcVV11jNxijMcMvyI4JDXabZir7Z9kauFDvhnzD4BzhJKoVArsHu6Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721098153; c=relaxed/simple;
	bh=PKnbUryz4F3khrN50cyYVjq76j6Bo8Fxk3EhxX8TNIM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TB6EGytOO3UqesvVbnSOAqEd41L9/KjoxzZxZnTFbULbUvNLtK5NizCeZ4GZ6A8WTv35zzaC2hRl6lWJQ6ZQ6116uCzGjfkPudRNeNYumiQxt0KTW+PrnVDx0r14qPxRYWvny9IkDUTcUSls5nfrbwIUz9mS+dr17DLPAJi0DII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=S9Rc+s1U; arc=fail smtp.client-ip=40.107.255.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjuhLRsUYkmn8A1lcGXcrEUF6C9PdoLNEOwumMqvUx3LMm5Vqt6Rih/CwTrRkjI1IG/tg5WcPAJVPbJlVlxgLMhN/cxYnxhYaTYGV86Lt0cVD6tIm/dxVlyU7tdJHQRtp7kSGJa5qoO7fH75nwzKBV69cfklfyyptDX4EKmUn/oqfRlhOEJkqu9kGwtqztUZylfsPbakGJg0ckVjcHvCnh/pIkf0und/Xd6mZh3lqLIXH1vg9IwcQB/coAQ6ztlTCTvBncFm+9bj9M/ha17fiSOFqcaVMtOhQyReTI5kXVc+HMuOJGJo5n848mstYrNrxW96hJWOtlg7fZXwn59USw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSHUn+kel9yQkCNnFdbap7rxZk2iHSozM5Xc0xMjpg0=;
 b=YahCdjwcUZLnIove+xQH9pimH51O9EUPcLV8jYd3BHLHyUgqtP/S/9lFU3ctq7rdDwwhz/t9AhX79Ce02iDumw3EK927Cnrs8TOd45vwklzxz/DcDfDU7hZu3dpDEbR+rkqGgpUblf5Gn/JApJcSZbwIsZMtQCf4hP2iVf1keklglr3bY6VeDhnMjE0g4FW0JCxwJi9LTB613jqppd4dC9myjYjMXW4yLVmSZt2ksn7aO4xtY3ZD9mV6zFRtYCSjb7PXscEuZ8ZJaj+umiSLz5YQlxQLh3NgR62vtUCfdfaprfDuis77LgVp0NUp7MpCrEK14Y+NvWOnAnXksq7dDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSHUn+kel9yQkCNnFdbap7rxZk2iHSozM5Xc0xMjpg0=;
 b=S9Rc+s1Uf1XJSqRQx7QUuchtX8Q1BzSXhKNsv+jJWq0Lv2KIaTHKDHoXlTOs3S145p3R+RLCB1zHaNrflhftF21dOdY4qcGRPFaM0xBNKpshzYz4J2AzLWNuGRHyjhEKkVROmEuDleAbOVBSSN8paF/F69sF4PHcvOuC90fPAVs/2t/VZ/3crCdRpMCI7/rgpaCeFDsok6h6mGfwxn3QELak/k8GizmsihrkNSbJ7+X32SzLS17JjYjUwYTvSEipiWXggGguiv568bWv+ohrLPhbEI67j2Bumg3f2Bf05hLFCtxgmAfeu9KEg8dxtXuerTfDrZeqMyCcvUS2knp6lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by JH0PR03MB8333.apcprd03.prod.outlook.com (2603:1096:990:4c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 02:49:06 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Tue, 16 Jul 2024
 02:49:06 +0000
Message-ID: <6fea3345-93ed-4296-abc8-e52b1bf6b76a@amlogic.com>
Date: Tue, 16 Jul 2024 10:48:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] MAINTAINERS: Add an entry for Amlogic HCI UART
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
 <20240705-btaml-v1-4-7f1538f98cef@amlogic.com>
 <131066c6-5ef6-450e-b85a-b75edf459368@molgen.mpg.de>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <131066c6-5ef6-450e-b85a-b75edf459368@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0251.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::20) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|JH0PR03MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 245586b7-e721-4255-121c-08dca541dc23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXltWk9hUjdNWkxtOXRrS1FhWFdzUTAxcWFmSXpnWmlaUFFWYTY1M3E3ZEpW?=
 =?utf-8?B?YWhRUUtnZEpYNUo4bGh0cmxvSURyV3ZUL3piTW04ck9RYktVQU5HNnRGL0ky?=
 =?utf-8?B?UmFXdlhENUp6NEY0aFRUSjd1QWdhaWo3RlJRN3U1NUFabm0ycVJGQno2S1VV?=
 =?utf-8?B?SThpMi9ldG53bElKZnFyV29tdEdPVW5VQ2tCY1FaRlVERmliNmhGMUFWWXdw?=
 =?utf-8?B?bnRKeDRJMk0ySlZwOW93VzVRTkJVbW9WV2plY1FaWWdDREhMNGxNZFdQOWlY?=
 =?utf-8?B?cXFqV0N2RUxESTJoaGJadzd6T0xlaUhNRDh4YjFqbEE2WldyVTdNR1FkZzdi?=
 =?utf-8?B?K1Y3WmdBanc4T05hVFEvUGJaQXk1NjhPQXNDVXJwRFZCN0Q4cHhMYlU4VTRy?=
 =?utf-8?B?RmMvQk9YSE9qbVU0ZU9yRUkrUzFVbzN2b055WE9ONjJ5Nk1ra1pCcXZ0MytU?=
 =?utf-8?B?UjVnNVp1MGdtdEx6MUJmUEs5SDA3ajNpeXJTL0lsL0JmaEdwMnVJdVl3UlR3?=
 =?utf-8?B?b0F3WEF4UzZaRUhFTVdicnR4NkprQnNTekIrZ2hmZlpDOCtYdjhZb3lRMjJT?=
 =?utf-8?B?T0VTcGRqRTdmWnZHNzRWOTBXZEZkTTJjMlNPMEd3U2RkeEVKOWhLT2k2dU9G?=
 =?utf-8?B?cUhXMDhUTWlmZkZvNzI5aEdvczFWNDJaNXpUcVNCMUxzaldkQm9TNmUxYUZ5?=
 =?utf-8?B?Q0ZBNElqRGdhZWFiSmU0V0hDRzVsdjZ2c3JhSldZQmltRVZLZmZSK2lvZEtt?=
 =?utf-8?B?NUwwWi83T042dnJYNWpwclJBUGhpR2lLS1NHWmZHamc0Vnc4Y3djTzZmOHNJ?=
 =?utf-8?B?eHpmc1pLeXlUYW5Rb3h5clVabnBBQVMrMmZsU1Z3V2oyaVpCUUdxTnd0T3h4?=
 =?utf-8?B?ZW1zbWlKYmhKMVRxNXh3SndLZG5mbG5nM2dnZlhtUHF3eWZuRjFIbkozQlpL?=
 =?utf-8?B?RjhZM0lxR3pDeWlSSDNQTjlydm5NVnFRZmQyOGxvUmJ0RVlLaUsvaDRDVHFy?=
 =?utf-8?B?Wjk5RHZuVFlxRmdzYUptWTNiRGhTNHdmclVjRFoyTktjOXN0N1JNa2REemxD?=
 =?utf-8?B?VmtlQzVWbUVnSzd4WVpIdEh5dlN5MmY0L0NyMUZRYXR1THJGZWo0QU1rRm0x?=
 =?utf-8?B?SHZQaWVjWGVTMHI4b0w5U3BQWlpVRDVobi83Si9QbmwrOE1VYzJFb2diZlA4?=
 =?utf-8?B?UDk2VnhBTThsd1JKQVQ1clpkUWlxYmZia0NiUWxCY0Q4UFlGVVJOQ2xLVDVC?=
 =?utf-8?B?c3pNOTZGUVdaZjAzQm1zWnNyVENUeTFPdFVHUndFTXl1OXYzVDNud2hlNk1t?=
 =?utf-8?B?ek1aR1BoWXlydmdwMXdKYUJsNzl5UzUwMGNyZjN0SDdwSVdWRzl3eHU1WmVt?=
 =?utf-8?B?MGRaeFFLcDhrbVdLTnBOVDBBcnNReEpPL2MvMjhiMHI5eHZJWVdQVVdOd0tp?=
 =?utf-8?B?T2NqQURrcm1nVnJOT2lQMUo4NCtGK3lTL1RmdExGUGNWd3RDb3BEWkV6R2lw?=
 =?utf-8?B?ckd0YXhwdXpId25sOUpRMmtoWEtuY1BWZ3dQZXc5ZXJuOEprWENaVE5GaGhp?=
 =?utf-8?B?d3hSM2k5SGQ1QXVGVFg4bWRnOTlVV2FYTXpMMVNVQkhQOXI5T1hRQlhvTE5J?=
 =?utf-8?B?cWFZUm13MVJBMFRiT1BwdkxiTGFpTEtXTnVVTU5aTEpHWXBEUVBQQzh4cXRv?=
 =?utf-8?B?ekRvRFMzdFlYKzY4UEpwbU01NGFSREJrRG5qcXREN2JuempQWm5vdGdqVGh2?=
 =?utf-8?Q?wC1ZJz16JuXzwuO6PE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2ZNejA4amlJcS9qUVVDR2NrT1d1cmN3RU1wZTJrVXBCNDJMTlBkZDYvNjZR?=
 =?utf-8?B?SHhRVjFkRlJOWkd5Q1pWdkc2ejAxdVBUeERCVXQ0TExzUVFmMEx2V0hDUkhs?=
 =?utf-8?B?RUhLODJ0cmwrcVlCVk9IS0l3VDdvMWJpQ2NIb3NwZmpaandMODhsWVZpcDQr?=
 =?utf-8?B?blgra2x2MXJkZlhENGFHUkdKTUZUUDQ2dE1mcVd6K29BcE9HN0ZaRFhYY01U?=
 =?utf-8?B?NW1mZldLWjZIdUR1U2RCVk9HdmJVNGlwK0hlc2FnVmk4aHd3NmRCaUcxZW9j?=
 =?utf-8?B?U0U5ZmxaNjBVY3FTUklQWmxzVCsyNWNLYnRpSFdWMmFITmpLSGpzd2plY0t5?=
 =?utf-8?B?cHV5dVFLQ0ZCbXlUcElmNzBTdDFqdkJSMWRzVDZEdm5USkZadzhRS0VSSnMy?=
 =?utf-8?B?ZkZyR1ZSSFo5OERneDFFWlhNemhzUWdCMk52b0JhVktOMzZRYWJNb3dzMWJY?=
 =?utf-8?B?bEJ0ZkpRUlZWdFplUEo2Q2lsSTZqQzBTZ0hQbXdEN3JkSDN1QjBZQVB0Zzk2?=
 =?utf-8?B?eFdnTVYxZzFSb3NNUkNkc3ZWZXVVdklackc2MmdDeG5PUzBlcU1vRXlpdG9W?=
 =?utf-8?B?b2UwaGVPSmdMZ3Y0RElpUVF4Vng5VFEwWk4wN2laNmFUazFEbjR0UFNBVTE5?=
 =?utf-8?B?RGJUNnNQUzlDR3V3SmE5ckZBQis1cnR1UWtBZGJyc2N4ZFZ4OHJqUlQvQmRE?=
 =?utf-8?B?Y2hnbkk5d3IveEVSNWdrcDFZOS9jSjBUOHZnVGN2cmhOV2FHYXRjN2FRYXRN?=
 =?utf-8?B?eVp2Nm44b056STl6YTFndFFZZkhJQkxpbUhKMnR5SFdrN1VGNW5kWkwxMVFC?=
 =?utf-8?B?TU9EK0Q4aWRBaUVEWldvdjM2QzBxVWRlZW5VRmo3YStCd1NrNWRQQ3hKaVNJ?=
 =?utf-8?B?eUc2RWNTS3FwYzQ2RXVUUE5IdytwTHpQQ0grOWNsQk9xZVNEb01PcGZTN2g1?=
 =?utf-8?B?U0JpVXgxVU9zUEFwZEtZeG5aOXdaN0FabHpPY1JvYUZuY2UzMy9qcVdEK1dK?=
 =?utf-8?B?Rk1NYmZOZVUzLytmdEJMOWtobTRvY2RIV2hzK1pwWHl1Y08vOElnU1l6WDFi?=
 =?utf-8?B?V0R2TXRwSndUU2dzTGZQQS9waFMreEJDTUxsblgrbzg5LzhPMWhRM0FHWHU5?=
 =?utf-8?B?cHBhV1RLZVVUVTErNUxKc0RTMmEraXJsMWVMekZobGVmbnM0cWVpMUcvU3Jh?=
 =?utf-8?B?ZGpxRWRJMElWUTJSNFZlY1NBTUQ5UUVUYmRhamlWVzNWb0ZtZGsxOHAwckla?=
 =?utf-8?B?RTVJcmFHRUJudlJWOWQ0bUh6cjUxNnZvS1k2bWpwMGxvNmxYNlhFdEdFSm5t?=
 =?utf-8?B?RXlLWnFOWWhJTXpXanpkQlZPU2VORlFRTzNzVjJCSG42cjRJZk4xc2J5VUly?=
 =?utf-8?B?VldhenlyS0ZZVjBGcmFMS2pXeVpZMWk5VHVrWXNmWkYrRmdsd2NQeDVucWVC?=
 =?utf-8?B?endtUmZ1UDFhWkVETjRlK3ErNjVvRmN1U2xDTUY1czduTm5UdDgwdUU3WVE3?=
 =?utf-8?B?eGdvWHdCdktINjdPYk1JR1F3MWRCQnplcDBwdklwM3VYN0NMbWpUUEFxc2tM?=
 =?utf-8?B?Mno2MlgwTmQ1VHpqdEV1ZXkvczVsZ2tLbHZTQVJXeStJZmRLNEJrM0wzMkpj?=
 =?utf-8?B?c2VCckRlZkpSeml3bytsaTM5eGEyeUpYdEw0RFgyTmJ4UmNyWWhjaGdST1RP?=
 =?utf-8?B?RWZJZEdoTDdvUjUzMkRFU2tPeC9VVnZYM0VZaWJsc1RGSE5CZjRXKzVQNUdP?=
 =?utf-8?B?SXd3Q0s3TE5NcXBsdXpmUWZmbVpyRnh6N1RSc0ZjZDkxNENWaVBqMlVZbEll?=
 =?utf-8?B?U0laejdRSUlKMXFkSWNzYStScUpJeXVTNzRGK1VoUmw1d2l4cDdlVEtOQUtZ?=
 =?utf-8?B?SGpEOHpTK0t0bHU0ZkxXTVVVd1lDaEppNmhkOVRRZEtsZ1h5SWlZTmJhT2lJ?=
 =?utf-8?B?VTJsZ3RmejgwZlhQcUlrcjBRYWdEMklqdUU0cWpNN2k4cSsyVGt3OFFSd3RP?=
 =?utf-8?B?V3F4M2ZoUm9tb1hOVnArbVhUMlB1aFFTcHRYMXM0SlY2OWJ5dGpkZXJLbWhP?=
 =?utf-8?B?Y1g1ZW53WEEwbzdNT3lOblA4cDFzd2Z0dFNVQlNpSlFMK0l0NFBmQ3k5NzdR?=
 =?utf-8?Q?QUncBZW8EUI00HwYq656LlnMx?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245586b7-e721-4255-121c-08dca541dc23
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 02:49:06.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZlY4QHUXaeyXyoYu0/q+2KDepyVoJWcwfoTohkAWtCp36vX4HMjAFmU6jK7cgAxRy0UWDvJWewa+EqcVGyyYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8333

Dear Paul

Thanks for your remind.

On 2024/7/12 20:34, Paul Menzel wrote:
>
> Dear Yang,
>
>
> Thank you for the patch. `git log --oneline` does not contain the/your
> name, so people would need to look it up. Maybe:
>
>     MAINTAINERS: Add Amlogic Bluetooth entry maintained by Yang Li
>
> or
>
>     MAINTAINERS: Add Amlogic Bluetooth entry (M: Yang Li)
Well, I got it.
>
> Am 05.07.24 um 13:20 schrieb Yang Li via B4 Relay:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Add Amlogic Bluetooth driver and driver document.
>
> Does this match the change of `MAINTAINERS`?

Well,  I initially interpreted the 'driver document' as the device tree 
(dt) binding file, but this might be a misalignment. Therefore, I will 
revise it to: 'Add an Amlogic Bluetooth entry in the MAINTAINERS file to 
clarify the maintainers.'

thanks~

>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   MAINTAINERS | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cd3277a98cfe..b81089290930 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1140,6 +1140,14 @@ S:     Supported
>>   F:  arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
>>   F:  drivers/net/ethernet/amd/xgbe/
>>
>> +AMLOGIC BLUETOOTH DRIVER
>> +M:   Yang Li <yang.li@amlogic.com>
>> +L:   linux-bluetooth@vger.kernel.org
>> +S:   Maintained
>> +W:   http://www.amlogic.com
>> +F: 
>> Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
>> +F:   drivers/bluetooth/hci_aml.c
>> +
>>   AMLOGIC DDR PMU DRIVER
>>   M:  Jiucheng Xu <jiucheng.xu@amlogic.com>
>>   L:  linux-amlogic@lists.infradead.org
>
> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul

