Return-Path: <netdev+bounces-202498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 539A6AEE182
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E6E7ABCB5
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2A825A32C;
	Mon, 30 Jun 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nZn+/w2b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B296A259CAC;
	Mon, 30 Jun 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295161; cv=fail; b=lUPUeEAH0TxR8K11swEyN3XoV4OPLkYlCcZVpojiXz15cGhU3Z1FHiVfdCF1eUUAcNFnagQooT4sDYWxrSBuTHq7CkGSZc6ugjBL0Q8aNqQnhPcHi0Kj9LRWKeM5ehhuZVNWwe+Yla6WfLhDpoqGOOpiodjtvE2yYJF4TK3N/tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295161; c=relaxed/simple;
	bh=qO2+zpwkr1jh6tZS12Qi1VVreX0Z1wZ8L7oPjko1Fn0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N2XS9CZnJGiaTvI5Hd1EiLwj5cImJEvcsmlnaQNi2buA8dvORZJzDeQ94s6GLCS9PPb+viFCqnc9dZppZTumwbcS0Obk5Q8AXYwWwznkULHjTk7kCbkNcQRedLnDwKrqFwtGpKRSpxjePJaDGbJyqMc5HfKQVO2PLmyMePO12pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nZn+/w2b; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qipVwqGWaCvcvmkWjvMR/5VG8VaXbf+v5tlUjRtCzDpFgH1ykRRTd8EAA8v1jEnZ/5SsClmCUm31BgCeGRh7y7xIe0L3HKGLJT2djSKFeTlxpsGsVoKA60899VqOsy8dSoIKF3fTHLrZDWjQ3D9Wyq0vs5xHwHHHjl1IhkOGQcBh+/XfaqpRP0azKW5PcFzesgUbYjNSZImpMNq7Gvz9dYuwdzPNY/M8O7qaki4sWa3TK8j+T+s3+aL2YF2Fg/6EAoxCO25pUIz5M33Vxfq3WhT05bCZ/m75/pCt4TRpy+Ktu1CuPwiw3W2zpdjfpOfBv8fTweByDQtyHJzSx3fWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJAGk38gywhciuatj9CYyGSxgiXzrOO4XuOrmtKPhB8=;
 b=mMhT5j7Co8WEA3pMm4zbUnd6Y3vEQikjjLsUQd1X+nCGYKQZ3T5W8QaIeo2nyC0UbrjxMbgShG/vR4fWOlUM7jSfkNmsOamR97Zv6zEXzugKEZqkXyJbA82bAi6x4erVMOP9GIw23hy+vck2IC6PhhHCbaIF3iqI5UP50SPlfnzraZaLNw0qujUIogs1yCnpDxhoBsYbtjewMI8FUbEJ/3xDMWe7MrYtQCLmHkzrT+Hq5W1TIt8+dfPkmjDlW+RTGfGHGumjKR33pP2b2+t7gh10vGgsIv4ZUN3I7lBWqqUn3SDpvDAlDKegkA0mGfMHZqJrOwOlKj9N8aX7aHUceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJAGk38gywhciuatj9CYyGSxgiXzrOO4XuOrmtKPhB8=;
 b=nZn+/w2bZqULR4N0Uscs+wrGt5mpxPsTOCIWNrJpeoLozfm8GM5a7Sbt3lP02XMxhrFPLF5lZhdW4W++eB6fimtfM1Ce21+scr0swoIxMvCP/w5ICzqbw5sUynTTsgZ1DbbfZv6fqUtPc4wI/IICbHXX9SMRQa1CaLaq1h71N88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 30 Jun
 2025 14:52:32 +0000
Received: from CH2PR12MB4199.namprd12.prod.outlook.com
 ([fe80::3cf3:1328:d6cc:4476]) by CH2PR12MB4199.namprd12.prod.outlook.com
 ([fe80::3cf3:1328:d6cc:4476%3]) with mapi id 15.20.8880.015; Mon, 30 Jun 2025
 14:52:32 +0000
