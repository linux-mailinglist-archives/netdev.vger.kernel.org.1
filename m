Return-Path: <netdev+bounces-116558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F6094AE5D
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660AE1C20C13
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5485313A276;
	Wed,  7 Aug 2024 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TthGC3YL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A540B2D05D
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049311; cv=fail; b=s4vk+wu5h9c+XsyCtmEF1n8Wsl/EsYNr6/kqmKlkVt6FtrerUYGV6SwwoQOIFPLfKgpKCigSkmHwRlRL8DniityzV7RFdt/0kNxQLbI/W7Myn8m1wXY+ZvcuGytW4zD0h5GepDaVX95ZHn+vBtstV1o6ibOvyqeM5jm+2wv7kJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049311; c=relaxed/simple;
	bh=/wf9HWiWkKaseNoMpauLtbLkj8rzDljU1MjtOjr6J1w=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uBKKZnJ1MjrEQS7Mhfj3yXHfjTbe5cxjeC4bTCmHwldkRsnDKfR++afNL8ETqdVpT/W1tuYHo+g0bv+D0mGfZjswjiVhDAa9MmO0ngu/xHtLl8OUd6w1C7JUiywv2s9eoKf3Ofk6pkqrSSbQe+sbzSgqpVpH5rMcqx/gcnPzq6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TthGC3YL; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sy29z8sJkSw1FxllkBJmU/AIfCu+LNYickAVNciRE9+e7cfpSh68Zjlh6yxwj3gyooE/5T/rZr7hF1ju1J8dAnccl+N9RWLZ4cLy+VuGkcfJKtib3tO8gYCHCdphZaXOCfq1NcurjoPWWS+1jHDXcOSEAD25zqvLCkzc4pmu+2FdiNoQyqhB8DHknEqigUog6YQb3EDXsQGgPiqK+sAcVVE884J+OoEuEEwrGMI5GeDCznR257uw8bJx04fY1s8sNBlsLaNk/GRwy/e5pqcrOw8uOy3hcK0YTfuhP9G2tTgKg74A84uTFYHxW8gM04RvNLY3h3lcaun3RF8b53Tf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clNS0Nw2HMFEg1dXXY1Ceo/dm0/0QVGWKELrKigm25k=;
 b=FqK1lGfbXzFzfk8JhF2DwoZyVuZGrDboWYLAVxaM7OSbWLwPANbcWbPaKvtxOci3VB5HCvsNO6BRa4aJnJy7xjOyIuz2r7SUi4KzSnCVNSnPgvFfw2COpuAtNqoT7u6Sfv4p+OfWBX7M7VTRZ8r6hzJhJHRqVzaCB7K1mq2GCttLDGgYeTVvZ8guvZDaBtmoTnCWTvD5cDGpPC65ENyAzdkQdNhtlqudACU5p7r4u9ZpTLHaSDUXD1K4pCoMh/519eaRHd6plK7OtCQBYpQFqY4h2QOtX9HsMouMyiFUg/K6PNdaG8YwhBD2OFwLRDkbwGqBcd5iMci9iC7RnQauQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clNS0Nw2HMFEg1dXXY1Ceo/dm0/0QVGWKELrKigm25k=;
 b=TthGC3YL1iw9lIJoAj05RKmnsMRsav8mBdwAgTSBUE8+2efajIIKcCLf5AIkMql7WNi9UxwGAFyzFpAWC0FhKxQ9XYNaS4UPAhvqTjgD/P8HlAiHd2MP3sUfPnSmpEH/a3U2TjTOIhNnGxq6knEuLnj1FtLjF1YjVduQnVnmirOh595+s4gJ8WE98CvWTGFRC20LT8ZvCqqpGsIVFJJuRTcxJhQCqlOXu4GWxJ/i3fCx0ocgSpL0yYITW/XubjAqKqoupI+ooW+euZv/vIr3NdLWeJIpH/RVLEraeXhw/BuxH1/Bm/ZQQPdgYCvbQXSlojrzQ6zyyIgnRH3OE34oLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by PH7PR12MB9254.namprd12.prod.outlook.com (2603:10b6:510:308::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 16:48:22 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%7]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 16:48:22 +0000
Message-ID: <25510215-6499-4c36-89c5-ca2a2a4f4134@nvidia.com>
Date: Wed, 7 Aug 2024 19:48:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethtool: Fix context creation with no parameters
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>
References: <20240807132541.3460386-1-gal@nvidia.com>
 <e5a9000a-230e-4118-8628-b44b682c8d8d@nvidia.com>
