Return-Path: <netdev+bounces-226631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E117BA33A7
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 11:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725DE1B286AF
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 09:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BAA29B8FE;
	Fri, 26 Sep 2025 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eLA1QCoo"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047C29BDA7;
	Fri, 26 Sep 2025 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880056; cv=fail; b=fK+AxEbZ+92j7fLEJxjlA9oW/ZtCptOKohJpvyjaifl+mFaiou+N3Eno28v2WO/jZNqMRhIrtQF3XECaJAj293/y6KfaAlIt/DcV+cVEEfvxXlTnQxAcMQQOBI4p1WV0m+pmzyeGgBVfxeWVUGvfNqKD/+WZa1MU38TtmRux2qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880056; c=relaxed/simple;
	bh=P2G+bEJhMefxUVnp4XmzgLZPE8Ic8bxCr11D3KqNzNQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BeGKbQ3RJlq0O+y05dDEaEFK68Ax3qdw4crAmU3NMQFIDBjC7OFUdurw5MKd2vinZq6hHp+s+N4otB5OCrV6evkl8DTz87KNYcA0V4CYclM2mbpH0OE+4iY0eisgGMeuPoumENRvG4bZO8rH6uFcLYc08lHm9M7wMHgQqWUckQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eLA1QCoo; arc=fail smtp.client-ip=52.101.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cESTCZdU+6UezOtay/2S/hf/FNbBirPw0PQ+pxjXxAlQme5ZPqXqc4121+gP5Jf9HPJl5YBQPD+vinti8mlmeJnCVdcp9uxFgYUJEQsnFIsqwZi8MEVJ90xXk7kQLvdntDrYbpcbdvvvCAnqEEM9D2bko5Xa2H7hUa0XyLtSHZDNuuhW6/oxpukfXyyIKMf0GeX1iSRU14A1WMmWna7hSY5qC10JbFxGgy+V6plIo8JgCRP+S70fj07frjvxh825G0H5zzvVrbW1bFe/5aHE1YbtoduxfQulmzDL9VHaWWzVgh4RkndzHMBvoWWeaX+sW3DlV7BrDsKu6o09Plapvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVhFkzVSyohZOnmJNYXRAQCYiqU6Z9S9b2CbDpN1c+A=;
 b=FzCTaJW49MOyN0dZYz0v5TSAtssj5lGoGK2bSkWCW9jpAuuQPapsEigl2eILLQiVX6Q0Q5JXufc3jBlIEb3b6k/9ah5lKSOxQaEqNT8NIGWEt+HVWhqrIKvivgUZ0P1jDFofrSLA8FgzG5OV5b/XX3nFLVlJvsHF5Dk3iWXkUdxVrMNBWqlrgCNJWWvSbEFfRhNYt6zapZaPrroCjU5iM6L4LFjgtrLElJsv2kmmmYdZd9YWwApJRxcvKtRmFWV3/RoxXjLv6IF75EQHGdtkri6ZnRJZsZbYfuIQmrafPUAbiW+WenzzE2k/KjtDp3+AQ4pDR8HfGPs5ZUUsUwBssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVhFkzVSyohZOnmJNYXRAQCYiqU6Z9S9b2CbDpN1c+A=;
 b=eLA1QCooofLk34+fR3TaFxbI6Y6upRkos8YByTyGhZVltRam28VBRpD8YtOiiqn7oftq79kMa/v1hsxP1Vne0/JNZ4hBa84c50701IPmwlKUEkXjMKpD0qFGxgY6DE4GUdMGji25cR9F2ncydYQLwJtx54InzEYz4w4NHwQa07k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 09:47:32 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 09:47:32 +0000
