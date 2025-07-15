Return-Path: <netdev+bounces-207025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7945B05506
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 10:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF92175741
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 08:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A082741D4;
	Tue, 15 Jul 2025 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="loOdPAUL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15654274B43
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568520; cv=fail; b=mOEhajxHLChhXdwEiuZlOpyviZCqJu4H2C63bDZUwT4Q7mz8L+u8LbxcfYkBJLCOqIuX7D/Tw679TgZ94YOehFHAS5XVbYf1vJ21YgqS7vSHE4xgpHWqyDuSJoUaMbfCCncpRSjPN9s6LIbmnWK+nCHqWssPUpL9HTnLO+Kc2vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568520; c=relaxed/simple;
	bh=1c3G7q/NySE5QwjMFrZE0dAs0EKQw9UDdP/FQAnzEas=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JU/bZjfmt3ThZ6XVUrXM+fLUEj7HngW0xCJ3cgTKufgX56ZpS3FylQUZbnlibzI9AwhFL/YYRsSQFXP97wcc+Aw9sONj7PMSe9W+GEUWJ6Hz+YWuUZznOptnygKVmZhJfomvDEx1vd3ACPzYB548H2VhmPvU/avYa/sILdwaJQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=loOdPAUL; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJAGfGeTwUnz008zL9Gzk8REl7xq9JIhwirVZ8FTv4Z3Y3W2UeXgAWY10+skbp9d30Q1VCA5V4B9N14G8Cv0ZB91BpLNXJq+4YP4wEiPrV0+/+FXCTYj70t6XdYBT33heQ/eDUko35UlnyLBsGua7kTgRt2fRoqzYqmynYtBsUAarRwR2vDob+jt5vElvaeyKSZ8M0OtdvUMVdjHdRr3qOPer76HOHj3rhVAlQkMUUkaWKwwwpP1NoSIP0yuu5CSAGyT6RRq42P5TJYNbEioj8K4TT/2vsi+C3pBiaHx0nkAF+sLHiCF/vhuyWqqN3138YUgnSKS5XWzTqXcgQ6TxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUm5xwwqMYnDc778s0lnfhUTEk6B/pzAEsBMI5qJmjA=;
 b=Ll493KijQRcoCZOul5n2D6CV0yLH9vDfJo0VF9D6W8C58Ta34ef/Lu1D9VhcigHmGQ4OUIjL7dG43GH4j6kXPhfwU8U9uuNiOsv1u7rrqGxV4dGTFxUCFgzodisJ4/NZZeGXvkseba/3D8tlYapVJlp+1Sz0ZlCQ7Ojd+8UjF+HsWu/ySrA2AeVYQfBi5/B1M8Efif0LozyzxJi7zPcvLIa3Ea31o6+svkRfAJczMd7sPWCOosOZahuPMa2WbZfKKdepfAsnRyZJlV1mPsuywKpUm9/qxFp0WmfU5qCE0z4T3G8+mazEBNSJRO8ao/mb0wSSXUXEKHXygS2TQ8TxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUm5xwwqMYnDc778s0lnfhUTEk6B/pzAEsBMI5qJmjA=;
 b=loOdPAULv24ZynaiFkGooQZohUogGdJzhVKY+PfyO/aSEOhjE3SBg2zckStP4y5i59hvfQwfA9CqB3/ukAdU/b+pgCIyHV21XSCl1aFP5f0Ph11mBrwGN4DyTvDMy2KmEObVEhZCOtDIoUJVDX7NAZSbMD8EEh7vU85s4n/zLJF8bxKnBryXV2dudNOw6tB4WdmWxp0/50PtBQkPzzl7Cj4RCW7WrfXIZb8T8anVfggGqDus+ZMcO/jySx5rAYqCWPBokJvjZ06ZO7VzXVu2FMYywdC7n/IK7g/5qDTbOtQPvgdB7DbJqEHsX74ipm9Pm6jUMDsmjuKSHpPZBIJ6xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 15 Jul
 2025 08:35:14 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 08:35:14 +0000
