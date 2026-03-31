Return-Path: <netdev+bounces-273572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM20M1Ooy2kpKAYAu9opvQ
	(envelope-from <netdev+bounces-273572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:56:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 311F036866E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1770300B107
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284BA3A9623;
	Tue, 31 Mar 2026 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BnVQ9Kl3"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C88287259;
	Tue, 31 Mar 2026 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774954096; cv=fail; b=T5He0IEAp6QM8F9Q4IgCQ/KqKF7tpqZbuaqVjeiWuAm0E1YwRihE8US5KpVfiyFPQDTZpDukYXbKugocjvdFoxx+pBIInEYZ6T5NgbMmwEJTSBcbMYVlM/7IXXX9e+DvK/ZtOAfDel2REQ7q1GJI/6qKEJoKWmT7X0M/ioBEr8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774954096; c=relaxed/simple;
	bh=v1+QLvUw8Gmsz02DYbFCo3gd8IRwKlReEsxgkY8o2wI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=okifXhxVtdCcJz1kVIdvqlpihRI7PlShQ9ajSLzK39slhu2lNA8HvkaUb7eyiBIio+Uyo1jsEfM0hVUrecUui1Y2Sx6bSYcSpNrihO7oWa9tROwVqu4IcgRTTIkuPZlNHDSG0IfZ2WelP2P7qyP8UbkJhtTiEmrvoRZ4/CThwmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BnVQ9Kl3; arc=fail smtp.client-ip=52.101.61.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UShBbnmPO0A1asBruAzhxj6qlGsbi6PLzAGEvd8JBBwFKYOzatpmgO9wErf3lMmjIU1sYblgUE9am/0DDxNra5aKqCR0av3LDUvWRDeJVC6hCFwV9XuQaz4SZF/60mP7nFOyduvXJv+8qi+zU/RLNDtf59TYNw8E2R/Hu616w9BRMg9bW803QcToYdXjuUCpVEPp2WOMbrx4kSnAa/CYa9s14LFoGsPYbXoAQtqwvbHK+dtTgTUcOIRPv3Io0mKTwR8zuNPwAK2TLuGQZbkX2psrENmBFq6fnjs1BqI0UiaEDDXEeybDnDEMM5TBx+FJk8Nj/oihtJRanY91NhdGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+WKKnF9ZMyK8yya3iQNB1dP36UmKlQ5DzQqoCYHv2E=;
 b=UhsojjMAWKPaUuoGefVWdSU/k6nZ2hc2m46JRCqLsxcpzgWQjZWbi/SXQtiFxBUYuFrfh3BA0RbwH46XXlkSPM9nS0gqfR2ss8Sv5cDULD7va7jJr8oXYBF+5WV4fZulX8Gg2FPz1iN68KWMNOfe5MsRaItVgrMS19CFFTYw29iUJOdIeYqJ7nbF5tvqeGa6rZztHCmoISCi365J4QiFzEROkHmsOgYn1FQsSeNaFkQtPWGP2LzqTc4kyTilNdrCFxl4/UMShdglvIl0YL8duAsUsVtFv/p3kIUsqdC4EVYiRjewBDabGNaM9K+bVBbbtDmT0uBu23tn36nn/oMf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+WKKnF9ZMyK8yya3iQNB1dP36UmKlQ5DzQqoCYHv2E=;
 b=BnVQ9Kl3iA45VX/opEAAsH9fyNZASh848HtcT9PEwujt5o49pw1B95PKyrS/itx4Z0FIRwMjIA0up+wQmUfb27j8wKnxqwAiWsQ6oFrBDMXr0L17xhZKafgUEGoM1SfTUtfWtu6jORG1UJja/iWWrgWK/8q+Pl+CX3+Q9kz9SgHJ3NC+q36yLiFdItvSv0fBfqOCeElWOB8VtmMJNuveP9EZ95YguZUorO+pLpRyp6THRqUWiddDnVqJ28bdwId4AbaCxBU/QABrk5zu9nZxsxauohNIs39P4g0q/YeyjVH+RJKiHUC7xmvTQphFPCjC4eCaqKFQx5/xdAw6CKn5Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:48:10 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 10:48:10 +0000
Message-ID: <75e60c8f-ddb8-474c-961b-bc1d8faa48a3@nvidia.com>
Date: Tue, 31 Mar 2026 11:48:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] net: stmmac: Fix PTP ref clock for Tegra234
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20260325135811.148480-1-jonathanh@nvidia.com>
 <20260325135811.148480-2-jonathanh@nvidia.com>
 <20260326-gigantic-tentacled-hornet-cbdb8d@quoll>
 <01f56e6f-5459-4a96-9042-8a003a340fab@nvidia.com>
 <5b3eaba5-eba2-43f9-8ef5-d305ca50ddf0@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <5b3eaba5-eba2-43f9-8ef5-d305ca50ddf0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0212.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::9) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 519b3028-1961-465d-d973-08de8f12fffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	z/P4vrzBv53TX7xWswIEOdhUWBBffSOjjF50h7W4mSPDqevM/vkzV0k3BToP1XI7xZ16JOjei/628dt+pk37mfaZW/E3clmvEIWDWNQVTPE4xdeQNSIAKxekLUtIzX2BcqQyrcSMT1FBuJ9OGWOwOnQRslvsoAZtrmhnLwGytpROk/oGpsHKH1EDizNBifusrbRppaezIrl6PglD7/I117wz8F1Ujehr2dRdVqo9J9gUvbe9O5t6DuPlfdnAniRw7LOJl/MZylFr4TjFUKlGlaIYzUeXCd7HRPZ5ynrSBS7g4uhsTP3KoW4/2ykNuZPt40yVoVf78rNsBnkTtozVd9BpNeA//U1AKEDBnyQVFO6FuvXvtyLm8WGiRL2xdjLms+JcuSSK2gU5dOhCI5Yp3+dOmDzgGpaMSK7h4Ihr3T6v2r8FQa2ofrmeK7i3vYrfSx+MFO92pxtBnoBQxApHXkRoEJsrtYS49ySUglYbF2bvJ8Ffbva0PcdlTYo0PRxlDvyI4uyx5vOquBd7lssnwmFVmTiSsTpLbRVL5hO58m85m35LP1YuH6R7z1854JOnb6v15u+ilQEtFtmx79WmA85nOjypVR1+AtDZekyoaQNrL+MJncLQ7Sp1/umlZRnpEOMYO4sScRE1kd9FwX+ztMSnEc04aq3V1GAf7xjBtZnnfkVdFXVKZM7MqNQox8CD9ocHOINuCYrCkaWIMkXk+8lrTDMO9g8vG4fRcQX7Sgo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXhuWWd2RDUvU2hqWHBBTWd1YkxRVWVhOUR3alQvV3l6bkJzT3gramNlWkxN?=
 =?utf-8?B?MnEvT3IwOHJralBsZTNPNWdGSmJvUnBKbG1JNVZGaHFBTDlld0x1Z1VEVWxL?=
 =?utf-8?B?ZWhsSWg0RVcxbExJM1NlL201ZEpDeWhSMVBVVmlDK2JIbHAwb2xWOWEzZnNu?=
 =?utf-8?B?UWNPUkhBQXJLci94NVNOK0ZIQ1AweWNBY0lEY1BYUUxyY3JLd3lZalozRjBh?=
 =?utf-8?B?UGM4UWp1TzhRN1hQamcrbHRmMmRpNDNnNTU1SkVnR24yL1VpS1NpOStVV1dr?=
 =?utf-8?B?NkhSSHdEZE5jT3pVNkh3S08vZkJ2ZVpHRGFuOGNVb0xhaDdzbWJDcUl3Tzgz?=
 =?utf-8?B?YzArcXdDK2xHUzBlNmFTekVKZGROY3lhWmFFLzdPTUp3aTdrbmRSSkd6R0M4?=
 =?utf-8?B?S3Vsc2trOXJickpnQnJZSnV1NDBhYTQwb0gzc08zaEdEWm9uck1EU09rZ1NZ?=
 =?utf-8?B?QUg1Z0xpRGJ6bWVvejVoWXFMY2FMQ1NSM0NNL25vT1dUSW5LdXVqdU4xZSta?=
 =?utf-8?B?RnRNZ3hLekRkYkZScjluQ3BBQ3FPZWhGdlcza29MRUEvaS82ODdsamhTbXJr?=
 =?utf-8?B?RTBJT0FaYWVJTmw4a3pQa2pPWmFLdTZORnlYaHRhTERLVjNJVGtxcjNpckd5?=
 =?utf-8?B?UWZIWTBDWFVDNW54SmFNZWE2NzBRRkN3UTNMMDMybmJhcU53YTlERnBJanFZ?=
 =?utf-8?B?T0tZaEVUVmRPN3NDZExscU9RaVNweDZRY1F6NXMyMGdGd1YzNisydERWcUFU?=
 =?utf-8?B?RHJrODRpU1dXRXVZZDZsTUYvbnNmWkMybmk3VUtIUW9ML2RScmtWWUV1Yjhn?=
 =?utf-8?B?dzdKaXMyaHpvTFpwNElQOVpFL2h6TGUwcEVhMGNiblBkN2JuakF3d3pnL0wx?=
 =?utf-8?B?YXcxSDR6RHgyckdsK0lIZkZpZVRyVHNuSVRGNWNYQzM0Lzh2RkVjeXRwRzZx?=
 =?utf-8?B?MWFHOGZzZzd3ZUUxL1BlakduWjhIUkQvd3c0cHhwaWFnV2xaR2lLMXlOV3RU?=
 =?utf-8?B?Nlo4ZzVuSEc2UEQxSVN2a2ZZSU9jeFJqSGZrY3FKaVFJaWJaMzNobnUrL2ps?=
 =?utf-8?B?c3J2UVptQy82Q0pDTEQ1N3hqUWlOL1d3amoxVnVmVXEya0p6ZEhTMmU0VjU3?=
 =?utf-8?B?am56OEFER2Q5cVNVZ2VHcFVuSjY1dEkzU2JCbkFWYlErbUtwT3ZuRHhOVEdG?=
 =?utf-8?B?ejBlaHRsdzc3QkZ1OXN2Rmh5bWxLWnp5UXVBVVExTWFmRTFpOGtJM1llWmZC?=
 =?utf-8?B?MlM0aFZ3bHdKWVl4L3Y5MkhLU1pBVFJ0SzZ1cVNhbUF5TFRwUTRzUWNlNHhV?=
 =?utf-8?B?ZFI3d2J1V1hUZk8wYlY5TExpK2E5TWtMTmlhaFNQVTFuM1RNSy9FTjJocFQ4?=
 =?utf-8?B?d1FxcUFLS3I1ZUxSZGk2UC9tbyt2RGRyMW9hU2NLOEI4dlJSS3ZCQlJJQ1pO?=
 =?utf-8?B?K2RpU0hDQVNZQ1pBOUMyWnRWaDhoTkU1ejhzZXBGSEVqSUFPb1luTjNXQmxL?=
 =?utf-8?B?YU12UTlVWnJOaStmY3F6QVB4MC8yNTJjTTY2Y0lHWm9rZ1NmMlg2OXd4c01R?=
 =?utf-8?B?T0R1R05pV05MK2xHcDkxNUtvZzFDWFdLYWV1TVB4NDZFZnNYZFBwYnpZSDFi?=
 =?utf-8?B?ZEVpWkxFd1B5U2kzNU5VRWRmUnJaOVJmdkdKTDNRYVhFNDFpdDIxSmlLaS9B?=
 =?utf-8?B?V2ZjNXBLaDRQemc0cHRid25YZDc4NGt2R1Y1REVWMHphRkZ6WmhSdVI3cXlq?=
 =?utf-8?B?akdQaHg0bnh6NHU3RlhCM2JxeHVCSHZIbUdiaDhsZFVyakRsVjNaRjhGNGlu?=
 =?utf-8?B?czVodXZta1BmektiZkRET01uV1lrbUdvbXB5SmNwQnUrcU43aFZVT25vVDJV?=
 =?utf-8?B?R01XU2UxWWFwczdNYjhPbWNoN0tCZ1FqSGpFeEFxY2dJUUN5aW1MQWZJbzZO?=
 =?utf-8?B?U2ZEKzduMC91TlRzVTY4WjdhMFFPSVUxZ0hydXZwVi8yd0FVN05nWlpHQ0Zz?=
 =?utf-8?B?NlIzMTE1MWpCZ3lpbllwL2Q5QitQaHRRZSsrUVNva1lydjlYOWQrOGdyemRv?=
 =?utf-8?B?WHRrUEFQL1NkQ0NIeW00TVVHSWZZRWdlUGorOU9QSy94dWtjaUNIZ0FJZVBu?=
 =?utf-8?B?TGRLNlR5T0dkL2trWGtvSlFqa0kzNTkrdURUWUZGYzdyWkdaMURVNmZKd1RS?=
 =?utf-8?B?K1VwTFdHbGljVFRET3RTUGFoQVBteVNyTjRYUWJGQWh5ZVVEd21WTlNUVElI?=
 =?utf-8?B?eTR1blViSzNENjM1K0dPNE1HTUVRRCtUM2ZmeUduQmk3eEh1V1NodHZUSEZR?=
 =?utf-8?B?WE1vcGdodVJjdmFlNE4rK2taa2R0RGh1cEhWZ09va2twRndEUmVtUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519b3028-1961-465d-d973-08de8f12fffd
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:48:10.1154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHr+vk8JfZZ0GlWGYrn03UQEgwRNIKWRJWP7fKErJKGYpbye23UiqHMdoeW77HPIkD8l1/Rj3+jSuBAjv6l4kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273572-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 311F036866E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 31/03/2026 11:18, Krzysztof Kozlowski wrote:
> On 31/03/2026 12:14, Jon Hunter wrote:
>>
>> On 26/03/2026 08:32, Krzysztof Kozlowski wrote:
>>
>> ...
>>
>>>> @@ -257,9 +258,23 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
>>>>    	if (!mgbe->clks)
>>>>    		return -ENOMEM;
>>>>    
>>>> -	for (i = 0; i <  ARRAY_SIZE(mgbe_clks); i++)
>>>> +	/*
>>>> +	 * Older device-trees use 'ptp-ref' rather than 'ptp_ref'.
>>>> +	 * Fall back to the legacy name when 'ptp_ref' is absent.
>>>> +	 */
>>>> +	use_legacy_ptp = of_property_match_string(pdev->dev.of_node,
>>>> +						  "clock-names", "ptp_ref") < 0;
>>>> +
>>>> +	for (i = 0; i < ARRAY_SIZE(mgbe_clks); i++) {
>>>>    		mgbe->clks[i].id = mgbe_clks[i];
>>>>    
>>>> +		if (use_legacy_ptp && !strcmp(mgbe_clks[i], "ptp_ref")) {
>>>
>>> Why index 0 is not valid? And why -EINVAL would be considered as legacy
>>> clock present?
>>
>> Index 0 is valid. However, yes I guess that treating an -EINVAL from
>> of_property_match_string() is not correct. I will switch the logic to be ...
>>
>>    use_legacy_ptp = of_property_match_string(pdev->dev.of_node,
>>                                      "clock-names", "ptp-ref") >= 0;
> 
> No, apologies, I think my comment was not correct and your reply made me
> rethink. I missed final "< 0" in of_property_match_string().
> 
> So the code is good, you do not store index in 'use_legacy_ptp', but the
> error return value.
> 
> Can you however make it more obvious code, so something like:
> 
> if (of_property_match_string...))
> 	use_legacy_ptp = true;;

Yes I can do that. Before I was avoiding the need to pre-initialise the 
variable, but I am happy either way to get this fixed!

Jon

-- 
nvpublic


