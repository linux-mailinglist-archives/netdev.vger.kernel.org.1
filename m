Return-Path: <netdev+bounces-244834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7749CBF960
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 20:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CB1730221B0
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49742339B30;
	Mon, 15 Dec 2025 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XDh1l391"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C377339B20;
	Mon, 15 Dec 2025 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765826927; cv=fail; b=iTrWOO5diG8pvquCIW4/J1zFPHGUp7nTeFLVHR6fQUtqvqRxwV4IFHlo69i9AGXpdS84H23xOmpm8MZQlewOJ4x51U1h5hA4NIUjYUuqxLj+Hj/XjZZxwZNFkWue9fty0XNaRV/iYHCcetImvD9WjENnXi/fYcnsC4ZdLpiBKrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765826927; c=relaxed/simple;
	bh=iQeaXXALyAd4xBYccVXawOiMMMp/JWkTLsNC6U+JQjU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fU+uEsuGrn5TOFNp0oZG3EGJwrwl1WS0qZHWBQyumhE6J2rvrnzasaBOL/Wjiqu1xTM1Ojc4y0rIAue7vCUvpTrnZayzEsli9NVEw0P9kDuv8Qi41bDFgr4vGwqu8dBcOwubBIoRvFG2aS974/jQ5hgn1xYIvZcM5Tgg2Av6Cxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XDh1l391; arc=fail smtp.client-ip=52.101.193.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz1MIRfQof2JxTHdBTPDNaBqEXu/6lklMqwSAovI59BDrgkOg41cImZaOwnjpR5zOvTc3FISSHVR5S4R3y4+xtUTek3DUWWeJy/UVw5pNX4tA0BOQDuF5m9A8XN6xy5JgMgv3C/l+MA1c8WHzP6Ha6KJ/i/u9p7lS6sPGZarh4tD1KUTlS0tkIYLSedO/XRTxkyAaeRvBDOutKmUdd3SE7PzcWHtRThaWlgLWyE1DMnvcFO+PlQ0y47tiRbe5GFncCeaGkKPAb5Zim+7CgqfCt2wN4jqP/YEeaTM83wEpEuwltalF6pdFR1cDhnrJc4NT13qx9gEQYL3rSbroGkJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orhk93tCLjEajsFgG7CualKNDc2gPSudbq9CiMr1Dv4=;
 b=tkq62CVcaFNuz33ZCqKu07tse+UmNct37qSuvrz3KVJxYNzr7IMIsWVFG+D7T68GdOgXBjCxALQHXTH54zaUuUEaeJVXawP1pClMgORmRnJL5MgtlG/JilDhG/ikoARceljxPxIbLziYFi9KLWoPnQWc/mv9IxtMPgeg3J0ovIZJ2lcAddnZ+wY97OLRSz1Yw7JBHQh06K3PtlUIhpXIjUoKb685WJUlFBtkXutvfBjUUxmsFt4UIjN0x2RCQCZa0LtCFjR2fRkLVYTKH5rLVdg3bllILtJIxPeD/yc7ggy6+OZnBoLHVz/Q8s8UqwGc0C3DmDIMpiZkKIP8p/ULzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orhk93tCLjEajsFgG7CualKNDc2gPSudbq9CiMr1Dv4=;
 b=XDh1l391DPVoF27KxJJbLnzXe33Qd9URi5Ocfs1zBKzrQLXSXS14Z1oSkOV9dviGN23pcTKtT9FDrPy7X2ioxEr1YJWsUyxSem9WxqPF9U9PEh8CXxrm7SvgaESqitLP5n0x3R29vRaCgiDoPtkwsNBo2k/Kteyeu0CgRB/Pq3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 19:28:40 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 19:28:40 +0000
Message-ID: <d101cf0e-bf7c-4aa7-a444-f6b61a1854ad@amd.com>
Date: Mon, 15 Dec 2025 11:28:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v3 1/3] net: ethernet: mtk_eth_soc: Add register
 definitions for RSS and LRO
