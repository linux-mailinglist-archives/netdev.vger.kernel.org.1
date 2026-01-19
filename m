Return-Path: <netdev+bounces-251059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1DFD3A849
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A6093004B9F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978F434D4FA;
	Mon, 19 Jan 2026 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2panOLtA"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6522CBF1;
	Mon, 19 Jan 2026 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824645; cv=fail; b=pLwvOMyVfZ+xPOq7Ac4p1eRcdDep8RS6ZIekr0uUd0O2EO0DSHsXB823GvqUe5E0Bayv1uwiojcda5H1NDBf3ID1KeSuA6JJH4EoED4EaucANDW1c1ZZShfj20eYRxq2IoyXlBPRUJf8mjyzEZdU61i85O/OCgEUAVPFNej+5EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824645; c=relaxed/simple;
	bh=5AYiR2MxSwPXYLWbyiUD6TrfRy25rbBuq8xcKTZd4Ts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OXZBJNuaqMDd+y2rtJokyx5P8/b0GxXj5s59kFyIRyqXWuwx9eZ+Luf/H0dnNxF95o855EbgfbLkLsiaKT3QnR+Jo+50owjkG+niat7N6Hyyyq5F48+KEs26JvWCLN3IMlKcwCt4ud3ghUSX1nTV5vJN8JKcDcdNdoReJnHiNrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2panOLtA; arc=fail smtp.client-ip=40.93.194.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwfdZ/0sfbEQQIdaezufurEpr260JgLKZ7Xwfo8aUL6A+nOqmZL+fy+eRdGM1DeZoA0b7PH5bI9QZKlSs3hjbsTd5Zy5FHVnKN7vbkOGBTy5ZXF3BYhRRVPQ0UUuWbfB7eoIKBhTrIrvX8RVBLB7vjuIqSieBskah8WSO1/gCaz6igfJzhJqHN1xf0JDkw5w4ykUdsgKeFVERU6iE+0ePx8Az1SotZ6TvKLzxPpCnjP8zDDuDDiedN2Efz80QR7m1v/fDacmNgnmjqgq/ZEFpqrtugpp+zPtZsUM/LUvWuYVR+2p4nBgL2ySpIxrWpdaSQ5jIk4dXOkFJZkuEEVgMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcQtomXfPDa0hSsnMCmielc2XnY0M+O/1AKtV645RAk=;
 b=YV7qabgHrA5NqFKioq5B3fHwQ0akY7DhIYZpdrUNK6aY5Iuxo8er8ThAOgVUbpPG9jZrZM/VXbZoIMgrdPHFidJMqKVIhxRt12zPu70oZD/9v3kIL/JzQ7I2BJnYZbErty0J+Tg0WGjlst7KhH1TLNMIy8fKT1FQ07UeCCuEBBzaZ0xLbYBQ9CyWtlLchXlrN/eA0CJfOO6kBOtFtQel4x9+7WdY12JmTtj7CGuJ0S2gTtCizxeX+71mEKqbqUVCdfZDBmbLAOnrhYoo4a2enYEIdvodnUAe12GNnQtkydY/RfHcVcIhwfr0l3ZXD/2at8oI15yFbVXAJKhpDy67+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcQtomXfPDa0hSsnMCmielc2XnY0M+O/1AKtV645RAk=;
 b=2panOLtA9wFccZF9ta4vrfUj2+GH6ldIxe7EXJ6T3gq1nOQMpYqcn/k69BOiNIKSnMMtXEgYdmNzSLzYchTQITL8X+Hid/n3WyahVesLzqUwIw1fb9QXdBhHn63ws/gjy1i1ou/IzjlwXh8LYEm69mUSLcnD73ot2lnXh430+yw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 12:10:40 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:10:40 +0000