Message-ID: <26134b86-1481-451f-9337-70769ec9e792@amd.com>
Date: Fri, 26 Sep 2025 10:47:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 20/20] sfc: support pio mapping based on cxl
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-21-alejandro.lucero-palau@amd.com>
 <20250918160832.00001ed7@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250918160832.00001ed7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0043.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::31) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: db297b46-7495-4eb0-39b2-08ddfce1b6c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjJPbU1jem90ZHY2alcwMktId3Njek4wY0lLby9RNHJvSjZ0RWc2UUpkZ1FV?=
 =?utf-8?B?TXFnMWs5ampkZzZkTjREa2Y4Um9uMUowei9iWFppdktQZCszNkl4Y1VXdFlu?=
 =?utf-8?B?VmhWZ2d0NmZjT3hZWlR2WVBraHdGRWY5eFJFZlc2VDBvYkREQUVDeHBGK21T?=
 =?utf-8?B?WC9mWXJCSkg2SDdVMlVaRU9BVlBKOEdqcnFjaDRnanZQUjN3SnM0RG8wQXNj?=
 =?utf-8?B?M3NIWHMyb3dFUFo3aTRraTdjS3ZhUWJiWm9acUVPQ0Z5VFRabEViemsreTFG?=
 =?utf-8?B?TWRaMGc1dEltYU5IT1dGVVEvSnU0ZHlrMUI0SHZiMzRTY2pxMDV4Y2tPdUxz?=
 =?utf-8?B?djFtTWp4U3hqK3hEc1dMdDg1ZzFRdTJuV3NqRURpV1k3OWUra09rZWF2d0R2?=
 =?utf-8?B?YWpMVXZyMENlSEdoQVZ5dGNBd3NmYjBmdzRHY3JKSGVGajZPc29LT3NqUEF2?=
 =?utf-8?B?Z1E2cjUweEpqNHh5MVZhVUNId3h1LzlhYTREc1R5V2YvRlVYT2UyaVlXNHhj?=
 =?utf-8?B?RXFCVFo0endZQ2UxZlFZRGlnVU9YSnc5Zitqd0ptMTFOSzdPUUkvL21YMXZ0?=
 =?utf-8?B?cjBVM2N6Y3U3ZXQrSUN4RWo5bjlJM1ZKRW1vQ2pKTll6Nk5pQnhDK3g1d2ZV?=
 =?utf-8?B?K0hGazdYUWJoZHdmL0p3Vy9NSW9YY2diMGl1K3lwaHM4ZnVLYU1hT1FRb1k0?=
 =?utf-8?B?R05QK2hTWDJ0ODFidDFMcGZucDJ4a2VzaUd3anNVYTFaWk50bmNsd1Nvc0ZS?=
 =?utf-8?B?UkExYUJSZ0NTV3pjZjc5R3RzcWppbjFlc01IbnBjNDJVSklMeVBRSHNvSHJL?=
 =?utf-8?B?cklBdC9LazJOdU5NWDRqenBheDk5TnBmSm4zczhNYjRzUGI3dTZPTnFLS0VX?=
 =?utf-8?B?WDAwUGRSV29Tcm9MSnprZEp0N3B2Wms3NUZaeHVpSU1qRi9iVm1LdG1DL2RF?=
 =?utf-8?B?YzNZRmtScjJ0aUxUdGM3MXZhUFFYQXJGMlQ4K3RKN0didUd1dUNsMmt2Sk5R?=
 =?utf-8?B?aHFUQXpmY0J5aFlqQ1hML2hnZnhtYU5EQm1oaUp6OWt5d2ljdW12VVE1K2Fs?=
 =?utf-8?B?V011UDUySTVaZnhsb3JtQ1pianhkSThUNms0TjVCOFhQK1hzek1QNzZ6OGF2?=
 =?utf-8?B?SHRDUk0waFdZa0Q3TVNEd0FJSXo0NDBWRmVleEs1VktEQzk4WDA5QkdFcDNW?=
 =?utf-8?B?MnR6R0xoL3djd1crcytldjFYcDlpOGNvOTByT1A2SXROUUhlQ3Z5MjRuOUZZ?=
 =?utf-8?B?WXlXRlFySEN4Yy9QejNxaVljQVFoL1NNcXJObFZkdG9mOUpPMXFWQjVPNUVL?=
 =?utf-8?B?YytaNS9MZEJYb2Y5M3A1aDhuVHArM1Z0TENERkpxUkxYeUNDbDZrd05Pc0Fw?=
 =?utf-8?B?eC9LbmlJaFhYZzFRNTl0ZmxaN1JoKzcva1dPOGg0ajJ2ci92QloxaFBxdVBT?=
 =?utf-8?B?WTAwcmpZejVxeEpXNXVaL0VpbENXMlhNQkQrNVJkb3pJWFJOV1RtRzhnTmEr?=
 =?utf-8?B?R2ptRHJRTFczTTNPTFZYSjlzOFFOT3FGd1dOQ3NteTd6M2FaVjFPTDVXdGgx?=
 =?utf-8?B?cHlTMzIreloxbWNjRGo3KzJvY1NNS1BiRFdJakx4UDZZMElobVc2RS9wQm54?=
 =?utf-8?B?REppZWM2QjMxbldGV3NXVjhwTzRnT2NTRHVkSFdLelF4T2E1NHp6RExWcVNj?=
 =?utf-8?B?R2xXTVFJN0VsY3hVbTBoVjhNTTZObUJOdDFYVHh2S1h5UWZqMXh0WEdOUHZQ?=
 =?utf-8?B?dVhhMUtRYUZwMG16ZUQrbWs2SExrbVlFcjN3SGxlYkVETUw5VFFpRzhjdkRG?=
 =?utf-8?B?d2lHNm5vcHl1aU9tZHE4MXlBbGFMWStXNVk5TVA1eGNaOTJPZ1VnRjAyaGlo?=
 =?utf-8?B?QmZWMjBjQVdsY1FYRFlsOFVvRHdsbVBMdjFlTmdlOC9GTklQZC9lWmhWcFk2?=
 =?utf-8?Q?/aR+5o12vPhAckNxmPH6FKRFMAcezLNv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTVPd3pvZUlCTmZROUlzd0cyQ0dWYlNGUFNCMDVTTk85SlYzbHBEbjlaQ0c1?=
 =?utf-8?B?M25BRUpkeElaTERTVjVoa2FGcmFYOVF2RUJXUE9sYTZ1dWdEbElYT0xrZjZQ?=
 =?utf-8?B?dmFlTmlyLzdEakJlTjU3UWIrOEZxOHdLTVlCSFpBK3loLzc5QjZEZ2VFU0Rq?=
 =?utf-8?B?WWJzd3FFL3Y1VlpMSm1pMGRzcWh1T0RjWW1vbGYxR0UvVFk2UHk1NVZBRHJC?=
 =?utf-8?B?dThnemxWaTRXOTZJVVphV0ZzT2tWUTlJb05zSFRGVm8vWjdLczBZVDlra3Vt?=
 =?utf-8?B?akVKVzV2dEN4c05BZkFmamxZcHREb3ZjNkVLZ1dTbEtNTnprWEZ6Q3plQzZK?=
 =?utf-8?B?Y0t4Sk53Sk9PbkJxVmNTbWY4cUc5cnpEOEJzMWRGU015TjI3ZXFibG5yais2?=
 =?utf-8?B?L09XYkdQelF1TnJYNnJtVTIyU2dmSTBiS2xZQ1VRcC9UK0NubUhmSUFQVWsx?=
 =?utf-8?B?am8vQ0VHSG1SM3p0K2NHUlBvRnM5UkpSbmcrOGpOUlAybmNLS1NQak9ka05j?=
 =?utf-8?B?d2lGNlp0RUZ2aWFPbTRBd2duZGZhemE0STYzVm9XOXROWnB4c0t4VHF0QUcx?=
 =?utf-8?B?NXEveUxKc3cwTWRKUFJKdTlmbm04eFJPMmhnSHlaeXduYytjZE5hSWYySVBZ?=
 =?utf-8?B?YUllQmFCNTdNalcrZWhjK3lTRDFidXlwZTFuTkpNL0d4bGRpTkMzWnMxMkk5?=
 =?utf-8?B?SURYbHV2VHNSWDJFV3V0QzQ0MGZ0V3JsYmZUSmcvQ3J4WUQ5YW94YjRnWGJR?=
 =?utf-8?B?eEw5cS83SDd4dVJIVkE0UExVMU9YN1FaUDdUeUszUkgzNDVBNXhmSG0rTC9p?=
 =?utf-8?B?dk9NL0FXSlJhWHpTVWNGVWJQcWk0WTAyTDZpV1lVdW4weGxkMmsxemVFT2hW?=
 =?utf-8?B?SUd4ZkRqRHFDWDRpV1JDb25wT3Fzc0lsT0xCUzhVTHVtZWhWQnRlbkJGS1Nn?=
 =?utf-8?B?UGVCUjl2dTNMdHhwYTVGU3JqQzBrTkRaczZ3MVJPYkwyUEZtUzg5MU5GTVhU?=
 =?utf-8?B?Q2wrbGJzNFZ4QTI0ai8rRTljVFNCeFY4UnVpMWJKd0E0cU1Pd1pCU0JKK2Mw?=
 =?utf-8?B?dmU4dXAwUXZ4eEZQQzFQU3dxTjJJYTRKTnF4RlUwV2c1bFNBTFpubTFwZU9l?=
 =?utf-8?B?WE50T2FQWlhmb0FBdWxPMmNlVDhyRXJyQ3FxVk95SmdBRFg0WDArMVVkajBK?=
 =?utf-8?B?YWFPNUlOZnZrZURaMUVreE8zMzFlL1hyMUFrNzZTeGpBKzB1OXh5YzMzZXZw?=
 =?utf-8?B?b1IxNnVPTzdWM1NhQ3M5N3NZRE5zVFNEVTQ0azQ3L04vTG5QY3k3UFJvcTJp?=
 =?utf-8?B?U3BFbmpCOHp3N3JmRy9zdjcrSUtVNlFNanRUYUt3NXRlc0t4aFFFbFFldjhT?=
 =?utf-8?B?RHFpTGw0T2lVQ01ub0N5MlZMOGNnb3FXalA4R0FuazI2VzFQQ1JuSlBGYXFX?=
 =?utf-8?B?Tloxa0JTalBSRGhzWlVURFhlc2FaMDJJbE1UZkJaaG1TaHY1ck1XanB2ZE5W?=
 =?utf-8?B?TURBOTdUZ3BiT2pQd1ZxVGtOWmlIbkdsMTdPR1JGb0ZJeHJ3NngvNmhlNnkr?=
 =?utf-8?B?OHlEQVVFYUJBMFlkSk4vaE8wV3N4YzFwVDFTVTBXV2ZydGo3aXRjem1ETnZK?=
 =?utf-8?B?QmcxQlM4cUJHR1hadG1tZ2ZNWnFBT1ZxVnZPMjdmeFJ5VnVJcU9jbVBuTzVt?=
 =?utf-8?B?dzdMbVVTZHpFYk42VGg2NlBHNXBuYXhDWFVJZkJQaTZyMkJmKzY2dStmQi9R?=
 =?utf-8?B?T1RzQkZubkpNcnhrMk9XU2ZRSjI0czRiYVNLKzZ3UjlZKy9YUXhRUW5yNjhn?=
 =?utf-8?B?cWtOZVNJOWFnVmo3RkVXNHJWb1MybTdIR3VYWjFNUk5JUU11OHZHV29JSEtN?=
 =?utf-8?B?Zy9CSTlIOGl5Y2czSUlLYm5TRWxGQ29vM1F1d2ZTTlcvQjlIN3g3UmF1V1Y5?=
 =?utf-8?B?b3NFQ0V5Z3hwbFFQeldnZ21qNHk5ekR3NDloL2FzazNaSXhjRG00cWJra0Vu?=
 =?utf-8?B?cHlFUVUvcWNLYTRkd2F3ek5YTjczMlhZY2w2U1hvSmsxNXBMeCtFZjJ6K2V3?=
 =?utf-8?B?cWk2NmllYkZtNFduU2MxdXhQNnZpRHd3d0FIWnMyM1lSN3BaT1FubC9XMG9q?=
 =?utf-8?Q?t2mEjrw8fzkpqatPahxNb6WtF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db297b46-7495-4eb0-39b2-08ddfce1b6c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 09:47:32.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWF5Hvtlcs5agOrM3Z1jrLrhFPuzJU62rcEvhzjhoMPbXtzy66KkXIo7drzNOFhfdSVWzN8qbmGngZoZKtrhIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305


