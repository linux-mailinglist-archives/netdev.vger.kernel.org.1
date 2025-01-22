Return-Path: <netdev+bounces-160255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A5FA19098
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25F63A1E8E
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E287156F2B;
	Wed, 22 Jan 2025 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V/htagPc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D0211492
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545239; cv=fail; b=qXZK7jtFKAD4K6uoTcgh4y5T0+6ppE7YpsNdHZ19osSgx750M+gh/KP32z6RoutKegQsKIYxU8IRKwXWI/5PWPVa48wuWUhL/jEYiE/lpBmKRRimmBGJZYJmkEMVe4ClJB+IDpkW4yLXQiq2kNXWKU5hDhLOeM/eNqVn6tXJNVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545239; c=relaxed/simple;
	bh=wUDKbHFPCw0IfbHmKwOA+qpT9w1Sc1KOvBnDXPNC0x4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hhQaFv1f4UTAahRIMgN6ORtZTyy3ehTkJAwt+eO8rfW8MhwRpnN28i1AGmXcLjQ9nZbzaRwXs9Vfps4Eaav2roux/vAGDVtlJ7iCvJQa4yhg4j+GiBp7KfnvsIVbsIT/LWCSUb61N8DnjELZSufzCZEF2ZNje3Xl+ppq5nBPNp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V/htagPc; arc=fail smtp.client-ip=40.107.102.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzjdprlOUl1UEJbcs5ZU+tO4LWDmfBBoSAzy4FpbuzOhoHBJs2iKZurSnZ/HiH/JvDpECa+6Da6hpK2qfvXw8cg1U2g7KhBZVRxOt6wwWaLknBhBJyLmXAv/K9x8IIkFo7cFbKB6ET/ZJjCjN3t84AxhyMLoZ3OjDH5v4quKUCLX2t/HkuiNuR9TbJgWTK08zq5Zev2cW1Yl63I9+SdkDOUefZrPwv8IQ/OGDd+uM1k8uiw8Emf0oYZ9Bp2njpflXAaEd1mivf7WE5laFHBgPadVJnpFcRi3L6ZW9hZKsF/90WNLLUgBy692n4hxOnhicf+I4H8Ll1WBJXD7L5whuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUDKbHFPCw0IfbHmKwOA+qpT9w1Sc1KOvBnDXPNC0x4=;
 b=qD8VREjDHTj7KaCM3/eOaxCH2Vh+yNMa42MRYeToFUMuBUocZXcXVoa4ttlYf5XP//6JWDTBboF3jo79H9vRQrPyNKpamYVdTPWYcTO0eAyNFu9z7LGRG9/KkVN7yhCF2GI38c0Cy8J29TLGBAOQhvsDze9V1wD5EAzb8SXcZnwODHQGs7JJOYPklpyPNSdhiSQanRpEQyCI8DLLnyewJ2DwXF3qi3iclppzwwlFG8cxK2gENwtw4YX+d6wMZJYmyOo8JxhY+q7geBta6I01HPHCKQtDJUbvkl2xjoYrdMiNcKFE6lKIQt9h12lbxuacQKKD1dz3FLrVz/zXaN0QFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUDKbHFPCw0IfbHmKwOA+qpT9w1Sc1KOvBnDXPNC0x4=;
 b=V/htagPcTewdQa8/QhHPiU57gXVSiX4c7dJfCZKm0OFLvZLvAqpTlIkHhm8VmEzOXn6sGjUzxKpwy9dGKChr//S54tJipPVX4KDbteQnRm/LkSm/Nf9jfcBWi598KYhdCtdGkUPt9F8nlXdmVlLrR+FAvCSzDx1UQRnBhmrSJWdxY0Ei+H+QcRMYcRtYpqulL2ro4Yk//wUuD94AQKMksSgUvi9dEgPbJYVFaoqk5dvgz6ae8VWbetD5lCrXH2qXYeFgQFHkGf/7ZkGtQOLkyDbtCaMJDbaBbhVG6/3Nrny1GVbBOCBh2EX9iekqL9aBbzm35pcit841mpN2YzESOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SJ1PR12MB6193.namprd12.prod.outlook.com (2603:10b6:a03:459::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Wed, 22 Jan
 2025 11:27:12 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 11:27:12 +0000