Message-ID: <7fe0c573-4a4d-4cff-a1c2-9d4638eea3e1@nvidia.com>
Date: Tue, 15 Jul 2025 11:35:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 08/11] netlink: specs: define input-xfrm enum
 in the spec
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250714222729.743282-1-kuba@kernel.org>
 <20250714222729.743282-9-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250714222729.743282-9-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d9b1d0-8d59-40b9-9301-08ddc37a84d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXp5M21MZ2JURkV3SnBuTE9HTExEcW93VkxzVkpxT2RZQ3NTR0F4L0dVZ1ZK?=
 =?utf-8?B?SDZPSW9rNXZ3WXduVGo0dVYwcFBDZnZiVWlMazB2SEpsUGJVaUQvZlBOS0tX?=
 =?utf-8?B?dmZnQkZodFJZN3gwSUliWnJ6K0FZMzJIeUx0VmVXLzE4RG9MQ2VjdzBwZHZN?=
 =?utf-8?B?Q2pxdTM0RDUvUy9tSWJZRWVZV3BaUWFiTEVhSmkrR1U5ZzdSelZJTmJnd0gr?=
 =?utf-8?B?NnUycDlkTlBLd25jZzlKN1l1bG5uMUF3anI5NklOZ2VNZU1VcmdiTXpBRUNk?=
 =?utf-8?B?OFE3WTZsdzBJZ1pLZGV2NXRvRndjeVRUdEtrbG1wS29KdmdrREtZRjI2U2lQ?=
 =?utf-8?B?d0N2Z3cvaWNsZ2xxTk1PeWZ1bElQNmowb1NwNVY4VlRUeHBtdUNsVDl2SjFF?=
 =?utf-8?B?Ym9YQ2EyMitVTGJ1c2o4SUhYcDR2c0JBcitJY0Y1S2JLV3pxa1lLNWc5VVhx?=
 =?utf-8?B?eWdZdTVlMmFHTUdZNmIyVDVNVjdjSnJBdEZtN09yY3lPL2Q1MnA2R2NzbmVl?=
 =?utf-8?B?TGx0aGJTUktYRW1Ibno1YnhOOGdwUlllaFMrWTM0TzNGbVRvU00vWFFEVDl6?=
 =?utf-8?B?eXMxR25QTzlieGpDenIyb2hjTnlDNDNQS2Y1T21ORWNhZWxTbWNDWHlXbzZ5?=
 =?utf-8?B?S1dMaHMxSk5tYTQ5Y0UwQWM0cXB6WmdPRjlyeXFyK2N2L09uOW84ZlBGVys4?=
 =?utf-8?B?SFJuakVoM2hqOEVLNmpoQVBld2xjQ0pnM1FOY2VpL1RBK2pRMFpWTzRLN2s2?=
 =?utf-8?B?THRlcFdLNStvYTVkcDI5ZnR4TnpKMlg4WGh3bVpUUnM1SFF2WlptU2tDZkJQ?=
 =?utf-8?B?Um1VWFkyUGpGMUJRdWJmTnV6cFdDSEdXMVhSUnFvdnlpYnQ5am1aQnliY0dR?=
 =?utf-8?B?R3B6ZWczR2ZtY3NYRzVqVzFUOVBMU01mT0JvK2JrSWc0NjlmL1dqQjJQNHNu?=
 =?utf-8?B?MHQ1cjhmUmtBdkluQTR1cWU2TEdWYm1jZkE2UU1SQ1o3ajc3WTZRR3FiSlM1?=
 =?utf-8?B?dXphaC95NldnOVIxeDhRU295SXU5YzFWN0daNkN2OVdZY0ZOS0h3a3hZVkJh?=
 =?utf-8?B?WEdDZ2xGZUpUSVVJdWROSzQzcHN1eXVWTWdESHFWeHhQWC9JaWhvTEhMV1JD?=
 =?utf-8?B?V0huV2E2Uk5vR3RkSll2T0MzekdLOEFIT2s0aGNXbUxjWHA1OTR0b01QcG1p?=
 =?utf-8?B?bXgvTUVHTGtoR2dNNjBNOU82dnY4dkMvWXdraXFONmJ2WGxva2lwOCszbndo?=
 =?utf-8?B?VUJKcnNVeTFFKzE0TVJRWjVxU3lXb1R1anorekZ4KzA2VmZRN2gwbVptdlBQ?=
 =?utf-8?B?bXF6Y2lkK1p1d2QxRzVXWE5oc0dVYlFEZFJpR29zY2IwUFdmcG82RVBQQ2JM?=
 =?utf-8?B?OGgydFFIOE85OGcvK0tqS2FpdHZ1andXdTVTdllMR3lzajRZSkoyK085Zmhx?=
 =?utf-8?B?dWtCOU9uYjdPem9hWjMyeHNRVEVKODVnRmo4ai9wYzNFbW52N3QyVGNPUEUr?=
 =?utf-8?B?a1dxRWJKL21WYTlxWkpEQlFMZUVwQmVrQ01lbnlBUXJxbHgvcGNmbmdZN3c3?=
 =?utf-8?B?UU5aWFNoUkU5SXRxOENWSEF5dGlYK3ZsQnRhTjRSOUVVbDhKYnVjVDZBVzlu?=
 =?utf-8?B?K0tQZEhFSlVTQlVkWC9sZWlvTUwyUk5HblB4VUdueWUxNHd3OFlwL0RFMXRJ?=
 =?utf-8?B?UzFmeFpsS3RCZTI4Y0FPWXdlWWwzSzN3SFVZaGFyd2lnUHhoVHczcXZNZTJv?=
 =?utf-8?B?OUNsN1NtVDRZcm5hVktUUm1OcDBkdVF5TFZpUEtvVGJLYWoyWkRLa1NxbVc1?=
 =?utf-8?B?VDdjMnpMZ3NJejhUejV1UUJHb0wyclovT29qeklmYU03YW1MaW9tOGJ2WVlx?=
 =?utf-8?B?ZFZ5MldJSFdaRlRRWTR5WkMyZi96S2o3UjFvTTdINWs0dDl1T0Ztbm8zOHdu?=
 =?utf-8?Q?uwdg2SPUDUs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3Z3MmJaa0lKZEllTzBzMWtON0I4SlFDY3BkU1RVOFQ3QXlQbEg3QWhaRjAr?=
 =?utf-8?B?OXUxeVl3SVJ1Z1ZrK215RExGRnZmZ0ZnalpJeU05TUxkUGdMdnRvOTNKMlc1?=
 =?utf-8?B?N3lZbXhRWEdvaGZHTUZVWWRRd3NPcy9ISWk5djFKKytmSGdaUldmWWROUksw?=
 =?utf-8?B?dHdsSzd0Z051dXoxRmE3dEFRbnBocW5FSW1sQW9KcFhiNU9OK2ZHSGxJdHYz?=
 =?utf-8?B?V1pHTjR1Z0JZWTdRVGRYU0pGV00wekVKWUZNZkQxUWRkUWJ2QzZWUmZIQity?=
 =?utf-8?B?UVdON0lFOGZtYnUxTzRoM1BYOXNhUTJld2VIMzVMMGVieXkwMk85RjRvMHJi?=
 =?utf-8?B?SmFCM3RHVXVKempZNlI0SmFnL3k4bFhuSnl0dDRGK3V5dmpCSzhjcGV0R0Fk?=
 =?utf-8?B?eDh0MnB1Um9WZDlkcGpGL2NoVXdnaVdmQlhRU3N4blhrSzBnN3BQUXQ5QW1M?=
 =?utf-8?B?QnZhOVhSbkdhdEN0VXlSY2VLcEppL01UOFBOS3p2dVpFK3FQOFgzVmtBbFRJ?=
 =?utf-8?B?U0xLRWMyTlkrN0t5eHJxbjZOS016L25uL3BRWlhscElZOGNoOG9QNzJ4MFlX?=
 =?utf-8?B?QmJ1bGpVamNPS2FhVk5PS0dSTXRpWEZ6eWpXeCsxZ1Jvd2NCSnF1enNZM29M?=
 =?utf-8?B?UmZLbDdDdzRaZWc1VE9WMHBqNlMvcnZlTHIvSEdzeWp6WEExcWVPVkVJOVBC?=
 =?utf-8?B?aFRBRGppQThsZTdVYmRuakRYRnZjMmJ5dmdRM0J4amVOU2ZUdVN4UkVSNHhZ?=
 =?utf-8?B?K2RhK2p4ZUhMaitPU2QxbWMrNGsrOHVwNWpwa2tzY0dFNHYybUlXamxpbFEv?=
 =?utf-8?B?MC9hUkdmZHNvaHFtU0VhNnhpMHZkNVU2K3ByM0lVOC9WeXplL1RSWThSZmsz?=
 =?utf-8?B?anU5NVRuSGp3c2pHNmU1WVhYaXFBNC9abmlOV2Y1LzRQei9qYXVTVWZtb3Y0?=
 =?utf-8?B?a3NSa29FajFUL2Y3RlhwRFJhTmR1YXZ0c05zUDJ2ZjVHVWZORE5rbXlEN29V?=
 =?utf-8?B?bVJla3Rmb3VRYlc0eGdpcEFTT0pSNXJ1azRMMHVVNVZoT21GZS9Gc0RFTWJM?=
 =?utf-8?B?T1o0c1RXRFV0eTJmbWRXWFpJbUZkdVdUSnAyVTZiN0w2QnJ0UXd2NnJrRE41?=
 =?utf-8?B?b1hoSklCaFlkWDVVSko2THpDYjRRMFBEMTZXNExQL3g5aTM5VTM5Q1JDZ2Qy?=
 =?utf-8?B?cUJJK1FNWXh2bTdxbW9lVjUwakxkZ2Y4UmR3Z3VvQklsRU9KL2Nvek03MUxQ?=
 =?utf-8?B?N0xmaUNFZXFtU2xTTjg4VlZjNkpKMm05aTk1Q2VDai90VkVHWjNYdmRnSDFp?=
 =?utf-8?B?UlVmK1NidGxYaUp2QUEzOFNFT0V1d04xVE1aZ3ZLS2N2MEdpVHVaZ2NLYkpB?=
 =?utf-8?B?RlZQdWlBTEhqOUdLb3drcjg3cCtsVmNnV3IrYmp0RHhqbjE5VUNtNGllNDBr?=
 =?utf-8?B?MlptUXIvaURjeDd1T2N0YVorclJ5Y0ozYnkxb0VKYWhCOXh5MlZBM25XaGF6?=
 =?utf-8?B?ZS92M1BqN1ZkNGdoanBzdTNmbENwUVo1STk0KzYwaEJYNWRZRU0zSUlvdXY5?=
 =?utf-8?B?V0d4VUxoeDdyRmllUHdxTURIL3ZPWjlIWWtIQ04rRFdLSUgyR0lpaFJjSElI?=
 =?utf-8?B?TTJyeE1Za00rRnZZVm0wR04wZGNvMERPejNBNm9nNG5kZy9wejB4bUlYNHFE?=
 =?utf-8?B?OXZzYUNBOVA5cEJGcE0vWjFqTWd5L2hSVDBib2R2WkRxWkdFY1BRR1Zvc1Vt?=
 =?utf-8?B?TE5kRUI4Sm1WY21PclZQeDJON1dUdWp4aGJZWWFkckZiWGthRmhDaGh5bFdS?=
 =?utf-8?B?MFh6RUVqd1VkaWxlSFU3QUlpTk1UcG53NVdlV2paWElweldjMndaRm1wV1Y3?=
 =?utf-8?B?bFNwcllSOEtIdnNtRlA2ZUNDeTNLbm8wTWk1cWR2eXpDZC9PSzB4eGJqN0lp?=
 =?utf-8?B?TUIwSjNjNTh3cGtzM2NqcmtTYUkvVGRoQmxMcFp2b3ppbXpkYXFUUVNDSTJI?=
 =?utf-8?B?L2tzWW9FQ2NBUjFrZ1U3YkRWK1l6M2tWclJNb0k1Qjh0MVhKaE5LSGhKa1lw?=
 =?utf-8?B?TVd4WUpvUElEWUdRcS9PTWNrU1psS3pZeHNoTGg4OXNYM1AweFVzZG1BWHRh?=
 =?utf-8?Q?I4BZZaC4oIfkK6+W6v2yZSGYA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d9b1d0-8d59-40b9-9301-08ddc37a84d8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:35:14.1478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJBqmWuN/y0iCCkOQJ/09xb4Fq0o9L1JvkNjLWVO68gUZTVh3WIhBQFcaYJrFFNl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484

