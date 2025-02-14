Return-Path: <netdev+bounces-166510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B7AA363D3
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6095188E892
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1FA267700;
	Fri, 14 Feb 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G7hwf/R8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6813C67E;
	Fri, 14 Feb 2025 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552611; cv=fail; b=nku2VE64VKwst5wxoFZ3DAE7HYi5oAOdRdrr4f5byzpA67ZgK5xbHtRtFu11VdbHTd2yx/MfJSNjFthf9dnPK0D4KfTsjsD+T9ENq0MzAcKL9QI2p/LV5LcPDcoQ7vv//cFcE5MzBB4b1J41d4omDVABWfRzx8dfLlEiNyE5fWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552611; c=relaxed/simple;
	bh=ikqO0B5Tig4Pu4ZUB4UxW/jtBo/gwmuyodCUHZE9e1o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TqA2ZfT7Qo7FNLH9/OH2rPqG/DQmNXaY3fAmSuzlCYexiaEPAzhSkVrTeBWs34e5sYpJN8pRjsjMIIkZieHr+79LMeMhGgrL8DNQkyibpf9FfvT1ESIRYQcMcK3200lxZ+glwi3IlUHdKn7hOA4mkgR/a3ssnhd75My8aUaBPzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G7hwf/R8; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+1RRkTvEaPGxguwWsRDCuKBJQZ6Uaq0Q3is5Plqk1HZDpdPGO6iP1QyIWl47SGi5q+imQCTigViQY4qHsXjxxeosUaMjlfvhKXrBK2SqMehCWyRerabhm6+rKC5P5kOuk2jvePjFM9Snw6JzR1+FEg+odKjrin20yNoc4cDcM4BaPRJLkBnyR1+MsY9sHRA+SyJUXvd0usSLQ6JG4Q9xWWAzg0l5P9TnviLs4Xlm6x+oXCEOMLeaipE34Ag9rJMV8tES2jPsCWInVke+4Duao+3O/wEa0bAdR50LghESP0Q+YL+XDdXtDngwzOAizmad7hva/tLoQe1OnE7W4tUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFZ5q94qCb6gQ2z83DH6McxaDI95HqSUaNhYnMxrkeY=;
 b=XdH5WxVDxlrGI+/m7UO/sXfX7N26ciA+dFQp3UINuJSiSQ1crhu1PvM7w9QrTUklt3v6q5O0D0sLaHLieOa0zJ1gKaAPHwvhb6l1jUgwhpnDt6xE4wfjNOmMZqNm+FjF00b4Kj8leGn4IXtr0XFVb9cpSaIpLbStNkq8LxashRFAVorz/zmsTRnCZ8qWZ27w12sQKWh2HBZ5NoL2Pdgmg9gp9kaKxze5O7n/+ne2Bxf/vRtTStVK27VuvzMJtbFOl9Jwu0JHfi/nPDT61JOeZHVcdZAi/rCGjzkOc075VUku3gw58HZaCBJzebcbSCFtcB9HjHGgEiMFdXIxV8nOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFZ5q94qCb6gQ2z83DH6McxaDI95HqSUaNhYnMxrkeY=;
 b=G7hwf/R8E6SknNaJA/6aAOb/eyxup+QGLTfKJ4Ky35rHkCKHs416GcH7n6nGMnlx7+sReq8yIzvt2A3oo6mQ0cgYr2kcnGdbhup5mCtBH17b8CU0LDAkpCfL6JoFn/mCtQJAeHxkrbVVN6TOu4UBFj6qEtn/ZVDIS3Y50MpS8MIjFadpY1ES/Ku5xic6PfIckaCZZk5MCBUYaSmp8v/7ixZG/qNRP8SH0NPAUAEiWDgqb/Wl1Jicexeztg1lkmOG912OB0QnYCAekU030r+JiGSu2DoEfHTUBGrNlYVLWe33Fw0jBrbxw7c6kxN4Tw1vr30AKhCcPJv/JbV6SB4jhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 17:03:26 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 17:03:26 +0000