To: Frank Wunderlich <linux@fw-web.de>, Felix Fietkau <nbd@nbd.name>,
 Sean Wang <sean.wang@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Mason Chang <mason-cw.chang@mediatek.com>
References: <20251214110310.7009-1-linux@fw-web.de>
 <20251214110310.7009-2-linux@fw-web.de>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20251214110310.7009-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:510:23d::10) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2a0630-7662-4474-57fb-08de3c1026d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MitydENVVTcxdE1BUlhGWVZrSkxrWWg0SkNnbDR3eFl4bFFjbHIwbWE0OEVh?=
 =?utf-8?B?NUxFOWVrcjBqVXUwNXNMQ0dCeFhTczArdmh0Mmt6U0pLWDVLRi9yZys5ZnJp?=
 =?utf-8?B?Vi9xRTNwR0NkamthVXBmMGtGQnFaR0xUWDJsL2ZlTlN2clh6SnExN1kybGc2?=
 =?utf-8?B?NU1IUzRpVENMTis5NjJkSlVRTWZ4Z0FOb0NlMXpDWDVsSzlVOGwvZ0tOcDRM?=
 =?utf-8?B?YjBXUEoxNW15SnJwVWd5cVpUSXhxUWdKRlZrOXdrdEVYbjNTbDMrVlFvVFRt?=
 =?utf-8?B?MEpUTllqYklyclVTazlpNkdJSjM5aU9zdGYwTHZwbGI1dTJYTVhRTFJBbnRu?=
 =?utf-8?B?dlZpNnFnRG9WOGxCS0o0am1DdWN5Vm8yOTQyYVd0VkRuaVpUeG5MYkhRZzUy?=
 =?utf-8?B?QWNqbEFpQk84VCtDZENXVFY5V3hlUXFpNDZWZDFiRmdyR1k0eFJTMllraEZu?=
 =?utf-8?B?Nzl4c0toU3llVkNOc21YSG5NYk9Bc0ZXQ1JrWEh3QXdCQXY5WjQyZkNEazU5?=
 =?utf-8?B?TUMrSU9rMVZhRFErbmsxa1JZK05ZTXlRRjRwWkdpb3JkOXhudGJaVU9uUCtw?=
 =?utf-8?B?TUU3MzUreVNzUDJLbHF0UXJIeHBKUSs2NUNHeUVYTnFvSUxsdEZQbTliWXZD?=
 =?utf-8?B?bG5DdW1McUZOR1hvcm42dnYvR3gzTnBIbGlxdFdiaXFUOFFPRFByeFJlcDhv?=
 =?utf-8?B?aDVLUFJTOXlxanFreFlLTzhBTnhwWmV1eUVwYXg2V0g0YXh6bmJMbWttNWQ1?=
 =?utf-8?B?TzM5dzI4Y0FnSHJZQWlGZCtOMFNpU1VnZ0RFMkRVcVZ0Yjl1V0xTUlVJcW1h?=
 =?utf-8?B?NmJTS09FVU95bkwyMjRMb2hFcDlHNCtheThVWTZ3b005TTVmWTYvdVRZNTNs?=
 =?utf-8?B?RjRhMDd3cjF5SmhmbmpGVGNManNXeU9LZ0JWcE41UlVTenNzTXBsZlhwOTA4?=
 =?utf-8?B?Ym9Ta2xwVmtYOUVQNzRRYW9GenVwMnVkM2xpaWZ4UDh2R3E2cTlnUU00SkRC?=
 =?utf-8?B?eWp3d2NiOFFsbXRzdDJVcGpiT2ZRUE1idE9XSEZRMGZINUwvbFhaZmRTWGZU?=
 =?utf-8?B?aHZFMTBhNlBVbVltL0w4TE15L0ZMMXVjeDYrR1N0SlhzVmpETnNMeU1TZ0hk?=
 =?utf-8?B?ZGVDamhncXZ0MFdJbEZwZjlvaUJMQmt3WXpnN1JwbEJvcEpZZ3lHM2R6U25U?=
 =?utf-8?B?SDRLamRBaWUwK2hxc3BCd3hjTmlUNEZCejg0Nk1pVlNkRG4vRUV0UnNBTVJ3?=
 =?utf-8?B?OEZRTGZmOVR5YVNKWmtXR3ZrNmxId05VZTlYM3pmNy8xcEViNFMxcE1kSFNG?=
 =?utf-8?B?U0p5ZU9wOWlVSmwvZVZoYndTeVBMWlNtckpGWERCRXl6dTBnSjloTW9oM2FP?=
 =?utf-8?B?dHM0dG9mbXV3N1h2Vi9XOFdTM2NNWERPUkFLb0xYZXpYbnBpYXJtdloxZ1J3?=
 =?utf-8?B?emdaSlVqUjZONkI1aHdjN0hndVRtbmoydHNKUzVKci9Nc2R0UWd2RkpzZHpI?=
 =?utf-8?B?V3QxMDV0UlF6clQwMUlNTTNRUERaVTNUSTV5ZnVkQnd0eDBPa1lJWis5QkRX?=
 =?utf-8?B?ekRmTjdWU3FRdUlxNEk4V1IyQm81ZXFWcDRmMWFtUEdyMjJaYTJ3aDJGa0Z6?=
 =?utf-8?B?QitGdXNsWmxDUm5uVmhZc05JeU9BK201Q1Z3cGZMTnBKWlRWYXBEcEZkY1Fo?=
 =?utf-8?B?dTdSVkxuNkRWdmtCZUI1MjF2Tnd5VEpPeXpLK0ZKVkFucEtMaDZLVTVpYXM2?=
 =?utf-8?B?ZGFFaFJ3RUhOaVdwMEF6a1dpTkFsZVVsSlR2RnhNS1dHaGdQaUJXM2Y3alBT?=
 =?utf-8?B?NTBESER4OEdIVjlXYTc5VGl6Z2hueGVtY0tWcS80bTAyMldsOXNFOXZ4WktK?=
 =?utf-8?B?a3dXUmlNOVlFRGpFVEprVTg5bG5wSGVRcjlnZVVKelRiQ0Vjb0JMaFN1cDlz?=
 =?utf-8?B?YzRVY05qYXpDNGdDQWpwclRGOFpCbnJicEVBRWNZTU1YRXRTOW1URlYrZ1M2?=
 =?utf-8?Q?X2uVmQPOQcYatE7T2xmu0BNGhuh/9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVRzVDRnV2JwelRuZzA4OTVpVE5rWkR4bWlIcm14M2hKdDlrQTl2UHdFNDNY?=
 =?utf-8?B?Z1U4SHlLRnZCM2ZVbWpPa2JTR3hrTkZpLzliTGczbVVFUktzOUhLckZ2TnNL?=
 =?utf-8?B?Y3pmWUJCOEkxdlJZRExOTUFJWTJwWC9pTUJFMUlZcHBqSGgzMWhSSUtXcmxV?=
 =?utf-8?B?bmswMjRwSy9iRmlsQytHMzE4SWJOckRxdCtDQzQxVW9kVDBOMmdXVXB1Ny9P?=
 =?utf-8?B?RnpaL3EzcVlzbVovOStoNUZqNTdZQTM5aTdIYlhReDU3UDZJaTBFZ3FFajNU?=
 =?utf-8?B?S0JuNkx5eDRlVHUwZzlwRXhGRFRndk52RUVCWm1HY0R2Z1ZoVWE0OGNnblFL?=
 =?utf-8?B?eUhsb0Q3ZTY2V2ZGbnRESEZQelIybkJJenFXVTdZSThCNUdON3BsZFd3cWRO?=
 =?utf-8?B?Uy9rSlplajlZNUxod2dpbldUdVRJRUQ3cGl0MFhYUlNLa0szaUpGNXpVMFpW?=
 =?utf-8?B?MGhyQlc3UTZOc05LY0F4UUlLYnRiLzdPV0d3TUtsanRyWHFwSWdNeDVsVXB0?=
 =?utf-8?B?bkE2QTJMSVB0anpTeFNmdjlzb2xaeUFqYUJUbGhxSFlVaktTeVpEMUdpSDVp?=
 =?utf-8?B?bVpWNUluamZNM3FuY2lvdmZoaGN6aFZHN0JhRVVRUmlnVE56dWEwOEVTNUlX?=
 =?utf-8?B?UU1scWxXVGovVW13T2Y4N1hla1pCKzVMaXlNN2Irai9YNTVYaURhQXZrVFJB?=
 =?utf-8?B?dGRBK29rR0pvNU0rVXNzSzJ2MGJ3MElweW1MK0dGVzNxNHNHczBiYWYvTHNF?=
 =?utf-8?B?Q1ZiVGtJL1pUU3NvYkdhRWUxN3RGeW5ROW04aVdoRERjMzdrN1lYTERyT1Ew?=
 =?utf-8?B?S3ZKZTdQbk1tSVJWSk40eUY1SUdDM0kzZUpEMWUzUmlZT3k3ZHg4NHBEUzQx?=
 =?utf-8?B?VVhLdHpaN3ZSd3pPb21JMGVwWjE2OFk4RTJyZmxpQ25BNVJLOVkvbnh0aTZI?=
 =?utf-8?B?MDF2RDRuczJqYlI3aGlrZUFXY3dxY1JBMCt1RXpQa21kRTBhbFdPUTZkTlVq?=
 =?utf-8?B?ZC84eGp5eUNDRktjS0JoY1U5bHNkejBtNlNZMjUvRERSRTdvRXZ6WStKY2Q0?=
 =?utf-8?B?cHQzamxyMzJ4ZnAxQUJCemtDT056V0s0dzNwdDNYSkNPNWxDYWFob3VyMzNO?=
 =?utf-8?B?VXBiN0xTVzhzeGd3cGsxbmJzWWxocDUrcGVnOHpWNXJFSm9sOGdwVEJzanBj?=
 =?utf-8?B?MGtQK0NxMWVvSXNTc1ZBL0d4WG5qaXM5MDlNTGVSQlhTUEoxTFJ0OVNwYjU1?=
 =?utf-8?B?MktZdzhBV0xqTU85OXJnQ3RaVXVibnVoVEVOdjJLeUt3TnI5aVR5dTBpa1Ay?=
 =?utf-8?B?TmRoczV5MXh5RDVzVWVTbHl3Y1dlM1JCVzBhMHVjcUNVUExHeUJ6dXdYN01K?=
 =?utf-8?B?Tk0yc0RVZFJFck91RVgwSDRLYlFOOUZ3WHVQeHZKQnFSekEwM29LVDhqVXQx?=
 =?utf-8?B?blBONVBvVHpzNTdZV0s5UVVzeTg0a1ZEZU80cGRFNEFMVDZtaHdURldXQ0Uw?=
 =?utf-8?B?UTk3SUhpMnBQMXZFR0Z5Qm44NDFHM2VOM2ZVTDR1MmFFLzZlMnpVSEcyUHBU?=
 =?utf-8?B?ek04QVg3WTlJemZneUJoWUlzSG5na1NWNkM3UUdHeW1TOE53YkNRVUh0MS9u?=
 =?utf-8?B?QTRUK1JoWEp1TEExcTJNRFZsWjV6Tm8rSW5TMldyUC9CWmtkVUNvR3FvdzRL?=
 =?utf-8?B?ZHZMSkRxYjRNNWRvS3ZHL0lVV1pRL214ZU93MG1WY3BNNkVBOXpYUDhkbHVm?=
 =?utf-8?B?N2V0Z1VlR1VqSytBT1hGRkZIK1dNV1NOZkNKUkdKOERqSWZXVC9tMVQ1eTZJ?=
 =?utf-8?B?RThSMjZBUHN1MGxWaklCMlQrQ00vakpZS0llQkQ3Nk81WjUvaHBOYm5XRlNC?=
 =?utf-8?B?aWhBdzZRcXg5dHlvWnc2SWEwVkJ2RzFpQXdXbkxOSXlFSVV4ZktMWjhieVVB?=
 =?utf-8?B?ckZKVVhiaUk0bXBxOS9GVzZLZUdYZnRLWWNHN3Z2U1piS213cFBLak9OOVdo?=
 =?utf-8?B?dmdKM1FJN3BlMVI4R2FXUlhzSkpZVmtINFdJVEVkRWVGWW1UNFpQN1h5dmVX?=
 =?utf-8?B?cGlTV1o1U2dGcVl4NkdWci9uUlZOczRnZWNmN2VMK2pMUjdBZVJsYUJON2hR?=
 =?utf-8?Q?bNrFjzfP1L3uVIBarCQ7gwXLz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2a0630-7662-4474-57fb-08de3c1026d4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 19:28:40.3218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzTWbutaqlnESTrsSPGUIJ/EmdbXUPew9UJFB6K87hh/gqszGrlnKz9QM5nicPTpewD6qEVMPliSjWjhgD44pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491