Message-ID: <fee2cc4f-5001-4734-b0e0-ae548801329d@amd.com>
Date: Mon, 19 Jan 2026 17:40:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/9] net: xgbe: convert to use .get_rx_ring_count
To: Breno Leitao <leitao@debian.org>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>,
 David Arinzon <darinzon@amazon.com>, Saeed Bishara <saeedb@amazon.com>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 UNGLinuxDriver@microchip.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
 <20260115-grxring_big_v2-v1-6-b3e1b58bced5@debian.org>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20260115-grxring_big_v2-v1-6-b3e1b58bced5@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::22) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fbd2df-7804-4159-d23b-08de5753c2e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUZGN3oxZHEzSmdtNzBEMnNtckREWkhMWm5yanpBQ0R1Uy9ocW5WRXNPQmZZ?=
 =?utf-8?B?a0V4Q1NKcnduMFNHMFhSYUFydCtTNll1UFJaYnVxK05ucHdSWDYvSU9VaUFz?=
 =?utf-8?B?Mm5sd2xyWUhWMEZ2Qnd5eTczTzhPRENNK3ZSZHF3U2JKcWtzRjVBa2tmYkN6?=
 =?utf-8?B?SFh4OGIySVZjRXRZdzZWejhycjhFNGZyUlFhOXFJR0x4YllzL2Qrd3VQcmEz?=
 =?utf-8?B?SjlHOXBGb2dxdktXY3U0YmI2cDNWY1ZpSUoyQWdkWjBrVjlqZXhZcWdob0Vr?=
 =?utf-8?B?QjdFNWtpa2MxckFmbmt2R2MxR09veHh2M1JOYnNOZnVTdGFpZ25mNVNFZ2tM?=
 =?utf-8?B?RnRVUUlkeXpyNEo0NFYxUTdFUlVTNmdsTFF2dmVvaFZJQXQ2eFlZaGNyekJn?=
 =?utf-8?B?TExPZWxwY0E1L2djY0NCckhhc1Y0aHNGaWEvc0tmMVRYL1FEN0padzVsMW5u?=
 =?utf-8?B?eHpDLzhaNXVIMUkrd1o1SUFmaEkzVTdFNHhwRTEwaVpGZEVTNHJCNlB6OVBl?=
 =?utf-8?B?aUVLeXdtNkF1b1dlaFVwbFVCVG5TcFZKWk4vaThudTFicFJaaHNmWUdMS29n?=
 =?utf-8?B?UDk2cmlHNWU5bFFqQ0ZOS3hoMWVCdDUyYkhLcTJ6OGJJZ1lYYTRocjJwcGJO?=
 =?utf-8?B?bGd0cG9MdW5TQmtISXh3NVVrd0wxOTlja2hLSGpzNmV4QkVzdFZmY3FzNDg0?=
 =?utf-8?B?SHNzS0dOWUg4UDJGTTVtWG9rMkRBTTg2dFFPNVpaUE1JaXpic0NiR3U5WWY0?=
 =?utf-8?B?TFdkK2RJYi9UNFFFY2hGY3UvYTJVbTN0aE94WGV4bEJUU1pJOHAxaWdkRW5Q?=
 =?utf-8?B?N3RMT29abmtPQTREemlLS1NtQW5iQi91OElvWlpwK1JBT0ZtbmtzVzVLK0h4?=
 =?utf-8?B?K0R0OFdSZzc3N2lXZmx1dlg3UlJQM01jRWNhNnBuUmZrSHhjZEp2MlhPVmIr?=
 =?utf-8?B?bFdFSWxXZkZGNDFTWnFJbHl3ZWY0VkFSTlRQalQ2amZacFNWMEpvL3JoamJH?=
 =?utf-8?B?MmwzZmJGN3J4RTNacVRCUzc2UWpXeUtBaDdpZXY2ZnRYbWc1SFNZeVh1TlJm?=
 =?utf-8?B?MnVPYVhZS2VPQlBrbk9zNGZ2dTlSTGNtVEg3QzFPMHhIZWVncHUxdjZzTW9l?=
 =?utf-8?B?RTJ6NHlvNUNCMUgxMC83WVhsZ0FBMW1SNk5vRHg1QWVmem1QdmxHaDNkWlZi?=
 =?utf-8?B?aElhaGdxMCtsWDZIK2h4eTBVdUpnMVRwdlJ0L1JRcTE3V3Zjcy9kQWdZS2cr?=
 =?utf-8?B?NldxNUtNa2w2RkFQcENFY2pVM0hsVG9zMnE4dHpEMFJERUpyV2g4U1FxZHEy?=
 =?utf-8?B?VW1tcDZQZTU3Y015RHNnQ2swdUV5em4wRHpBVE9FY20raUVnZ0NMV2dMUjNE?=
 =?utf-8?B?NHVNeGNjWWNPbVhVcUxRdjI4UFJpTUU0ZjJBKzFtVi90dWJKb3VkYUJXdFhR?=
 =?utf-8?B?RjVvcS9oaHl4K3pjRUtkdzA1dzhNL2R0MW1nUjdSc3ZWcXFLckFZYmFTYXRS?=
 =?utf-8?B?QTFCTzV1dWRTUHNxL1ZrYW9ZMkdRU3N3TnRYNFl1RnY5bnU3K0YvTjF6TW5L?=
 =?utf-8?B?cVVnem5FL3RZVjJpQ1hJSGo2a05aNGQ1aGhmVlhhYnNnb2NQNWIxZ2RiSnpO?=
 =?utf-8?B?bVNzNEFZdWNzVHNodGRleW1jR3IwTmpXbitYN3lBQWFGQ0t1SklBbnN3Z0tP?=
 =?utf-8?B?VlovQnpYNWtqS2FOdk14VTRMSG9SUW8rY0NqLzJDRXJHNlJyVFN0bHBZTnl0?=
 =?utf-8?B?a3g1NnBheVZjVXZlckdtY0FwdHBaRDFtUThJUDdobkVUblNmQnBHd083SDJz?=
 =?utf-8?B?U3RwL2Rxa3ZSY05NZ0lwdE90RUxDNWZ5bE05aTVpcnhxZ3IvS256eHF2OXBs?=
 =?utf-8?B?alRYNWVRZnJ3N01JT0ljZW1GdzZWVjZ3Uk1KODl0VnQ5NmVSSmloV2pmbVZC?=
 =?utf-8?B?cHB4MlRIaGpsby9tVG83RUVEcDA5U1QxcEw2UW02UDBmb3FFOFlhR05maGYr?=
 =?utf-8?B?SFZWa1FTdXp5bHdhRkRyanRaWHpjOEpnRVpnVXBhZnRqdS9yRi91bW1zaXhq?=
 =?utf-8?B?Q2xwdTZyNTZaemRwWmlMcEhjSWhwTXc2WjJxZnBpakRyUVhsNzYzZnF1TGx3?=
 =?utf-8?B?bEV1VVhwN3NJZm1wWEhuV2REME5PUFYxZndlOGlacCt2MHlkaGN3RjVJamxh?=
 =?utf-8?B?MlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2Zxc2hPMDBta2liUG5qREFPcG5LbytNZHhWaW1KL2F5ZXovbGJYcVp0aVdw?=
 =?utf-8?B?eWQ4UVNWOHdZZVdHYzFZNWJVWU9CanlUTlMwZTRCZitocTNMclovT1hOTEd2?=
 =?utf-8?B?QUVSaUhiWkFxMTlhSWVDNDhzMStnc1ZQUUxPcUJVMmNyQjV6bFVONjJjUzZV?=
 =?utf-8?B?eUtkWlV2MXFxTjdVRnBuejZvbi9JR0FKZVQ3WitybE8rVzVhYmZiUit6bG5z?=
 =?utf-8?B?aE1jeDk5S3lTeS9MZXQxRHp2cTJtRCtHenhaWmVmQ3JZUmxWbnRBdldITHhI?=
 =?utf-8?B?cGVYUk11Q08zY3V3dExBLzhPaGZyT1dndzR4NnI5Nk81TGJIem1OeDQwSStM?=
 =?utf-8?B?VU9QUVFKU0NyWXVKdDJPTmc3RFcvZVdvVjh5MWVCRlYrbU11d28reXNWdU1h?=
 =?utf-8?B?VHUxTmdrL29aN2RpRjJkSGxLUDFKS3dVM1FRNlMvUjU2UWthUE02RUthdFBU?=
 =?utf-8?B?RVBoUWo1dDRFbjZHeGU5dnhEQXNsNWdDOEVGdklQTmNsUlYrTytOQ2RDRGNT?=
 =?utf-8?B?RzBYaFB0NTg5NDFDR1ZldWJROW1VZDlZaGdoZ1dFWjA1NTZDY0tnd0tBWmVk?=
 =?utf-8?B?c2d2THlUOENqRWs2bDdVbm1mR0RsVG1KS1VwbWordURlVFRXYXBlUXhqU2hZ?=
 =?utf-8?B?b2RDR0xETVFicWYvN2hXOTJZNTZDZFdtaHl4aWI3ck9UaWZKc1NEaTIySHpO?=
 =?utf-8?B?Q0lpVVBCSVlDL0htZG9oSzdRRFFDTU9jK2VCU1dwcjFlbzFTWWM2M2RnNWY3?=
 =?utf-8?B?VnE0bFpCMnE4cUVDZHA4Sit3MUc4WTluY3JEZm5VQ1Z1b0NjQldMNEE5RXJ3?=
 =?utf-8?B?RkZSOER6LzZVMExVK01hQmtXUGYzQkU5eHRYdTR4WEdZckVxenUxQVZZSkJi?=
 =?utf-8?B?c0ExQmd0ZnlBcEpCcmg3VGNDRlZsY3daZFVJS3NjNDluOWJ0L0Y3M2ZGSVgw?=
 =?utf-8?B?WEE2dU4waHh4UGcwNXpyU0N2QWdTU0o2NmdxNitvajdSQXQ2L0xCOFhHYkQ3?=
 =?utf-8?B?ZzNwWUtZTGxJUnRSWmhxQTZmMkMvYUo5N04yb0gzemhxdWFDSHVyNmpuSFdM?=
 =?utf-8?B?bEM2RG1NZ1QzbDQzRlZHSG1LblljTHRXbTRubG45VC9sWVUrN05PbDJFK1N0?=
 =?utf-8?B?V1VVTThhUThETlB0N1VBdHZhV2srdlhKQVRGN3JlakNmS2J2YVNCL0cvVEdN?=
 =?utf-8?B?b0x0bGdTMitTS3pVM1lVNnFLOThRcWFXbCtkUWx6TjV3ZlFrYWJzWnFrcWQx?=
 =?utf-8?B?VWpZbmtjR0M5NlV3dmFOR2xOeVhBZDEveHQwUHZnQThLTjdTV2VZUlRmaWJ2?=
 =?utf-8?B?YW9qVEx6NFJ3OUI2YTJ6dkdoOHFURGM5SHk4cG1oOUc5dUhuZVF3REFqZTZH?=
 =?utf-8?B?TENrd1ZrTlk0WUdjazc1UXlsTmN5RW9SMit1R09velZKb3ZaK1owMDhkUFBp?=
 =?utf-8?B?RmpuNGM1S20zV0dFY3ZPZnU5ZHNxKzVCVFRvRGt0QlQ1Y2E3dk9jZ1VlcElP?=
 =?utf-8?B?eklxQldEN1UxbU1XdGttMVVDMnJGTnE5TWU2UEpoMHJaaU5ldFJGWW92anNT?=
 =?utf-8?B?LzhGNmZ1dGxnR29Nb29uWDZxZ0doYW9tMXdPdDM2dnk2N0lwK3ZDaUFBMlpG?=
 =?utf-8?B?SEp5MFJSTzk3ZVNEdDZPNVN4VStOaEhCN0JOZzQ5bUFhMFNwNmljZnJzTyth?=
 =?utf-8?B?ZEJSaHJKNXlJMkErOGg2RnJzSExoZ2NZdktUYUExb2pESHN6V21Md0c2YU1u?=
 =?utf-8?B?VVFUUSs1ZGxCMTRldEl1U3JaWGh0TXlBLzBJeE04WWUvN0djcm9SZWl4U1hI?=
 =?utf-8?B?dlN4V2JVOUxiWVRqVGlka2I3M0FEMkZQZzh1OHhsZGViK2YyT3poa2dYZUFG?=
 =?utf-8?B?ZTg4b25yTzdGT29PS29EeVE3ZW5rRDl6NDZpd0pHbTdvblRQMFNJcGtJMzlG?=
 =?utf-8?B?cEZCdUc5SU0rUEpUUml0QS9od1JPWmxNclpodytDdEd5UG1aV2w3L1ZsYTJ6?=
 =?utf-8?B?eGVPbnFmOEU0WmVlTm9uelJGV0s2NGx1a0drN3o0bVdGL0czMmIwTG5mZFR0?=
 =?utf-8?B?Mm52aHNzcCszWkxaSDFwVjhyMU1aRHZSS1QyalhzRmlUbkVyMkkybXllNWhn?=
 =?utf-8?B?UzJ5QlJZMW5qdTJmYkpDQ3FoSU8xbS92MHIySzg0cGFiNlNET3A2Y003NnEr?=
 =?utf-8?B?L1dZa1AwVVJReXdJaWIyaE8wcVhOQ2ZwK1NiQnJWeHU3eWNpejJscGd6NEZi?=
 =?utf-8?B?b2Frc2xvSllJclhKQ2FMaGF0MnljcUlUbStYYm5IdXcrbG5ycjFYSHpQQUlR?=
 =?utf-8?B?MW5xek9UMWV6bXdRSElwc0ZGWUZGcnJoNTlQZ00remF3bHpxYlVKdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fbd2df-7804-4159-d23b-08de5753c2e4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:10:40.1705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RQq9f1Ay842bWsCE6w4cHsmDZx/drqCQQ9QDYha/ddOk91nkC72qygVfnVBvRNkXZyiQt6jJfXXBGO1KKzPiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839



On 1/15/2026 8:07 PM, Breno Leitao wrote:
> Use the newly introduced .get_rx_ring_count ethtool ops callback instead
> of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().
> 
> Since ETHTOOL_GRXRINGS was the only command handled by xgbe_get_rxnfc(),
> remove the function entirely.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>