Message-ID: <53a47904-cb6c-4d76-86fd-2f78b911833c@nvidia.com>
Date: Fri, 14 Feb 2025 17:03:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 9/9] net: stmmac: convert to phylink managed EEE
 support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
 <E1tYAEG-0014QH-9O@rmk-PC.armlinux.org.uk>
 <6ab08068-7d70-4616-8e88-b6915cbf7b1d@nvidia.com>
 <Z63Zbaf_4Rt57sox@shell.armlinux.org.uk>
 <Z63e-aFlvKMfqNBj@shell.armlinux.org.uk>
 <05987b45-94b9-4744-a90d-9812cf3566d9@nvidia.com>
 <Z68nSJqVxcnCc1YB@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z68nSJqVxcnCc1YB@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::19) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH0PR12MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: 415c2a01-a6b9-4076-5a93-08dd4d197f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0kvTFFLbnpiaVZZek9NajUrR21HYm5CZVhLVkRRaHluTTlQSTlEeU5LNjNm?=
 =?utf-8?B?TWtjQUlaZmFPUDZ4YThOb3JUSFJLd2NMVG9MYnVjSEZkVEI2N2VJekJEQUIx?=
 =?utf-8?B?MkZET2lxNWhpTnNZSDE3amJOMmx6T3dGSnUvZkx2V3BJUTZGUDBMSzNyaEw3?=
 =?utf-8?B?eEM2ZXFZN1BlOEo2ZjNBdmNlR1ZBM0ZiNnZteFUyT0pQbXRscWhwTjczL1hD?=
 =?utf-8?B?eVp0ZlBuQ3FsMW1FZ24rNnlYS1FHTnNESy9UM2hDTHd0SXFnTkNJcWJIRS85?=
 =?utf-8?B?UlFzVDFxZHpSWjZVZGNJc2NQbzMxcHQ4TnUvUFpVNnJIZXlia202dGp0Ungv?=
 =?utf-8?B?Z1Q5bFZwckJVa2J0MWtmSGhIMVNScW93dlFQYm5ZRytsSFUyQiszdGVWNytS?=
 =?utf-8?B?VGVraUYwT1FsbWNzeG95YjNjQ2pqK2swWWZlVitjbjlxVWg3aGp3bmYxQUgz?=
 =?utf-8?B?UkhJbnp0eENkbDFLUVZaUlpCaGVuby9mSXR5cnNUcy9JNlQzSGd4ZmVVMUxH?=
 =?utf-8?B?c295UHlNQnk2aW1tWC9Xei9ERUhLRy8ra0ZqWDRORlIzd01mQXAveE5WaStW?=
 =?utf-8?B?SlhTYk95WHdOeU93ZG5yejg3aUQrWlBXUDg2RjdJdlRLalNzbGdoT29TWUxr?=
 =?utf-8?B?WWlmblBXNnBpNlRJZGxZNjkrNE1DR040RGZnc05LbTVtcEVYWnRVamUxQkhE?=
 =?utf-8?B?UWJhQjhDU2FZT1FXNXp6Y08ydE9Dem1CNUVWb2w5WG0vM3QzRGlrSWNLclE4?=
 =?utf-8?B?d0Zyd3hqQjlDb2FqR1l5ODF3U1RUckt2YTZGTjZxc2tNRnFqWVEyVGxJdHgw?=
 =?utf-8?B?R1BGd2lRbHdQeHJsSGJvT3Nzc014aDNyNVhheU82MTNlQVIzR3UyU0pIL0lp?=
 =?utf-8?B?NnBackdiM2dYcGR5R2JzUVhOSzRPUDROYzg0TlFEcE94YnV5b3I0QWg0TWxF?=
 =?utf-8?B?enA3SHZ1TGYvTWxOaHNpUFVYMnAzKzFKM0lXYWhsRlJXNVptanNGUjJDQlJ6?=
 =?utf-8?B?Nk4vME8wRFBINDlUR3o1eHkxcmVQUGVHMWZ6VnNmZytnNnFGQmFlalN1ZHJI?=
 =?utf-8?B?MTl4WE9oWDh3SDFEOWhINi9Da0U0cWFPaE1WaERseDkrQW4vVTRnMENOalNq?=
 =?utf-8?B?ZXJyeHEyNzFTTWtwcmdjV0h5RTJmbHh5L1RJZ0hEYzdEMmxUZEtEd1B1cFJo?=
 =?utf-8?B?S0tuanFMS2V5MVRXRS9aWFJ2cW1tOU04WllxQ29pTDBpN1hIYzBRbE05R3lh?=
 =?utf-8?B?TG8xRjlNUzdVbDRkbnB3bTVQZ1Raa0t4eHRnZmVadGpzbWI3WlA4MTMvY3Rs?=
 =?utf-8?B?SVFDV1dTNFlWb0Z2SnFmZGd1ZHBzWVZPVFVUaFVPdmdaWTJ6UDBJUzJwMnEx?=
 =?utf-8?B?RGp0R0Zvd0J1K2o1SnZka0hVQXhNNUVGZUhpeFNodGZtcC9PWjJpbDNnUkxJ?=
 =?utf-8?B?ekM1VDVEN0tleXNPalZudEp0bmxRalNXcWNxaGF6V2FXUnFVYXhEek9MM01V?=
 =?utf-8?B?dS93M3BjbzQwcUpvL05qbXVRUTFFVXg0Vm1vK2F4NUIwTzIvZGVzYUJDdXNl?=
 =?utf-8?B?d01URHErVUo2WXlZZnE3dmwyU2Z3SER6MFZvOTRXdkd0b1NFRUVFazR2Sm9Y?=
 =?utf-8?B?NlpkYkloV21nWmg4MG5Nd0hCanVtVFREdDZsS0NLc1BRN3JsRUp6QkJleXJ1?=
 =?utf-8?B?K3dOWnZ4RittdEd6b1FvMzlaZktpOHZ5MUN6cDBHNUtXaDNpTmFuMlYvRjky?=
 =?utf-8?B?N1pNSW8vRDhtUnhFL1BlK04vNFd5UThNNU4vVmxuSzJYa3dYbmdMYlI5U0M0?=
 =?utf-8?B?S1pqcW5UcjNmcGRvYlc5ZDB2T2lMai8zWnNsbjRmeDhtL21mT0FzcE9IRTVS?=
 =?utf-8?Q?B0WldhquZ/VMn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0hiQnRZb3JmRDNFb0RuRHM4cktWNWQxbm5FNnRha0RvdzBoWHIyMmEzK3li?=
 =?utf-8?B?cTJYUi9XOFU2N0U0cXNQM2JvM2podEtpN3RVRytTUkRwS3FwcDRET3BXUjM2?=
 =?utf-8?B?L045MGdOM0x6RGtRT0plOFBMcDNEUHQ5NnUyMndjZU82UU1wRzBBNVErK3Vq?=
 =?utf-8?B?RXV1SFlPWHRsbFFsSkVrcDE1Q3BlR0FvdnpGUkRINEpta1NUay9xRWpudEVZ?=
 =?utf-8?B?Yk52SFg5VkNXNG5ESjcxakVHVEpEOHpPdmJBOUJicjF3TjJCdklFeGJ0RkVJ?=
 =?utf-8?B?L2Q0Y21VN2IzYTl2dFFhZDkyU2tCVk42ZnplbklmbFJxYTJMOWE2WnY5QXBl?=
 =?utf-8?B?cTRNdzg4NGpyU1FpcDBWM1h3NmlWenZxMjdJbEFwRmhmT2g4TmxjMEYyV3Fo?=
 =?utf-8?B?K3F3aVhGN0FNZk1YRXROWXloOU1mZ2tVWG1XK0pObWJITTZoUG9acFlhdi9G?=
 =?utf-8?B?NTVQVzJLYUZhYWdvQ3doSmh3T1hjcDZlNWlYMG0wS05jbnRyWVFZdmgrcUgr?=
 =?utf-8?B?ZklEVnJtbFNIY2lESHA4ZW5BL2cxQTVidFhiSDJZSUVvcExjdWkyWlJjTTVO?=
 =?utf-8?B?WHl4RVgyejBZbEZjUlRHOWNnMDlxRHJKVjBHUm9PbEJPRHZXOUxuMk0yL2Jq?=
 =?utf-8?B?L0hYTHJMNWxIb1ZTWmJRdHFPREZFN3NOWkY5YUJsVnBUVVc4WENucXo4T1Vs?=
 =?utf-8?B?OEhXTlZBRE1BRXh0a2VaYStqdW1reVNQYXIvMU5KWGpRZVB1d2MvcHFJQjlX?=
 =?utf-8?B?cDR1M0ZzbGtrVHNsTzdlQW9GYnd5UjkyaUExMXNZa3gxd25FM2M5TjhZdWJs?=
 =?utf-8?B?NVc0N0VBL29RYkk3bEszRVZ1cDVFZ1l3Y2xacE1JbU1hU0tCRWFmOGJnUjBR?=
 =?utf-8?B?NXJtTFlUVlZmY3J2d01LOE1vTnlmVTZySzd5N1oxdldxcWVFeTFVUHl0UFVp?=
 =?utf-8?B?a0RGcGc0UHVHZzEwejA0MW5WdDNWanNGZU9RM1VoZmVmalk4RHE2NW9NYjAx?=
 =?utf-8?B?Q2ROTDhITkQvRjhGWHgrYnpJL1ZNdVJMQ1hnbkp0ZlZaa2JXM1NqaTRxTGJC?=
 =?utf-8?B?Ny9WZUtlNTVIb1pINkpkcEZUU2I1TjVTbnFHWjRsUXJCSDBHQS9INWNoN3RN?=
 =?utf-8?B?N09IR2hDYytaKzl1MHZVN3dJZW5heGY5L1pFMXB4ckVlOHl0ZERwL3J5R2Fo?=
 =?utf-8?B?SVY0cTk3anJSak4ra0RQV1FQZG1OaVN2aDBKSVpDMmpIekQ0cE1sU0xHQnR1?=
 =?utf-8?B?emUyZFpNNTM0UktWcDhGT2UvR0ZVTFlNanlZMHZ2WXRSTUFMRGM4a0hoSExT?=
 =?utf-8?B?Vk1kQ1Fna2pWZVN3QnM1MjF3SW02MTVGczNEQXU1QnplREtUT0ZxWmprRnF1?=
 =?utf-8?B?d0RYUVgwaldEZ0g0VFYwMHR3Wk5ja05XTDYzbGNkcHZ0TWM5VnJ6NnVGQi9y?=
 =?utf-8?B?OTl1b3Q5L2dRR0Z4aXFsWnB1UFJ1V01zRGVTdUZ1c2d6Q2N4WTFxOGR4dE5l?=
 =?utf-8?B?UG9yWFNqNlhiR2QveC9vcEwxQitlWTNtQzlQSTMxOGNaMUlxNW5lTFkrTE5X?=
 =?utf-8?B?dWw1YTVNaTdzQjlrYlpaaWdoSUducXJYTWRTMVJRZUc0SWZQM01sSVl2U3F5?=
 =?utf-8?B?Z21QVHNmT1NjNEtzcWQyWkk2WmxPU3h1Yldta1kybnE1cWdBK0JkY1pRYlFJ?=
 =?utf-8?B?LzVGZHpwMmlDYTJQWHZaV05IRTVCZ2c2eWFjd2hUcTlpZjdjUzZKOStMaVdz?=
 =?utf-8?B?M3U4Tll3UHZVQzh0OFJCTXNlMFAvT0VHbUxGRkdaMTBNZmJTR25tQjczV2lM?=
 =?utf-8?B?RHdUVjNGYzdZQzEwQVJBemxhdWhzR2FWUEVxQ2UwUU1RZlZQblBkWHRXekxo?=
 =?utf-8?B?emk4bHpmb3duR0hycHA2NlR5OWpoSWwwWmJwTS9yWklLK0VNV1NGdzNHNi94?=
 =?utf-8?B?OHZ0Y3RRSDZYNm5MZ0JTSk5VakZKeVpWRzMyK0w3ODExVXBGZkxPU2NTQ1dV?=
 =?utf-8?B?cGhXbHFwVnB5eU15eGc2NGNBNS9NNm9zVmVSMDBFcGdGT1kySnRCRVpieWZr?=
 =?utf-8?B?TUdxRTNqMUVvbVd2M3BIM3NUZndpUkg0OXpJcHJlR0hYYjZlbzE3SjFzN0tZ?=
 =?utf-8?B?aDlBRzZjVmxUeEFYMXJxODFtLzFpZk9lQlNoUk1mV21BZzV0eHVGcHZOeUFU?=
 =?utf-8?B?SEtCTkt4UkliL0I5Z1NuKzA3dDN3V2gxUU1VWDhuVERhL0tXcCs1OFRBNG1l?=
 =?utf-8?B?UDJpUFFNR2crdjV3RURnd2R4Rkh3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415c2a01-a6b9-4076-5a93-08dd4d197f71
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 17:03:26.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1VLwkNP+f5oRF6P/GxpzvOnR7KUglNleES4EsK/MvUHtmN2FAcFsYsJHXT6dwwhyeQSPPEGNY2PkdgcUHBiFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824