Message-ID: <1a6ba55b-3077-4db2-a6cf-c7dc96619c94@amd.com>
Date: Mon, 30 Jun 2025 15:52:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 02/22] sfc: add cxl support
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Edward Cree <ecree.xilinx@gmail.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-3-alejandro.lucero-palau@amd.com>
 <20250625173750.00001da4@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250625173750.00001da4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9b7d59-e654-4d56-2142-08ddb7e5bded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVRmSjB6ZkNLNGdhT1lQbm1aak4zK1NWdnJ5bmVnREFUR3p0WEhSOTk4N3hH?=
 =?utf-8?B?NUVxc2JRZ0h6bmFGOGk3b0xieVFjRlZaK3Uwck5oR3NpM0RoY0RJcjdCQ2V5?=
 =?utf-8?B?N0FtRGNkNlNFMGo1dUcrMXI5aU12ZC9wVnBsMGdrUEcrU3c4alFjYXB4Z2dN?=
 =?utf-8?B?Z1VySWhwSGFBdkpET3ZXcE1WSlFFQzB0cGlmbFNSQkdPazNaNGtNeVBob1Ns?=
 =?utf-8?B?LzZsRTY5LzlyNU1oNy93RmNnSWdHN2pkWTlvM3U1czhsRTZwQWxic2Z3QVkr?=
 =?utf-8?B?MDRVQWQ1V0wrdEZsR0tETU1uaWpzeGtDMmpjbE0rRkZlUXNsT2IwUFZWSjNM?=
 =?utf-8?B?WHg3cFJ3OXprZGV6TVNERVJsQ3BLOGhld3lEbzJJS1FSQjVxQXN5cUdQK0JE?=
 =?utf-8?B?azZSNnNqekpIalFnMWZTdk9ZUWVsMnhzZnlLSml6UWk2S2ZNZVhGWlllYnB4?=
 =?utf-8?B?RkpZdzdrMGxjSUVzaXBvOE5YUnFIT2xpNXg3SEhQTXYzeVhNVFp1Y1htQkpT?=
 =?utf-8?B?dXhRejNnOHFBM3dHeHk3bHRkL0lMMVk1bm1Dc2I4ZjRJdnMzREMvNldjM1Q3?=
 =?utf-8?B?NmtCbFdabFp3NExaMjJMTFgyZy8vWFZrSExBdW55QTZyZFl2SGJ4bks3K3J4?=
 =?utf-8?B?TDE2K0F1M3BrdUMvY2dJRk9yVkNSWkFEekJRNjAvWkxCWnpmeXdlWTlmcVUv?=
 =?utf-8?B?alFGMU9NM3Z2anp4VFRTQlhmRFZ4ZXpRWUlmQldRcUNsUC9ONkNFYjZ5TFJt?=
 =?utf-8?B?azBnVm9PZkgxZE1tb0Jackl4anRCR3FTeWU1OUZoUWRiRWtFKzZBMDJ1Z24v?=
 =?utf-8?B?dTZ6d2tuRFlJMmFlOENjcllNbnNxcUk5OVEzTFNRUUc5eDFIdUxNR3AzNDlq?=
 =?utf-8?B?a3BqOE9lODZHYkxMUnM5QzRMdDZQdVRIMUFrZVZkSDhSVnNSVnUzNHNzMW44?=
 =?utf-8?B?elRHbEg1aGtZcXNIK1g1ZkQ4Qm0zd0pYVVlTTlZTcUtZUzVLbmJUUlY2OTRM?=
 =?utf-8?B?emZGekw5eGlZNlk1VXJ4ZWloVlUrYitiVmJFQTQ3S3dZWnR3SEt1NHNJQkQ3?=
 =?utf-8?B?bk41TFRDTnhLQnpDVmpkVmtFeHdlUjRJWGxML2V5NThHNzhqTGZlSDV6Q0NQ?=
 =?utf-8?B?YWR4WXNWbDJzVGtsNXVTcXZYMGZiWVM2TWhMS1B2QU1kOFhPd2xIeURvZDMv?=
 =?utf-8?B?TEJLZ0FmdlN6N0NYb29JZFY2ZTN0WXYrZGFGWDhSL05zeTBZdUYyWFRoYjlM?=
 =?utf-8?B?cEhwV2liRXpvZVVZSXc1NFZmYmVURXVuQ2tobHZVUE0vZmpJd0J4U2NNRGNp?=
 =?utf-8?B?TE5jdnVUY3djZWhFTGZzMFZXMlB6cDhuelprQXhlUC9ic3k1UjhlckkwMU5V?=
 =?utf-8?B?bFhGd1EwSHZGeEhjZFdQd0I5ZHQyT0RQZ20yck0vbzFIaDZ5NGNVTys1dTJi?=
 =?utf-8?B?Mnl3S0tPZjhMd2ZxYmQ3MFpDM0xpNCtxamdhZDhBSWRWODdZVm9MM0szUHd5?=
 =?utf-8?B?ekpib29TZ3JubDhoUFJRaFQrK1N1aGF5R0lOQjNsNkQvQVhJUUp6eGcyUEsw?=
 =?utf-8?B?MUcwVDlLNExjT0trMUkrSjRPTFpBS0N0RFNJOHZpMi9BbHk2UE5IY1dWVHdK?=
 =?utf-8?B?VXdqT0VncjNWSkZ5b250WkhTcDV0R1J3U3BOejhHN1lEeUVORFdQaGcyOXFX?=
 =?utf-8?B?bVpFZ1BkczVlL29wdEpXTUZsZ3orNHoySkVQZzFyU05vV0lWMlBRSXAzNkdX?=
 =?utf-8?B?UFBxUVdRT0JOMlVieWxZQWkvMEpSbmh5QXQvRUsrLzVBenlOVlkyY1VSejZO?=
 =?utf-8?B?WVZqT2Q1Q0R0bGYvejI2dmZkbGR2cUpxYlc3QUxZKzhiS0NzR0thNjkwUHdo?=
 =?utf-8?B?SlBNYkhVTm5uK3NrRk53cjUwTEhibUsxbnF0ejM4REdSa1ZXVkY0K0RpZ2RO?=
 =?utf-8?Q?r9mHmTuMJcc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEp5UEs2K2dnUjlkcklhWlZYSWl4UUlnSjdIZ2s5WUkwdmNMWW5oanBBczl1?=
 =?utf-8?B?T0ZrZG1kUS9pMlJUUnpKUU9WbkZXNzFWcURsdVpvVXJubWVaRDRzZTRsbzhD?=
 =?utf-8?B?VytHZ05rc1NwMUtQSTMyR1pKdG9VYUZYYU1COEFVSWlZcWFuUHNNWFRGWDE4?=
 =?utf-8?B?a2hYTU9xUjVhM3BPQmZoUE1CSGRhS25EeE1OVXpPaEhuMFRpdDRSUm9rUzRL?=
 =?utf-8?B?dlJKeXJpK3ZYOUNCM3hOY1JvQ0F6aGNoRzVPWDU4aUxudmJJRk1vbTNxT0xZ?=
 =?utf-8?B?MHkzVXdIY1V1QzVZYXplZHplaWIxSktsVHZCWEh5MXVKbGJ2a2VEeDhqbGVs?=
 =?utf-8?B?UlJWRFpDcmIrZzN6Und1QWM2S1V0M1RGNWZsTG56aGdMRFpzTUx0czY4YXR2?=
 =?utf-8?B?TEtBKzEyV3R5VGZ0c28ranU0QUcwOVBHbXZKL0FUTG5XeVluRlZRYXpXTUM0?=
 =?utf-8?B?WnNqbWJhcEdXMk55UEFzZUFSRkRybkRLUjY1NVc4RVN3UWxLYmt2YVorb29y?=
 =?utf-8?B?NGtIVkhZUjBvdlhWQVJUM29pNEJQVWN2b3p0ZGtYd2ZaU1VGNnVoR21uUC83?=
 =?utf-8?B?WUxydUlmQmJGdjR5U0xHNU4zTlpXeXNPNThLYitySFpUdjBZZTlFbUh6aDN5?=
 =?utf-8?B?UWozL0F0dkNNN05tNkhCbW1tZUVmS2J2aS9DQlZzQjB4dzB0SE5JaGZuNDA5?=
 =?utf-8?B?SUJaVTNhWnNJM1lMUEcwZkxwbGpsSGRBSldabDRtWGJDQVlLUVZxRWovOE9R?=
 =?utf-8?B?c3BDRXRXbUozVEtqc3A4WWd1WllDY2tWZjR4b2dNWmt3MWdpVmV5LzR2dVBW?=
 =?utf-8?B?SlZ5TldsaHQvSFJxclJtaXJhakJTeTNRL2NzOHFBaUdMUVFNTUNNNXlxY1c3?=
 =?utf-8?B?REFuUVRtbDdFZHpUakdyK08rSTZhamRtN0pEMHdrNkF1OEdueEM2K1pDbytW?=
 =?utf-8?B?ZlBkVWVUQkcrbmN0SForV0UyTW1oUTczS05Ybk95Y3M1dkpQQjdpalR5cktq?=
 =?utf-8?B?eGZHTThSM1lscVdDK2pUbklNWVVMMlZmTWVXTXBEejhaZ0s3VHRTeGVrbHNv?=
 =?utf-8?B?Tk0rNTJBWVVDZG9PY1QwcE9DRmpMU0pUQ2hzUHV2ZkljeUNzdjdyRThVaWl2?=
 =?utf-8?B?dmF3RHV3UzAzakJ6bGxzNjk3SGdLQUxWK1BaU1ZyZitVSDJlSml3cjRGZVFJ?=
 =?utf-8?B?Rksya1FoYmdWVWFseVNqdklhQzhXQzIxVDhHRXBkejhTUU5ycm1qSGYrbTRx?=
 =?utf-8?B?ZExtNzZPZFpvMDY0TnRZSUFEM1ZkMEcrMmlVaXlkR0dZZ2JqZWI4S3JEbGJz?=
 =?utf-8?B?TzNqYXYzZGpMU3V3YlA1UCtkWnl6YXNlb1VGdjkzNk9mV3I5S05pTDhUU2ls?=
 =?utf-8?B?NW1XZElDV1V1QWdYdXF3VnNSN2FtaHVHY3pNS2ZzYzdCcVhzTVRMdEdkVzdJ?=
 =?utf-8?B?TjdoUGFoQXk3Z05RQlZZWjVHbkxLQXFKZkdsMDlxVWMxdFROaXptcSsvaVEx?=
 =?utf-8?B?MXdFeEN5cE45UExFd1orY2VYY2F2c09lNEwrdEErTWxHM2UwWUo3dU50cEJ6?=
 =?utf-8?B?QkpKdENGOUw4OThlM3ViZisvVDFDbzFnaDRicTI0ZmtxQ21uandtdFl6d2xZ?=
 =?utf-8?B?dHBGOE8rbUpmalhFdkYzcVI4dC9KRTdDSGpzMTVWaXYrV1V2aVNTNktCWXlE?=
 =?utf-8?B?MzJ5T083U1M5WjRkWUhZdFIyYk9OTVIwa0hBOWRuN2xGT2VpVVdWMm05MlpR?=
 =?utf-8?B?dGQ3RWVzY1VlUWlxeDB3MEpOQTV3YmdUbVQ5TFliT1lVV2dRMWVFbTZTN0Jm?=
 =?utf-8?B?WC9iWmJ1Mi9hMG83SGxpR2pPRmRGOGt5YnRnSlFWb3BYOWtGaHNhMzJneTYr?=
 =?utf-8?B?MCtZSHp3TzlPY3loZHF0SU80a29Bb1VPNDZCeVdRREcwNDB0NU9tSHdKNzJC?=
 =?utf-8?B?dzV1dW1vbitHQUMzc1h3ZWtPMXl2UnR1a3ExelNPZFZXR3IvU1AxVFYrVjhT?=
 =?utf-8?B?TldTSXRZSlBoWFlDRUhCOHBab0tDRVVmMHo3REQzZFczcGw4eVdNMzJsN1RJ?=
 =?utf-8?B?em1xemtLVXdKVkU0NGl1cHppQy8xaXd2WngxNmJTS0k1YkRHdTB6RWZMaThu?=
 =?utf-8?Q?PiLpFUZySkrCnhNo55fsX1ATQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9b7d59-e654-4d56-2142-08ddb7e5bded
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:52:32.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCbLMAaSyqr0kLrfayKRzI5rfZ5RfTDkDH+Ob2CJhBn2adSRTGLISkXdK1t3Ef839afOFHlE6Lf0gHRGMP3LCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690