On 15/07/2025 1:27, Jakub Kicinski wrote:
> Help YNL decode the values for input-xfrm by defining
> the possible values in the spec. Don't define "no change"
> as it's an IOCTL artifact with no use in Netlink.
> 
> With this change on mlx5 input-xfrm gets decoded:
> 
>  # ynl --family ethtool --dump rss-get
>  [{'header': {'dev-index': 2, 'dev-name': 'eth0'},
>    'hfunc': 1,
>    'hkey': b'V\xa8\xf9\x9 ...',
>    'indir': [0, 1, ... ],
>    'input-xfrm': 'sym-or-xor',                         <<<
>    'flow-hash': {'ah4': {'ip-dst', 'ip-src'},
>                  'ah6': {'ip-dst', 'ip-src'},
>                  'esp4': {'ip-dst', 'ip-src'},
>                  'esp6': {'ip-dst', 'ip-src'},
>                  'ip4': {'ip-dst', 'ip-src'},
>                  'ip6': {'ip-dst', 'ip-src'},
>                  'tcp4': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'},
>                  'tcp6': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'},
>                  'udp4': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'},
>                  'udp6': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'}}
>  }]
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

We kinda use input_xfrm as an enum, but in theory it's a bitmask, so
while this is OK today, I'm not sure this patch is future-proof.