On 14/02/2025 11:21, Russell King (Oracle) wrote:
> On Fri, Feb 14, 2025 at 10:58:55AM +0000, Jon Hunter wrote:
>> Thanks for the feedback. So ...
>>
>> 1. I can confirm that suspend works if I disable EEE via ethtool
>> 2. Prior to this change I do see phy_eee_rx_clock_stop being called
>>     to enable the clock resuming from suspend, but after this change
>>     it is not.
>>
>> Prior to this change I see (note the prints around 389-392 are when
>> we resume from suspend) ...
>>
>> [    4.654454] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 0
> 
> This is a bug in phylink - it shouldn't have been calling
> phy_eee_rx_clock_stop() where a MAC doesn't support phylink managed EEE.
> 
>> [    4.723123] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
>> [    7.629652] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
> 
> Presumably, this is when the link comes up before suspend, so the PHY
> has been configured to allow the RX clock to be stopped prior to suspend
> 
>> [  389.086185] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
>> [  392.863744] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
> 
> Presumably, as this is after resume, this is again when the link comes
> up (that's the only time that stmmac calls phy_eee_rx_clock_stop().)
> 
>> After this change I see ...
>>
>> [    4.644614] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
>> [    4.679224] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
>> [  191.219828] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
> 
> To me, this looks no different - the PHY was configured for clock stop
> before suspending in both cases.
> 
> However, something else to verify with the old code - after boot and the
> link comes up (so you get the second phy_eee_rx_clock_stop() at 7s),
> try unplugging the link and re-plugging it. Then try suspending.

OK will do. I will have to try that when I am back in the office next week.

> The point of this test is to verify whether the PHY ignores changes to
> the RX clock stop configuration while the link is up.
> 
> 
> 
> The next stage is to instrument dwmac4_set_eee_mode(),
> dwmac4_reset_eee_mode() and dwmac4_set_eee_lpi_entry_timer() to print
> the final register values in each function vs dwmac4_set_lpi_mode() in
> the new code. Also, I think instrumenting stmmac_common_interrupt() to
> print a message when we get either CORE_IRQ_TX_PATH_IN_LPI_MODE or
> CORE_IRQ_TX_PATH_EXIT_LPI_MODE indicating a change in LPI state would
> be a good idea.
> 
> I'd like to see how this all ties up with suspend, resume, link up
> and down events, so please don't trim the log so much.

OK thanks. I will instrument these too and get some more logs.

Cheers!
Jon

-- 
nvpublic