On 6/25/25 17:37, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:35 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependent on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Hi Alejandro,
>
> I think I'm missing something with respect to the relative life times.
> Throwing one devm_ call into the middle of a probe is normally a recipe
> for at least hard to read code, if not actual bugs.  It should be done
> with care and accompanied by at least a comment.


Hi Jonathan,


I agree devm_* being harder in general and prone to some subtle 
problems, but I can not see an issue here apart from the objects kept 
until device unbinding. But I think adding some comment can help.


<snip>

> +
> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
> +		return 0;
> +
> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
> +
> +	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
> +	 * specifying no mbox available.
> +	 */
> +	cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
> +					pci_dev->dev.id, dvsec, struct efx_cxl,
> +					cxlds, false);
> The life time of this will outlast everything else in the efx driver.
> Is that definitely safe to do?  Mostly from a reviewability and difficulty
> of reasoning we avoid such late releasing of resources.
>
> Perhaps add to the comment before this call what you are doing to ensure that
> it is fine to release this after everything in efx_pci_remove()
>
> Or wrap it up in a devres group and release that group in efx_cxl_exit().
>
> See devres_open_group(), devres_release_group()
>
>

As I said above, I can not see a problem here, but maybe to explicitly 
managed those resources with a devres group makes it simpler, so I think 
it is a good advice to follow.


Thanks!



