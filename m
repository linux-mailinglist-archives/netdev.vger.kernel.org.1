Return-Path: <netdev+bounces-200165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353E4AE3831
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCFA77A3638
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 08:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEC41F1306;
	Mon, 23 Jun 2025 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="AUtB4IIW"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010063.outbound.protection.outlook.com [52.101.84.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957E211F
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666662; cv=fail; b=k8UADxtA38z2UEh7dRP1yTGvaChNZ/FpzokmP7mXFtQNHOBSr74owXe+id246Lb6mLGG/wz70aA7pgZ0Hq6kpekIiL/zBENA5ceJu7IZ+6lB7UkiJoSbrhWbXxfLXuszWAUtpT3KgjLhQe2fP3On9h+cwuk5e1tytk7/Hs5BtVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666662; c=relaxed/simple;
	bh=MGfc2epQFtWaRa1i9fd9TRiMw/DOcT2Gs7ZWwgoW2GE=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=ljl5bozCHCW+M8CRiYJfhPswAoE22yjlnEWZ6pUu10u2ISjfb2JZAfYz84xpfrXmmzOAlT7Rmy5PbH8oL36/UC5iZEnerwLHxnf5ehJVMxe9m00zTqGl3WsV3pHgKvNeK5s6085g/1Zt1A8ZUvFLj9gNUOei/tIZ7gu2EJR0/2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=AUtB4IIW; arc=fail smtp.client-ip=52.101.84.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdIaqEiLG0IMwWbMS69AASRACWReCSbqtMMs3Hn05ene1G+Mz6xgJo5n4b42EbAESzbVztYm87eHauRxdRaYr6dJZyBk0pyi+BUDAN6xwMvJ//2T5HUJRH3yWRevsrkrapknK0JJWV7N0ssMpKEdkPbmRQDlLwaNTaEELRNXdirb7Mq2pfm2uEFJOOkQeOBAALUbkRLcLAyTFyG1wx6tNQEkpTeKr4SvfVhYHiC5cpPSVr0mazULoe4efcK6xHmYb1iE0UFwVn/WIYyhv8VK4oM9SvYFe6nlxC/iQzrlGesfQhcgGfQtAU/BMSYdOjcY1Sqd1uYddkKRFhoqYYvljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0I8CQHMkj/tQLdFHGps77P5RqtvF89i1EEHrv5hu93c=;
 b=IvoO+A6H9k9jePM7LH89Sv08YsPwQIQ7cD42OF6u3tkWyfpGy/+TwPtbl1x9sN2AePtMLfkJfBAXgLeWRDfYp6coIf6J3BTs8Tz04R41fizulWTziEVw+RmPeDRf9WWAaXFcaHp0bDEdvPHF7FaYdktiDu0Hox3ycnrZc9a7rxnzEka0F5b2uwAKCOYJgI4bCb/oyjqYCklfI1hm5X84y09WSjS9a5HqXEELlz+No4vyfD6Ud2Sm2G+S9gQWXzrc/+d3IGkcgWFOPjRpXjeNqHmUnUr9CxJyW+NwZCa1EvYaeJufeAVm/jvdTMYr6fCCIHG+5DXQJK+sH4z/hMG9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0I8CQHMkj/tQLdFHGps77P5RqtvF89i1EEHrv5hu93c=;
 b=AUtB4IIWyXPxEtaLiHk1lkqB1eh+upZva0UHeXb7fGd0pYWXfvo1zQLFVLE/gz4BCiugkoyNI+Z+UKeMz7OIAPDXHcKF74bDIGCiu/prJUqhm3RrhejTp9Dh+1H/22HXGEPjLk4DYJlD/Dfl7Wnd98rqqocJNpear7X/Z0f5igw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by PA1PR02MB11427.eurprd02.prod.outlook.com (2603:10a6:102:4f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 08:17:36 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 08:17:36 +0000
Message-ID: <c19e6665-941d-417d-abf2-3df02d47d92f@axis.com>
Date: Mon, 23 Jun 2025 10:17:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] net: phy: bcm5481x: Implement MII-Lite mode
To: Andrew Lunn <andrew@lunn.ch>
References: <20250620134430.1849344-1-kamilh@axis.com>
 <20250620134430.1849344-2-kamilh@axis.com>
 <f8662437-58ea-4ae5-8fbc-eb06e22f5a1c@lunn.ch>
Content-Language: en-US
From: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>
Cc: netdev <netdev@vger.kernel.org>
In-Reply-To: <f8662437-58ea-4ae5-8fbc-eb06e22f5a1c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::11) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|PA1PR02MB11427:EE_
X-MS-Office365-Filtering-Correlation-Id: 60800c0d-f3ef-48d2-121f-08ddb22e697c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWRuUmJKbGplVlF5WmdVdW83S2MxVkNkZWxRK0JrK1RKeHZFTkdYYVRZSGlR?=
 =?utf-8?B?WVdRdHRYdnVDTmRvb01IekxtYVptcUY3L1FMM0JLZzFOZi9XVnAzV3hOUkk2?=
 =?utf-8?B?ZVdkbmwxVXhIamtRbktvSlozQ0RGd01SNVNmQTdlV0xJQU9KM0ZWMmNGbUlr?=
 =?utf-8?B?OHpiWXRrR2QxSjM0d0NFN3l3eVdhKzYrVUpkYzJQblJsRVhKaDNJem5LaFUz?=
 =?utf-8?B?NlJHaXQ2Z2Y2dXJPWitzdmlxMFBCcWpYQ2xwdGJ4Y2tadElXazhkdzN5Nk9D?=
 =?utf-8?B?eGE2ZXpwR0d3TzVoQXF2dENXWkJFSGM3K3BCT3diblJxTVJBUkEwUDF6a3Bv?=
 =?utf-8?B?NmEvTmhwejQyLzlpdTI3Zi9Ib3hNL0krWGs4SFNtT25QT1VjVmZUZGppUk1X?=
 =?utf-8?B?OGI5U05sNVh6SjgrOHlyTVpERXh3cnpTN1U5aE5Nc3VRendJbzlmU0ZDY2Ur?=
 =?utf-8?B?NnRxcnJWbVJnd2tiUjBwdjNmUk9Kc1pRT2JLQ1E3S0x2NUlpVktPaXRPdk1p?=
 =?utf-8?B?cHBBckIwN3V1UkxITVVxR2xFaUd5U0tyYjR0dGRRekZORDV6WVZRYXdpaXBo?=
 =?utf-8?B?SFYxaGhwbHVJekZ6RlloSTk4R3dZVFVPVUZUM1JFQUJ3UUluam51MDhwYmp0?=
 =?utf-8?B?ekZaWUJZalVWdUMvWmthZVJBWnllMHNQUDhYRlZKU2cyNE1HbmV6K05WV0FI?=
 =?utf-8?B?MnFTNFNBMkFXWURrcFBqTE8rQzRjS1ZRNHpHTWJSVUVVWmE1ODkyWmJ4bWtB?=
 =?utf-8?B?dXpObWVlbmQ3cjc2L2xpYU5ZdzVIUTZpeW5lRnRNVGhPcUQrMVkrUFpNbUh5?=
 =?utf-8?B?ZEh0U2NoOVVURGVJWW9hMXFtalJhV2tZamlFc1FZNFRiMmx1d1JLOEFQN3pI?=
 =?utf-8?B?LzlMdG1nQTRPNmw1UE8yckpYZ0N0TDBjMzgxajQ3MVNoajlsSkcxcmtlMFNz?=
 =?utf-8?B?OWpmWmRrVVZBU05CaXdMblFrUUhnZDM5eWRndUo0Z1BCL1YwWlZ1SkNLUUFy?=
 =?utf-8?B?dDVtUjFlNmFxcWNsdnpkNjBnK1htOUNESmxQbU01b2Z0dmIydWszcmhPdlZH?=
 =?utf-8?B?bm5ySDJrVnlWNFRlZ2ljcmViYjRPSTY5cm1wNytKbTZSV0J0VkcrN05Rb0VC?=
 =?utf-8?B?SWdTQkFoNkpIWjV1NWk4SVBtSXBKdVZQOUVNOEdjcGpGMWJnaWIyUDFpSVhQ?=
 =?utf-8?B?QXl3bDZOdU5zUHdib0J1QVZiWjZURWxrR2Z4cTBzQXhPRitHaU9USXNNTndD?=
 =?utf-8?B?SEVQYXZUbGlIVUxpNldtTFg1YW5aSFRFeE52eDZVNVFQZGJpbXdINU5MdmE5?=
 =?utf-8?B?V1Q1eW9iOWMwbTlHeVFGL1BGdXNpdHlTRlVRd0gxYXNqSFY2WnNTakQ0ODRX?=
 =?utf-8?B?Z1ZockhvMFlyQWx3TDFmU3NvM2p5WVNSYkhsTmpRQy9EZzN2V0hFeWNYRTVx?=
 =?utf-8?B?bi84ZkVlR0FFWCtsYUIwMk9kVlp2UTdsTi93bzVTei80YUFybmRwQXZYN1o0?=
 =?utf-8?B?cVZ3eVAvZGdGckV6WWQwL3dneFBPQ01aNFRmbEdzZWxyamo3NlV3L2J2MGZR?=
 =?utf-8?B?SlBWenpCTjg5bkpZbGIzcU94Zy9sOG9FN1JWbkhxNUluajlmT1JKK0I0RlNp?=
 =?utf-8?B?dUJuQitteXlWK1RvMHRUb0lRL254aG51YmxrSCtBRWR3SHFCTGk5Y0ZSY2pH?=
 =?utf-8?B?T29PZUw4Q0ZPMG1paVdXNitzQUJzY2NFYUJ4eEgzcjdvdStRTnhkcENCZXNV?=
 =?utf-8?B?YTEzQ3lLa3pWeUpVRUVLZW0rTmZobS8ySURsSFVFcWc2V3F3ZStVSkpadGZ6?=
 =?utf-8?B?Ull1OWtRczFJS3FZWWpQUVpTSkpZbjZTUFNBNmJYQllqTHgyeUhvL2Z4OGRE?=
 =?utf-8?B?YkhHeVZ2d2llemZKT3VBK1MrSFhFbnlZZXFIZjVubDRiWEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ky9Vb1dHNExHSjNiMVJEdkk2WGJxTkRCTTdza005aFdmWWpFdkh0OWFZeWZl?=
 =?utf-8?B?b3dENWJZV3YwUmdxTHhuRlpxMjdMUUFPL3dPa2hpbS9wRU1aeWw3K05naVhm?=
 =?utf-8?B?N0FyamxmZGJkNllxUnJjMXFlb3NsVXZITzBOd0FCb003M3dQZ2szcE5VQzFC?=
 =?utf-8?B?WmRXcWYyR3ZrN1dhdzNtT01HdCs3ajkwRHVibzFSYTJWRTR6QTBINy9LZlNl?=
 =?utf-8?B?V3ZrZEZ0eW40NVRMUHZ4cHpuL0N2MDRMV1RLSURqN1p5RTROR1E4REpSamhM?=
 =?utf-8?B?SlhRaGVFeFlCMnNBNTdOaWdpZDVWeVlkZXZjN0VYTHN1T1RvbWZvQzZvSlc2?=
 =?utf-8?B?V0tERzR4cUIxUnAvMElMeStKOWVnbXlDY1ZhWlpOWU9rZ2pjeFlhQ3R0L2s2?=
 =?utf-8?B?enlwR2VKM1kzUUR3Wm05YTJQTnlHYlc1S1VhdlRvMmRDbzhxS3BTeDJsQUEx?=
 =?utf-8?B?Q3BVRWtab0ZqVFVxTU93LytDWWdKNnBvNjcvTFg0QUVPWDJ3ZDlMbFdIYm1D?=
 =?utf-8?B?N3hXUUNFRlkvSXNXTlFrRFpKSlNzNHgyZWpBTW1uUWRwVFJyUFV5S0IzdjBs?=
 =?utf-8?B?amo4cENCQ2RacG1xOFdpeEJBNWJvV2dYWWlIM0c1MmUzbHJxTTZvejBvYkpQ?=
 =?utf-8?B?alNGRmlqSnRmWUs1Q3c3WWxWSXJXdnNHUzduendTeEFVTFFSc0FMVFhML1ls?=
 =?utf-8?B?TU9TdXBIRHQrdGdoZUpEMTdSamZieDVKYmU1RGNRQTU1TVNSRDRxVElKTzl1?=
 =?utf-8?B?bllhLzJKRFBHWEhmU3BTc3pDZVdvQU1OWjd3OHVkZ2tWZXZGWGdpTjBmTXo1?=
 =?utf-8?B?TE8vSVM1OVBTcUlTUGxTY0ZNMERwK2dNWllKN0EzK3Iya2Nic09BdFVKMTgv?=
 =?utf-8?B?N20wTjdHa2lvdE5ETE5HRzkrclhVUkpjdVA3dHN2MkRBdDBvQkxST04zbndp?=
 =?utf-8?B?aEpleHEvWWlQTW9tbDE4RFh3bHF4ZEZrcEJPbUpReVYxZ0MwNm4vSVBzWFNP?=
 =?utf-8?B?aUJMWUtTTndEbWYzaHk1UlRnN0tmZmg1czhrd1VIaHRHOXBxd1FTbFZKV1Y2?=
 =?utf-8?B?YUUxeXlwKzVwTXlNYzhYdkQrbWluRW1EQUo1KzU1U1RmY1k4K2wwWk00NkVx?=
 =?utf-8?B?aHl6K0srajFXUHVJL3FHQk1LQVBmQXhSZDhFZnFRNW0zc1g5NGhXbEphNjM1?=
 =?utf-8?B?MWFTV0FQeVFqZWhqTnNISThkRWlabFd1aDFGbFFiS0lZdFNHeDdxYkx2Unkx?=
 =?utf-8?B?cmFIdHZWTEtDOUFVeHpWVUpCS2dQRllVaGNqZXkwSll4bnVybWtybHlMcEZw?=
 =?utf-8?B?QjB1b3E4UzZXejNBb3NPT2JqbUJXcTM0QjBsQVk4UWkyZGVibS9jelIxSWw5?=
 =?utf-8?B?anZTNi8xQ3o0WUhKN3FtSE16cHZQbUFLaGc2RnpQR2NaWjlkc0hXQTVlWmQv?=
 =?utf-8?B?Z0I4d3BGV1V4QVY4K2hqNEh1Um1jOEFEbU4xZjlzTjl4bkZsN3M5ODhoaWE0?=
 =?utf-8?B?cmxnUHJWYjhMTzFHTDdLWTNOejBxei9LUnJKZVkyVkpldFNPYkN5ZFdPMWZJ?=
 =?utf-8?B?dW16U1pJa0trM2U5MXhrU0hTYjcxRXFCM0VKTnBzWHFpZC9EMCs5MmN1Um1E?=
 =?utf-8?B?cXpINXVtdUUwbzJIb1dnQ0dRUTZpbndIcFphYW96WlRNNjVNVHBiNjY3RXVh?=
 =?utf-8?B?MG8yai9OeHBUYVBhWXdOVUNPUEZUN1dRRU9kSVBwLytNVy9EQWtZZjZubXV5?=
 =?utf-8?B?RG4yR0xDY2tTRVVncEFDeVhPNm9qQzIzZHRQT1FYQUhDYjdyVHkwVlJyNDN2?=
 =?utf-8?B?aDJvTTdhTnVrY1ZUdTJTdzZ6RnNaTWl6TXk0OEN5N3ZuT2VPUkx4N3JYTGlT?=
 =?utf-8?B?Vm9nTTJrMUJ5enNYbjI4VG1IbWplTUx0YWU3TVN1eDUySmJscnorV1A3UTBi?=
 =?utf-8?B?MEQ1bVdPUFRHcElibm9pRUJsRy8wOGxRRGZJWXVqdVIyRTAvbGtoUUhRSDh2?=
 =?utf-8?B?T0FaRzNHVzljQ2UzMlI0dEJKS3F4RU1OeGdQaUZDcTNOUEoxaWJwMVYwZDN0?=
 =?utf-8?B?SVBONVRCQ0xvcHlCT2d2ZTA1a25PeG15THRrYlYwbmJtN3Nlb1crd3IvNi9P?=
 =?utf-8?Q?b4Fp55kofDCfnMTq3O9wgzWe2?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60800c0d-f3ef-48d2-121f-08ddb22e697c
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 08:17:36.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaoOHEy7qOukaoodT8CicrRO9SbJDjAUDcp+p22U7goDS/p7xblyv2yaVZpuPkOO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11427