On 9/18/25 16:08, Jonathan Cameron wrote:
> A few trivial things inline.
>
>> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
>> index 47349c148c0c..7bc854e2d22a 100644
>> --- a/drivers/net/ethernet/sfc/ef10.c
>> +++ b/drivers/net/ethernet/sfc/ef10.c
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 85490afc7930..3dde59003cd9 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -11,16 +11,23 @@
>>   
>>   #include "net_driver.h"
>>   #include "efx_cxl.h"
>> +#include "efx.h"
>>   
>>   #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>>   
>>   static void efx_release_cxl_region(void *priv_cxl)
>>   {
>>   	struct efx_probe_data *probe_data = priv_cxl;
>> +	struct efx_nic *efx = &probe_data->efx;
>>   	struct efx_cxl *cxl = probe_data->cxl;
>>   
>> +	/* Next avoid contention with efx_cxl_exit() */
>>   	probe_data->cxl_pio_initialised = false;
>> +
>> +	/* Next makes cxl-based piobus to no be used */
>> +	efx_ef10_disable_piobufs(efx);
>>   	iounmap(cxl->ctpio_cxl);
>> +
> Avoid extra white space changes. Perhaps push to earlier patch.


I'll fix the spaces. Not sure what you mean with the second part of your 
comment, but if I understand it right, I think those changes should be 
added in this patch, just when the final functionality is added.


FWIW, I have decided to drop this driver callback as Dan did not like 
it, and after realizing those Dan's patches this patchset relies on fix 
most of the problem this callback tried to address.


>>   	cxl_put_root_decoder(cxl->cxlrd);
>>   }
>>   
>> @@ -30,6 +37,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	resource_size_t max_size;
>>   	struct efx_cxl *cxl;
>> +	struct range range;
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -133,17 +141,34 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   					    &probe_data);
>>   	if (IS_ERR(cxl->efx_region)) {
>>   		pci_err(pci_dev, "CXL accel create region failed");
>> -		cxl_dpa_free(cxl->cxled);
>>   		rc = PTR_ERR(cxl->efx_region);
>> -		goto err_decoder;
>> +		goto err_dpa;
> Why do we now need to call cxl_dpa_free() and didn't previously here? That
> seems like a probably bug in earlier patch.


I think you misread it. We were calling cxl_dpa_free already, just 
moving it to a goto label here.


Thanks!


>> +	}
>> +
>> +	rc = cxl_get_region_range(cxl->efx_region, &range);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL getting regions params failed");
>> +		goto err_detach;
>> +	}
>> +
>> +	cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
>> +	if (!cxl->ctpio_cxl) {
>> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
>> +		rc = -ENOMEM;
>> +		goto err_detach;
>>   	}
>>   
>>   	probe_data->cxl = cxl;
>> +	probe_data->cxl_pio_initialised = true;
>>   
>>   	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>>   
>>   	return 0;
>>   
>> +err_detach:
>> +	cxl_decoder_detach(NULL, cxl->cxled, 0, DETACH_INVALIDATE);
>> +err_dpa:
>> +	cxl_dpa_free(cxl->cxled);
>>   err_decoder:
>>   	cxl_put_root_decoder(cxl->cxlrd);
>>   err_release:
>> @@ -154,7 +179,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>> -	if (probe_data->cxl) {
>> +	if (probe_data->cxl_pio_initialised) {
>> +		iounmap(probe_data->cxl->ctpio_cxl);
>>   		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
>>   				   DETACH_INVALIDATE);
>>   		cxl_dpa_free(probe_data->cxl->cxled);