Content-Language: en-US
In-Reply-To: <e5a9000a-230e-4118-8628-b44b682c8d8d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00003840.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:15) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|PH7PR12MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 600a902d-d326-447c-4a12-08dcb700bf97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MldTQ1lPMEdZYTVjY2ZseWVrdU5YMFN5ODVwM2xlcExkZDVPZ01pVVhDWUJM?=
 =?utf-8?B?NElDKzRtQnNETkNhcitRQzg4YkVuVGxJOGpLZTUrTWU5SmFDVjB0cUx0UnJC?=
 =?utf-8?B?TVNOQitkdnI0OTZySGg1N1BTVWNDQVgzS2lmZ1VMUVhKV1REblBtMWs3dmho?=
 =?utf-8?B?clMzSlFqMTRyUTFUTDF5VnlNdGlTUFJ2WndlazBUZ1pBb1g4MkhyNEVJVkx2?=
 =?utf-8?B?cXFOMDNLSjdUdHJNQ3BIUkNxcVh3QnRTRmVaMmkrVml4bWxQMi9NOUx1aVNO?=
 =?utf-8?B?U1BvckVma1A3ck9yczB2TTMvRGdObzJpaUl1U1lFTFh1dzZiRlVNdmJpdkFk?=
 =?utf-8?B?SzJRWEM2bWxzTHhDNVVBL28wbEpkOHFPYmY5VURWTDJ2YzR5d25qcE5aSy8x?=
 =?utf-8?B?UkRHZnFoTUtZK0tRSzJmTUdPWC9wWkhOTFh1dERHS3UvaUYrSldFblFRWThv?=
 =?utf-8?B?VnJOUGFWbWgzTXc0ZzlEL2JaUVc5b2hNandNT0lLZ3B0ZVRGblhVNTN5dURH?=
 =?utf-8?B?anAwYlBEMVZ0QjBUa1RJb1JWZW1ZbS9RcERJNngxV042L1VnaStaN0QwS2NB?=
 =?utf-8?B?ejZCSVZUNmYwMDI3dllsdFluSXh5TCtlQ25Obk15S1BDRlJtRmQ4RXNKbWJL?=
 =?utf-8?B?TUQvWVc5VGdRSVkwSnUwOVBoRGxhK1c5bk5kMTM2OVpMV0VDLzlXaEU3WmpU?=
 =?utf-8?B?RVoxRDRueHZjNzlUYWVzRnBkbGZCby92L3BsOTlMUmtBdUI2bEZFbWVWMTBt?=
 =?utf-8?B?UXQxdkFCK1U3M3NRQUcvQ3I2WTh6bkd0dEhKS1B4UU5yb0N2Ui9wRzVYZmND?=
 =?utf-8?B?N2FkckNadWV6cU9vUEJ3OWJTV3BmZ2EyZWZwOC85S2k1T08xT0I1dXBBUVpn?=
 =?utf-8?B?cGhLelExVkJzcHdZNDBMV2FaRzZvYmkybnpVb0xHeC80TFpibmt6UTBmT2ZI?=
 =?utf-8?B?QXpQODA5WTFtUkhMSVhRMTA4QkpmbFNoZVlqUUhCRzBLZC90YmZ1Nk9ZeE5o?=
 =?utf-8?B?TWR4SVo5UlBGdnVRK2Rmc1F6QlZhdUhDZmplcWMwYmVNN1ZDNVkxTFVHNTZt?=
 =?utf-8?B?TkJ2UldjbmNzOW1uOXZsc25DZE42dlRqNUxHUW5CQzIrRytRc3FISTdMZyta?=
 =?utf-8?B?VGVwbHZReEZieDR0ck1ETXF6ZXV5VE9XYTBEV29MWkNqUGdweVFnNXdQWGFQ?=
 =?utf-8?B?Ulk0N1BlRlF0ZUw0Z1NLcFZDSlF3TzNlS09paEt6ajA4VHlsMFIrRWlZMith?=
 =?utf-8?B?VDZqb0YxamM2OUsyMHduNEhOSFVuSklMcEMwVkVpNmMxSE9ad0NmdmRhSSt2?=
 =?utf-8?B?Q1FnTnQ4VXJNc2d3enNwd1NpUDdJTTVLZEx6QU9jZURCSzJyQXYxZVFVRG1Z?=
 =?utf-8?B?R25QUVB4QmxyeXVZNzAvejJGTm0vbVRUY0hQOE5aZkFDbmMzUUlQMlN6OUFl?=
 =?utf-8?B?NHdBblJFOEVaM0pWNnlvV3dqNjlGNHZaRTcxcERBK0MzUWE5MEZmSXFkYlpn?=
 =?utf-8?B?TndJMEk5bVJhV2hyNGxPc2oyMVNhc0dibVVJM2Nyckg2cjYreWt5M0phcEdt?=
 =?utf-8?B?bDdOTVJRZFVNbVdJYUFWV2J5dENLVXlDSlV5ZUV0d1h6VEJKUWJLNys3NXBx?=
 =?utf-8?B?VXYycDR4dnlvUWdsYnNvVk5nL3hLRmhZZEt6RDUwTnNJZTJKdDFkYkVUVEUz?=
 =?utf-8?B?dU1FQURYcVVzV0dZK3ZlTGNUaVVKS1VlYWkwYmw0cFFMWC9SdDljaHNndHFY?=
 =?utf-8?B?NlFFUDArYWlra0lkdmNzNENHbGFEejdRUldhUCt3L3Mrb0dFaXM4RmxWYW9x?=
 =?utf-8?B?cmRZM3ZndW1ST3IvanI1Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXNkWlBCZElRcnByU2VsME5aZzZibm9mMnduQ1plOFlMT0xWa0M0OTNRUFVK?=
 =?utf-8?B?VDF1MW9wdFhpMUU0WEs0K2N5ZTN4U2lpbk54TC9TeHlQaFRkVm42eG5vQ3h1?=
 =?utf-8?B?T3FBcjF0UWZzR2E1bkVzVkl2czBpY1o1bzRubWZ6aFZCOHVDZmJlK3RXRG11?=
 =?utf-8?B?eGx1azdVRC9aWDB4VjdnTFV3ZHhRNXc1NGJhYXY0YXNsN0NIMXAwUjNuczhW?=
 =?utf-8?B?MGE4VGVYNjRQUlY0UDZma01ObGpMcE91c3ZUVnUrb1JTYWJLWjQ5TENtUDVD?=
 =?utf-8?B?WlAzakpVSFlSUm9TUU5JOW83QnBxQWgzQm1Yb2ZYdVJ2ejN0eXNYbVBZSlpi?=
 =?utf-8?B?OFY5ejJxMS9md2M4WTlYWWRzaFBMRkZpN2hZWklnNGZiN01ha3hGSHY0bU81?=
 =?utf-8?B?VC9PVTNOWUdScTVnaHAxeWV2bndseGZPODBBbGpuOFhjbHkrMm5WUXByQXR0?=
 =?utf-8?B?czBwR3BBMVp3eUk1bm5Db0xnZWVWZzZ4RTBvaGlIQmNYZ2lWMklIYjRXckFN?=
 =?utf-8?B?UFJSblVDc2Uzbm5pL2dMZnNxU205US96S1NvUnUxaXczcFd0RzBzU3d1blBR?=
 =?utf-8?B?UlgyaHF4L2kzUWsxbTIwMkJ6SmpyNU1NM0VTLzd4YzlTbkNOMWdWLzVtVDJU?=
 =?utf-8?B?eklheEdncDRNa1UxSzU4ZHYrb0RpSENPQWVpaVRaTWkyZnBOOEN2Tzl5Tjky?=
 =?utf-8?B?SWt4U1BaejFiSlB4OFJ2NmtVNjhYQ1ZBVU1BNWVpRWlTZHFwNzl3N1czaHdX?=
 =?utf-8?B?V0NWdHNuNU1OSGRPQ3pMM2RDZ0Z3d3FJTW9iQkVtRC9TaEpjWWh3eFJjQWJZ?=
 =?utf-8?B?TUdXTk0wZDRJa3hiNHJNOVRQbVdqQkEvSjdJMm11dFE5WTFkd3RGSS8yUjZn?=
 =?utf-8?B?STdvOHdxMXdUVXNFV29RV0dSQVVoZk9lKzZKamVMWC9DallBaTczNllZOXRz?=
 =?utf-8?B?NERGNUFjSWhFaldBSWNidzZJVHVkWHZQV2VTR3NCVS91VWFHdUdONWR4dldV?=
 =?utf-8?B?WSswZnRYUUNRTHQyUjQzNXEza2gwdDNGYjFHS0toOFArUC9TbisxMTZjNm5F?=
 =?utf-8?B?ZmZaRG41OEZIZ2lKTFR6eUhkVUIyUzdGUWloY2Y0OHZDVGVjNXppcFNCREZ4?=
 =?utf-8?B?MWxuY3FzbDYzNjJrVzlZLzhNSnZqcC8wMlFRMzNyRzZhWkhkZUhMeU40Vjdu?=
 =?utf-8?B?eWlPbklIL2hxa0paV1UxbU9WMkxjeVN5ZFAwcmVMQ2lCeGl3R0NuNnEwREY0?=
 =?utf-8?B?N0YwSmZMSkhBb3MwMU96a3NvN1BMUVJKWi9OcTB0OG52VXk1cThKSGRETU5O?=
 =?utf-8?B?dlJZdDdPNXRaTWVnN25XZlB6ZFphSU1rdC9UTUVQd1hSd2NuT1NNbENRcFpo?=
 =?utf-8?B?TUk1TnZJNUxTdm9mNnB4enhvdVYveDNSWTNoelZXL1d0UjFrbUs1TUsvaDIv?=
 =?utf-8?B?NUMrdkpUR0txcklseVQxTjFmdWhLNVpaemNnTXhBdW1XWTFFemNWaVV6MjAv?=
 =?utf-8?B?bzhKTmFsejZIL2xML0tUSEg4Y2N2Znk0Z3FLaThkbHNrL3RYSE83SnpTOWdw?=
 =?utf-8?B?UFUybi92VDlVcWs5UFFQcS9iRDg3d3NtdExJRTFqYWRMYzBOaE8xdDZnU2U1?=
 =?utf-8?B?cnhvUDlzOTh6Vmhqbk00RUN1b21LbDc1aHhtRlJoMkpnMml3OU1KK3NRRzdQ?=
 =?utf-8?B?dmQvb0tVUERTRmxlQU5YMW4xb2E4aVZUam1XNEhHbUg5MXRlRmIzYzIzL3ZW?=
 =?utf-8?B?SVc0OHVLOHowanByZnBaS05aaVdndlFpUU1PVjYvUmNoM0MxNHJZWTRsYitl?=
 =?utf-8?B?UnhsdmV0U3hNRUdOOURNWUtmZjBVazY3ais4RW15Sm4zazFGSUtIU3J4WFFR?=
 =?utf-8?B?bEVOSnNCWFVMS3k4QWtBL3dpUUpSYjNOSU5HUGloNzd2anRPR0pzSnBFcmY3?=
 =?utf-8?B?cjU1cTdSN05MQkg1akwzUmhKZ0tNd2hBRjB2YllneXJ3TVQ2ODBzaThDa2Js?=
 =?utf-8?B?UHFNQi9NamN2RC9kQTFWQVpZTEpDS0poMzVxU3VDYVpLdVJHeTVSekw3N0J5?=
 =?utf-8?B?NFpveUM5d0ZCK0k3TE80TlYxalFqZVVRZStvWkZLVU04eGlaczlFVnFTY1F4?=
 =?utf-8?Q?cqaZ4Ri/DJ6vwCfjyq6vUsIli?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600a902d-d326-447c-4a12-08dcb700bf97
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 16:48:22.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OA9nqPpaBlOqoLUqlUISdyOJgW/fRvc0LnaEJG3sLSHgRx7xV1pVnNAWrK4G74Iu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9254

On 07/08/2024 19:14, Gal Pressman wrote:
> On 07/08/2024 16:25, Gal Pressman wrote:
>> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
>> index 8ca13208d240..2fdbdcfa1506 100644
>> --- a/net/ethtool/ioctl.c
>> +++ b/net/ethtool/ioctl.c
>> @@ -1372,14 +1372,15 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>>  	/* If either indir, hash key or function is valid, proceed further.
> 
> This comment is wrong, the check doesn't really verify the hash function
> is valid. I'll remove it in my fix unless you have any objections.

Either this comment is horribly wrong or it's too late for me to look at
code..
The code doesn't proceed if either indir or key are valid, it returns if
either of them are invalid, I'm removing this comment altogether..