On 12/14/2025 3:03 AM, Frank Wunderlich wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> From: Mason Chang <mason-cw.chang@mediatek.com>
>
> Add definitions for Receive Side Scaling and Large Receive Offload support.
>
> Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   drivers/net/ethernet/mediatek/mtk_eth_soc.c | 23 +++++++++++++++
>   drivers/net/ethernet/mediatek/mtk_eth_soc.h | 32 +++++++++++++++------
>   2 files changed, 46 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index e68997a29191..243ff16fd15e 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -50,13 +50,18 @@ static const struct mtk_reg_map mtk_reg_map = {
>                  .rx_ptr         = 0x0900,
>                  .rx_cnt_cfg     = 0x0904,
>                  .pcrx_ptr       = 0x0908,
> +               .lro_ctrl_dw0   = 0x0980,
>                  .glo_cfg        = 0x0a04,
>                  .rst_idx        = 0x0a08,
>                  .delay_irq      = 0x0a0c,
>                  .irq_status     = 0x0a20,
>                  .irq_mask       = 0x0a28,
>                  .adma_rx_dbg0   = 0x0a38,
> +               .lro_alt_score_delta    = 0x0a4c,
>                  .int_grp        = 0x0a50,
> +               .lro_rx1_dly_int        = 0x0a70,
> +               .lro_ring_dip_dw0       = 0x0b04,
> +               .lro_ring_ctrl_dw1      = 0x0b28,
>          },
>          .qdma = {
>                  .qtx_cfg        = 0x1800,
> @@ -113,6 +118,7 @@ static const struct mtk_reg_map mt7986_reg_map = {
>          .tx_irq_mask            = 0x461c,
>          .tx_irq_status          = 0x4618,
>          .pdma = {
> +               .rss_glo_cfg    = 0x2800,
>                  .rx_ptr         = 0x4100,
>                  .rx_cnt_cfg     = 0x4104,
>                  .pcrx_ptr       = 0x4108,
> @@ -123,6 +129,12 @@ static const struct mtk_reg_map mt7986_reg_map = {
>                  .irq_mask       = 0x4228,
>                  .adma_rx_dbg0   = 0x4238,
>                  .int_grp        = 0x4250,
> +               .int_grp3       = 0x422c,
> +               .lro_ctrl_dw0   = 0x4180,
> +               .lro_alt_score_delta    = 0x424c,
> +               .lro_rx1_dly_int        = 0x4270,
> +               .lro_ring_dip_dw0       = 0x4304,
> +               .lro_ring_ctrl_dw1      = 0x4328,
>          },
>          .qdma = {
>                  .qtx_cfg        = 0x4400,
> @@ -170,10 +182,21 @@ static const struct mtk_reg_map mt7988_reg_map = {
>                  .glo_cfg        = 0x6a04,
>                  .rst_idx        = 0x6a08,
>                  .delay_irq      = 0x6a0c,
> +               .rx_cfg         = 0x6a10,
>                  .irq_status     = 0x6a20,
>                  .irq_mask       = 0x6a28,
>                  .adma_rx_dbg0   = 0x6a38,
>                  .int_grp        = 0x6a50,
> +               .int_grp3       = 0x6a58,
> +               .tx_delay_irq   = 0x6ab0,
> +               .rx_delay_irq   = 0x6ac0,
> +               .lro_ctrl_dw0   = 0x6c08,
> +               .lro_alt_score_delta    = 0x6c1c,
> +               .lro_ring_dip_dw0       = 0x6c14,
> +               .lro_ring_ctrl_dw1      = 0x6c38,
> +               .lro_alt_dbg    = 0x6c40,
> +               .lro_alt_dbg_data       = 0x6c44,
> +               .rss_glo_cfg    = 0x7000,
>          },
>          .qdma = {
>                  .qtx_cfg        = 0x4400,
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> index 0168e2fbc619..334625814b97 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> @@ -1143,16 +1143,30 @@ struct mtk_reg_map {
>          u32     tx_irq_mask;
>          u32     tx_irq_status;
>          struct {
> -               u32     rx_ptr;         /* rx base pointer */
> -               u32     rx_cnt_cfg;     /* rx max count configuration */
> -               u32     pcrx_ptr;       /* rx cpu pointer */
> -               u32     glo_cfg;        /* global configuration */
> -               u32     rst_idx;        /* reset index */
> -               u32     delay_irq;      /* delay interrupt */
> -               u32     irq_status;     /* interrupt status */
> -               u32     irq_mask;       /* interrupt mask */
> +               u32     rx_ptr;                 /* rx base pointer */
> +               u32     rx_cnt_cfg;             /* rx max count configuration */
> +               u32     pcrx_ptr;               /* rx cpu pointer */
> +               u32     pdrx_ptr;               /* rx dma pointer */
> +               u32     glo_cfg;                /* global configuration */
> +               u32     rst_idx;                /* reset index */
> +               u32     rx_cfg;                 /* rx dma configuration */
> +               u32     delay_irq;              /* delay interrupt */
> +               u32     irq_status;             /* interrupt status */
> +               u32     irq_mask;               /* interrupt mask */

Small nit - is the comment alignment really necessary?

Thanks,

Brett
>                  u32     adma_rx_dbg0;
> -               u32     int_grp;
> +               u32     int_grp;                /* interrupt group1 */
> +               u32     int_grp3;               /* interrupt group3 */
> +               u32     tx_delay_irq;           /* tx delay interrupt */
> +               u32     rx_delay_irq;           /* rx delay interrupt */
> +               u32     lro_ctrl_dw0;           /* lro ctrl dword0 */
> +               u32     lro_alt_score_delta;    /* lro auto-learn score delta */
> +               u32     lro_rx1_dly_int;        /* lro rx ring1 delay interrupt */
> +               u32     lro_ring_dip_dw0;       /* lro ring dip dword0 */
> +               u32     lro_ring_ctrl_dw1;      /* lro ring ctrl dword1 */
> +               u32     lro_alt_dbg;            /* lro auto-learn debug */
> +               u32     lro_alt_dbg_data;       /* lro auto-learn debug data */
> +               u32     rss_glo_cfg;            /* rss global configuration */
> +
>          } pdma;
>          struct {
>                  u32     qtx_cfg;        /* tx queue configuration */
> --
> 2.43.0
>
>