Message-ID: <b1e4436a-c19e-4060-bd85-4328e586e68e@nvidia.com>
Date: Wed, 22 Jan 2025 13:27:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 0/5] PHC support in ENA driver
To: David Arinzon <darinzon@amazon.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
 "Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
 <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>,
 "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
 <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
 "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
 "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
 <osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik, Ofir" <ofirt@amazon.com>,
 "Machnikowski, Maciek" <maciek@machnikowski.net>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20250122102040.752-1-darinzon@amazon.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250122102040.752-1-darinzon@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::13) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SJ1PR12MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 696bb2a5-e87e-4215-8ed7-08dd3ad7b747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVBId0dJSVZEMVRnZWxvZ0RWaWxXM3Brek5DUkpYSnBTU1R0OHZrYVRXS0tW?=
 =?utf-8?B?ekVUbTR1SjFPZndGeTE1YnBvNUdYK2NmOWxwN0VDQm41TlIwRGl2Sms3ZkpT?=
 =?utf-8?B?NW0zTUlWUFNjR1F0Ymx3UmZxN0RRV0Y4ck1JbXdqYWY5b2pueTNMNWU3NFI3?=
 =?utf-8?B?SUhEa3R6cTQwWkxIdGFBRlVhTjJmc1A4ZW9GUlhzZ3V6a016MGg3NjVCVWY1?=
 =?utf-8?B?TlkxSlFsQ0VlOHpSVm10eHdHM3hJbjAwdFRwd3A5LzcrT1NWdlZOL3dKdkFE?=
 =?utf-8?B?TGhOWGg4SGpJQnlQbDdWeFYxQXNVRFZZYW9IZGpCNE4xV2FFN2UvZW1KUjJG?=
 =?utf-8?B?S0t4dUdMZlJDc0dOamNjdXVpQ0g0bXRHdkY1djNuTVFaTWErMGl5V0J4aUwv?=
 =?utf-8?B?K2VqdUc1Q2RlR2VOeHZIOEZFckZwYmNKVVAxc3h3Wlp4WmJhOHlvWnBQTEJ0?=
 =?utf-8?B?alVTQnVtSVNvelk4cnJZQ1R4Rk00Q0xXaDZSc2RKajRSWTJjRW5qUHZ1Mm5U?=
 =?utf-8?B?SEcxaTRYRi8xMXQzc1lLemFUZzhHaTVTK0xoOURub1Nzelcxek5WZnBOc1pB?=
 =?utf-8?B?dDE2eFcrTkl1Y3dVdGlJeHNpNEFHSzc1a3UwajRvZlROMmRTNE9pekR6ekpW?=
 =?utf-8?B?UVE4V2lpRWI3U3pjZGRKRFZua0l3MGhWakVxTTJ5cFlHb2NVOGx0SkFZblE0?=
 =?utf-8?B?VlJEbExIVkpOSldaelBtelYvajlkU3lwOE9ETWw0RW5RT055VHBCL2JyL1ZB?=
 =?utf-8?B?Y3QxYWVKZVQvbXZENFE2eEIyb2pCRU5BSGt5c1d4MURRc1RXakN5VHhTaG53?=
 =?utf-8?B?azhNK3JpUHprbWdZdmk5aE9qYlJrZFJXUFZFbC9VNlJMbmVVNmpNMlBQTnpz?=
 =?utf-8?B?QTVMV2k0U0hKQ1dhUkFuYVZQY1doTEVPM3JuSmF5Z2xpZjlxVWk1MjZrZWt0?=
 =?utf-8?B?c1Jkb2JhVGljMXZ3OUVnTW8xS29SeHZJYlRLcUlnSlRVb1dUaHF0dE8zRCtj?=
 =?utf-8?B?VDhJSWpDNE5kMkxFYWRWSkhvZURiR0NsbjRTd3VGNkRVenJ4dmN5aVQ4UGNF?=
 =?utf-8?B?UFpDTDJJb21hQk8rcFg0SlZkMk5uWDFBTXVwMFFGTDFabXU2Rk4yT0huWUJz?=
 =?utf-8?B?L1pWOTdqUVlOaERKN0pJWXV3WFJSZnVDeW1oTi9MVTJxYjdmUzlyK1QzdHpH?=
 =?utf-8?B?RktYSmN3VGRkcXV3L2hHTnVoRHU3NkhvU2RZbmE3dGNUQThHN21vaEJuVTYz?=
 =?utf-8?B?MzlxUytuUTRQRnd5STZnenRVU2ZpTWtpSmVwa0RLZWExakxvWFhpYUVWWnRm?=
 =?utf-8?B?bzRJaUc4SUZueEszemRDNGlQR1loUUtZVXlCSVpnbjZoekQ2a1pGV0tNS3RN?=
 =?utf-8?B?WXhneFZ6Kzh5OXVlaEUyVWlvVVZTdENTYVZPTm5RcmxqQWx3UVNEVSszc0s3?=
 =?utf-8?B?eE9nWURlU2lZM1g2SW4zazZSNDd4bVpISk9xRnByR3F4OElyR093K013Rk9m?=
 =?utf-8?B?enJjQUp2eHprR0VNMDYyYTVZTjJjSml2dk0wVFlQY0xHQUJzVklWOW9mczhR?=
 =?utf-8?B?Qzhza3FVaUFSZ3BJWjlBVitKRWZ6NTEzSEVKMlB2QjBCT244clVYQWE3ZXpH?=
 =?utf-8?B?aDQxczAxVXBaanFvUDlGbHZmZzB5MDgwVmFwK21UbUd3RnRBNFpzVFBVcmdw?=
 =?utf-8?B?UWFyOC9BMmI1ekgzaUc5NU40YjcyR0x4dU9Gd2FXV0Jvb05UcmVReEU2SVdV?=
 =?utf-8?B?VEFTQ2JnbENxYjBEbFRoZTFDeHlxbnpZUWgxOWlGd0VjaUZpYVJ4WUx4bU43?=
 =?utf-8?B?SzhMSFFQMm1EY0pNanR6VnFaQnBPWHVzU245NlRiMGhpWHhBZER4cVRRSDJB?=
 =?utf-8?Q?KcPUPIAUZIQTs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3JTSzFpUytrQ3VqWW85OXczK3gzVHFSaU1RcjZQQ1UyU0ZRTmF2VWtwYmdR?=
 =?utf-8?B?aFNZL2lYdjJqY21TejRpbTRzR3JrT1dRTE9SQTZ5NkZzTmJPMWk4R0R6OEVT?=
 =?utf-8?B?RXJyYWd2NnRNc0xJNDMwUHc2czAzRXVKVmEwT1JJMzhsQ3JTTDRYTFgxN2Vn?=
 =?utf-8?B?OXdOblNValVkR3o0SGJCOU5xR0s4Q1pncDJMZVlUVjVVQkhiZUNjc1ZKbzlZ?=
 =?utf-8?B?NTdxQS9MYzkrMEdzUFAvMlNzQ2l2VEI1bWFGTm5rcG9SZ0RmakUxa1Q5SnBw?=
 =?utf-8?B?MnY3N3VwVW1waUNXQlRpMjI2cStJZ0VhSmROWWlFRng1YmY5eGdoOW0yaXJI?=
 =?utf-8?B?S01INmRueU1RVXlrNVFwWDcvdEJNVm5ZMzgrcGNlS01UbGlFRnNtczlueFFU?=
 =?utf-8?B?WGxWUDI2anAvYllqZjJpK2FLRHNTUHdrV3ZBazhJR3dQSkFmWllhYlRkSTF0?=
 =?utf-8?B?N2RYeWREWlRCOWRJOXYzL3FwcEo3ay9JTktGTjNjWDZSMjRYU2F3WGQwMUxN?=
 =?utf-8?B?OVl4TTdSd0ZWaG4ydXVaTzVONnBGV3RiVFU0T2o2dGJqV2M4eUFma0FSajcy?=
 =?utf-8?B?TUFpT2VscEdwdlF5a3JZUm9ZRCt5K2NLNkppQ0ZOQVgzZ08vc3ZGZzlMQWZo?=
 =?utf-8?B?THFkNWtSUGlweWFoK3NYMTZrMHZBL0VhQkNJOGU5Q0h0amZFWWZBbld3ZEl4?=
 =?utf-8?B?YjNtdW80VkRYaGUxdzgyR3lNazl3N1Y1K2gwQm5vZmNGcVl4d2dVdzJiZzRL?=
 =?utf-8?B?Q1IrQjIyeWdGbWFBY1NDYkJNTjI0NWRTY3hsK2tQOGd2TzFieWdIL1JtZDVE?=
 =?utf-8?B?ekN5NURoZ0hCL0dDTnNBajd6Z3ZMS0ZmMzZ5bXA0YXJvNGRXTXVtdkpYTTBk?=
 =?utf-8?B?ZFQ5eUdNbmY4d3lNMFlxTHNNd2pIVGRlYTd5cVlKdjk0TEpjQnk4NTc3SGlj?=
 =?utf-8?B?T05KaTNpcE5mWVYzcTM4YUNaNGp1TUd0MUtoKzQ2dHBJUFhERytjcDBvSThp?=
 =?utf-8?B?VWFOZ1g2Rm1LQnhicU5XWlhJSExkWTE4QkRkM216R012Z3BxZW0rbkN0TUs4?=
 =?utf-8?B?TE1nVHI1U0ZhdnlTSkZmL3hGV21xTS9vaWVUMEZBQ3haM2lmUUp3bTlwT01p?=
 =?utf-8?B?emg2VDhoMWRETFRCSFYxb0NZbzFiTFZ2ZGtwT1dCS0svaXpUUFRaQ3h5NjBk?=
 =?utf-8?B?NmVYb08zVkJHYUdBZ0RyNHppdTJ5dXZLN0tidVdUSHhHRm1VS0NXekQ1dTdi?=
 =?utf-8?B?QXJYNVBwQUpydGJ0RGUyMXFxd1hVWjdYdy9ua1gvdTFyc0tWcGVyM01BUGU2?=
 =?utf-8?B?dGZwNFFoTDhlN2I5MHJDQ2hXZS9GNWJxd1pQOXhpbTlKN05oOHpwN0w5SkZp?=
 =?utf-8?B?Njl0ekFUb3JMOUh2WGVnN3BOVWlLZ2JBSU5MWkIzVG10QlVXZTNPRW03S2tm?=
 =?utf-8?B?LzFUc3FyRXdJdjlUc25Nb1Q2NlJ5ZmNWN0NlcjVNczh5QlVGdUowWGNsMFBs?=
 =?utf-8?B?MlJOMk5MYkprc3lzTzJXdzBZdEdRYlRuaHdvajUya3FLUWdKTDhkK09aWkdR?=
 =?utf-8?B?b3dqbXg2bDNYWEFvZkU5UzNHL3BlQzBPZWlTNmRaZGNFRjFzdFVuT1REbVlI?=
 =?utf-8?B?NkdNY1hwcTh5aFlTK0ZSQ1I0SUxEU1Bzc1NzREdLT0x4YTIxSlpqV1BWbGhM?=
 =?utf-8?B?NGFhZFdySGVxSmpVcUpDNmZadnQ3NmZycWd4ZmdIZ0QvVGJLN3Y5OHR0ZlFi?=
 =?utf-8?B?ZWs2VXNsdWM2U2dIN0FjMHFEaFMrOXNHNS9qTFFXWXRici9XT2pQTG9Paksy?=
 =?utf-8?B?YTR2c1VvUGphK1FScnBFcWxmdlpBeVpLZVIxK3BzUnZaSVYwbW0yRVpDZXJF?=
 =?utf-8?B?bWZ6VDVyQ1RQSEFaYTBudFhRaDdURkY0NU8vSFRESTFOS3hWQTkrOUxRbVpP?=
 =?utf-8?B?WS9IK3AzZ3ZpVDRqUW9tTGtEaGN2Ym5CRXdNYTEvQWQzYWpvejdGVTExeWxy?=
 =?utf-8?B?LzJSZzZma2JOQlJQaldJZmdJa0dteGpRSmp1ODBZcFhTNG5EOE0reGkvNHY0?=
 =?utf-8?B?V3MwUytwaG5ncFFmQjIvdEdLRUt4c2ZSRWtaVXV0bmdLM01wbkdYQkdWSCtD?=
 =?utf-8?Q?z7LzYmhITWnLeJ/+BJlRi9Dle?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696bb2a5-e87e-4215-8ed7-08dd3ad7b747
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 11:27:12.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HznOCH4grYFw0d2DCdfIzf07Th968tVy17FE9ugRwnYjHDdAUg65QyzC7VLLzT8G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193

On 22/01/2025 12:20, David Arinzon wrote:
> Changes in v5:
> - Add PHC error bound
> - Add PHC enablement and error bound retrieval through sysfs

sysfs is an interesting addition, is it a result of feedback from
previous iterations?