I wouldn't consider MII-Lite a separate mode (like eg. RMII), only a 
special case of MII with just those four signals not connected. As far I 
understand it, there is no need to configure the MAC for MII-Lite if the 
MAC input signals (RXER, CRS, COL) stay inactive. Because if missing COL 
(Collision), half duplex cannot be supported. The clock is limited to 25 
MHz, thus no gigabit. Besides 100Mbps, also 10Mbps, full duplex is 
supported with 2.5 MHz MII clock.
At least in the case of Broadcom PHYs, only the PHY must be explicitly 
told to switch to MII-Lite. No problem with the impossibility of half 
duplex, because all BroadR-Reach modes are full duplex only.
In turn, the RMII has less data lines (only two) and the MAC needs to be 
configured differently so it is clearly a another mode.

   Kamil

On 6/20/25 17:19, Andrew Lunn wrote:
> On Fri, Jun 20, 2025 at 03:44:28PM +0200, Kamil Horák (2N) wrote:
>> The Broadcom bcm54810 and bcm54811 PHYs are capable to operate in
>> simplified MII mode, without TXER, RXER, CRS and COL signals as defined
>> for the MII. While the PHY can be strapped for MII mode, the selection
>> between MII and MII-Lite must be done by software.
> 
> Please could you say more about what mii-lite is. Rather than adding a
> bool DT property, i'm asking myself should we add interface mode for
> it?
> 
> Is it a mode of its own? MII normally means Fast Ethernet, 100Mbps. Is
> that what MII-Lite supports? How does it differ from RMII? Should we
> be calling this PHY_INTERFACE_MODE_LMII?
> 
> 	Andrew


