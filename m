Return-Path: <netdev+bounces-204065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8A2AF8CF1
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05F4FB615B5
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E162874E5;
	Fri,  4 Jul 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="rE2biFAL"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755592857E9;
	Fri,  4 Jul 2025 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618115; cv=fail; b=drYVQW0f6WfOANmrJ0yoIrV1Xi3p8n3/bU27WYk3AJYMiLv4pmqRL2ZUg+z9wvImjoYogBL1f4fT0qnGYDULzztlLZlxepmw3oxE8O1j+XmFMmtw/ysWpyC/8xio1E9zgYmTKQvn4t02C+2L6f+J9a5VRqNFDVZm+EuG6qWreoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618115; c=relaxed/simple;
	bh=tPGiMJK72zbd0RYUB9AiLLKVtsuI0M7cv6KicFNvbD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F7HUMbtGhvIrQN3cBnOhCNe/5X+ZXOsLpM/Za7+1NXp0rZDeOFj6tjWsGfcHPPw1kRmZX6EN8AeXVM7DAcZrURgouZZzxxeaKbs4QMGMzUsB+H6sZ8d1qJiVoPZOs83gPtn7FJEk21xPk68b1uuFNkZnQOWl1U4C3XN7RgPJbb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=rE2biFAL; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcMSU/hOzsr6wzSBuNTfzzWWvVFoEm/axik4XXfgydw7f4/SL4BdaM5qAHtbw2Hw19+jQEdRwikWxlwcxgJyEUjHbzv2YqzVkEGUP7Pv0BFbgmGU4xTeCW9UyGarsQm7m9Y7nLCyM6pgz9/1k/76l7J0dFSWhOw/NJXj7SEIa0D3JNYrZ1Qbg9pG008Lf6x52SBRenUNrLd4nEt8JNGYCdQLpRZm0fKuDdjypnNKI/v/uOmheJEVMzjv62sGbMDqbu640DUmryGyiEenBil1AsUoW9tq+BJvtZhJzuuYpe0yEmV9lZHyv0xY//dlE0r0rPbiYOTPoUPGsiKML6BkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81fGLSLZKRjBx4v8AV0JYs2T++FuSLu8BiKtOpbYHXM=;
 b=OukfDym5yit4OF7ZkaBc08P/+a/cSEUP7IYb20yRppM/8aTDsMingZyso5vwdBt1XQucwSc9n7lXb6s8eHygWtXxtN8WefRfgthCu+K0FsoQu9YgJQQD8Fl7F0HZdhCa5Rf1pkQEId62q3Hef5/nYtmWmvmgc6i0Bsv/3VOtrEzN5Cq8N+fNGC8nNu0gncA8dnR4klEwuSb+HZn0QB3/TMC8Oh8ilEmkS7camO0yql/XbtjY2cRctS9x4s1yUQOxdgnlzhqaNOeqX7GWvf0SroO+BkKZM8qj7x6sySIN/kPKhd2/tisQ0QmDrwL7JZLF4v8h/OmgpUp3mhP3lS5+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81fGLSLZKRjBx4v8AV0JYs2T++FuSLu8BiKtOpbYHXM=;
 b=rE2biFALOV0Yi1rBz8FF1HFpnjtqs9g1Ze3wTInnevyJYiJKkhxQ2kGGolEsny38qr9h3vKSv1IR0ov5cipPRyE+fPnJz3BqYqJZvUFAstV4MoXsSk86NR/+VQq9LfzWhtk5+pl/A7bT35ZQThXGpyQFzLasbxnnah4RKp9TwsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by AM0PR02MB5810.eurprd02.prod.outlook.com (2603:10a6:208:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 08:35:09 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%4]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 08:35:08 +0000
Message-ID: <414cc1ef-0c3a-4228-8d59-6ef29aedc51c@axis.com>
Date: Fri, 4 Jul 2025 10:35:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 0/4] net: phy: bcm54811: Fix the PHY initialization
To: Paolo Abeni <pabeni@redhat.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, andrew+netdev@lunn.ch,
 horms@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
References: <20250701075015.2601518-1-kamilh@axis.com>
 <20250702150216.2a5410b3@kernel.org>
 <da323894-7256-493d-a601-fe0b0e623b00@broadcom.com>
 <b89e3a66-3c98-45b3-9f16-8247ac1dc1f4@axis.com>
 <56cb86e1-db38-43c9-857b-f14bb4a5ecd8@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>
In-Reply-To: <56cb86e1-db38-43c9-857b-f14bb4a5ecd8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0302.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::8) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|AM0PR02MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fde23fc-f47c-42f9-fcca-08ddbad5af37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkMrdjcyZTN0SDI4SHdIZ3hnMkd5NHNSRXdNR0JUell3eXNNdjJFSzdGMEtj?=
 =?utf-8?B?N2lubW9wd3JoaHZjMUJ2cE13K1Q3dFU4MHExeU5sdFJKMkNEbUpWZ1RRUHYr?=
 =?utf-8?B?R2hodFBSYkl3cHJVY2NWamVjRnU5eXM0U3loRUxZUXFqK25idzBNU0xrWTcz?=
 =?utf-8?B?THlKTjBmRjQyeGZibmlJMituclAwTEtoWUJtaTg2STZOU1BVVmJ6aEw5TVBM?=
 =?utf-8?B?SXgvczVBVnE1ZXFMeVNvRGVOcHhodmd3bEJ2SFhzOVRYN2UvYUYrQ0taazN6?=
 =?utf-8?B?SytTZjgvdU54bFFqQllOTm5janl2WFRSaHdXQTZNMnpEMldtSUx1QkMzWkxJ?=
 =?utf-8?B?eU0zUklrdy9NV2J0NkFsdkFjSU1vN29HZ0tCcytRaDJCM0lodW9tZ1JwVi9r?=
 =?utf-8?B?ZklXbXhOR1J3YWhYVGw4WjFvWk8xQk9RMkNGYmhsMHhqUUZPM0piRllGMk1F?=
 =?utf-8?B?NW50ckpJd1huVlRKcVI1UTR0a1ZESy9mQThZUXpPdVZDTGdQU0FLQkJ6NmF1?=
 =?utf-8?B?QzV0WWN1bitwcXNWb2R0c05CajUzdVM5TXcwWGJDNHYrdTlzalBBV1NYdkNN?=
 =?utf-8?B?bjlwdXUza2FINVZ1ZEQwbWE3OU92WDU0NHp4Ryttdk8zNDVqb0JQTzh6TEJX?=
 =?utf-8?B?UXpIcDlYMmRmSHJSeW1jTmJoVGhCaUI5VGZ2SzZwalJBT0Y3NWR0NnNBQll1?=
 =?utf-8?B?UEd3dURHcmNJV1lqSHQwZi85eW1ieTdQWFY1UmdMV3pHWXBKZUNkOUxDd2Mv?=
 =?utf-8?B?L1FxSnpXSGthQVU5NjhnaFIxVzh2cThCdE9KTjFtMWpGRGIwaTdsYUJMeFFm?=
 =?utf-8?B?eHBjcjVFWjhkM2hHM0JRSnRIQUJKS050SitaNS9tVzJzN1BxUHBZVHRVd2NV?=
 =?utf-8?B?b3hTeXQxak9PSCtPdTBCWUQ2d0Fad3ZRbWRRZUZqVyttMDc5dFU3bHFCU3E2?=
 =?utf-8?B?ak94VnI0Rk5ZbWptTlV4T0Vacmd4TUlTU2liREZ1QjlyU3lsaVVYVmNRYW53?=
 =?utf-8?B?N1NhakNuNXMwY2R0SXZ1YWpFUFFmV1VsdkpmUy9iS3g1UjV1TGJGTEdPMDZv?=
 =?utf-8?B?UlRUVUp5QW81MkVHTHRwSVlIQ3RwcVNKOWQ5Rk1KcXJVeTg2UkovSkN2U2Zt?=
 =?utf-8?B?cHRvbGZyUmgyOWRVRmxrcHJsY091NEViS2xEZXNKM05nVXNMQ0tqWWFObE5r?=
 =?utf-8?B?dEZ1M2w1Y3g1ZGUvNzNiTXpnY3ZSZ0Q1b1dWdEt5RWRFcmZQSDlKSlJqTXk1?=
 =?utf-8?B?YzFXcHQwNG1SaDFDeExQTHNRUnZ1WXBSNWQrSGx1UytuUnBEOTJJVUN1VGNw?=
 =?utf-8?B?aFFvYzZGb0s5VnRJNTZlMGowR2JHeklYMS9KUStMZXpPbHFIYTVyWFR0Z3M1?=
 =?utf-8?B?YkpoVFdiZStFMXVxdzUvTjdMUjkyMnRQYTFKQmpiYU5rL0cvb1lVSEJ6OElw?=
 =?utf-8?B?cjdQbktqbjBWK08ybHlranpDQ21lRExiNVY2eVR5d0lhTUdoUlR3SHlHRUJ5?=
 =?utf-8?B?L1g4Q296akM1QjRmYXFXMXd6Tk90U1ZLQm9aR2F2NjNBcUZ2Wk4rS1V6azhI?=
 =?utf-8?B?T2M3aTVtdXV5MmcrOEdjN2FvTjd5Zk5WVXZ4RmFTbXp0L3A1RnFNY2xOOXl1?=
 =?utf-8?B?R2U2Z3ZBT1lzOW1pQS9yN2ZtZ2ZQaFNSTERQNFZXN2VWajlvd2dFTUVhRi9G?=
 =?utf-8?B?RmtRUDQ4U0JUK1YyRGZZTVhrdEtPdldtNERidnVSaGpSTTA1eUI0MC9uYm1K?=
 =?utf-8?B?bFBmWHd5UmZCaThFampYWTYvMnY4a2plN25KVjZFeW9XMWpSR0kybmJOWDJk?=
 =?utf-8?B?enhoRlJGYkVkM0t5VzdVS1Fya3Y5S0N0VVd0YVBiY1RrcEJ3UTkxbVVSV3J6?=
 =?utf-8?B?YnprMXhrNExsZHh1MHN2Ti9kMVNzUm5VN29XT0NhQlJSUnF1cG5yc3R3NFJ0?=
 =?utf-8?Q?Bt1XPHa1Bsc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THRDRFJndU8wUWpJSVVsbTdCU0QzNXVlTXZCMGxKaTEzOHdpOHhNWkR5UE80?=
 =?utf-8?B?bnRXdEZWelVZWlZmTUo5K1V1cGpld2NsWjhBejBObjlyaE1waTVMbW1GZGtY?=
 =?utf-8?B?aU5QVXVaeDNrU1VORWxTZTY3K1M2cVpVRmRZK3V4TktlT091UE1nOFRaanMz?=
 =?utf-8?B?b2RueDBCdmM5NVB5azEwMHFYTXgzS2E0c1poT2ZlQ3F1N2pvM3J0TDRRMmU1?=
 =?utf-8?B?cXl3RDgwajFScnFlVUhCRmRLMVQzY2E0U2s1aDRjampET0tDdzgyREJoTzcw?=
 =?utf-8?B?UmpyaWpma1lNK3VuejE0UFlqV1JUQTBia3h5MlRBbFAxZE1nTE9vNDJWUGpq?=
 =?utf-8?B?OVRmNXJxZkdoTHdCQUwxdzlONnQ2NmxMN01DOG5tUTVWdGlSZDB4ODNFS3NO?=
 =?utf-8?B?dzZLRm9YcHY5Q09rZUhoR3hSeWZVRFNaR0pURWRkODR5b2Y4L1V6czViRFhE?=
 =?utf-8?B?N1FkZ3kyeE5TblpYMnZ6M0hkS0I0ZnVLM0J1a3Bzb1dtczN2dEVHUGZTREZi?=
 =?utf-8?B?TURKeXNIRUZRY3U1eS9uWSsxMTRTY3pYSTQ5T0JUVC9GN0lmbFJJejI2UG5B?=
 =?utf-8?B?SVZSVGRWS1F0Zzc4eUJJQ29LS3o3azRUbXZ2cXNYVS95UHF6bTNoaXBYbmdt?=
 =?utf-8?B?UG9UNjRvWThWMDBKalNBdFNGMS85blI2ZkFtbE9SOWkwaXJINEUydkFuNG4z?=
 =?utf-8?B?dW5BNk4wV2tZbEprWFIzYjdrWjZHckpkTElhcEh0UFQvMTRLWVZmVlpldXg0?=
 =?utf-8?B?K1djZTZ4NXdWQjljKzFJTmJFQzgzNm00eGtHNS9jemM0K0NUZ2ZrdXRGM1gy?=
 =?utf-8?B?MEpIVHBnM0oxWEIrT0QwTUV6ZkZvbzBvbUMrUWhuV1d3b0RUMmhVZVFPZkJk?=
 =?utf-8?B?TDlrVFJ5MEd3Z3ZRbWRmY3Z5bzBvS3VnQlZpRUlZY1pPUGdhdlpnQm1Bc2NU?=
 =?utf-8?B?aVlkRnY2cVMvR2ZLQXpQbUxRbTdRbFhtS0xwUURVR0l0QStESTgweGhSeXR3?=
 =?utf-8?B?K2RNRDZkUUNzcFJIRFpMQlAwRVZPOW96R0NHWGwrUjJJRkJ4NzNhd0t3dWw0?=
 =?utf-8?B?WnhLUElVNEMwdWRMVG8zRUxZR2ZRYXRjR2R0RnpUWGR5SStsaVFLWGplTGp4?=
 =?utf-8?B?bkg5b2lOeGJObXp6NkVUVXIrQ3ZuY0F1a0JwODBxcWoxZDNKTmw1Z2NNT2F6?=
 =?utf-8?B?NmlyMnhFRTlkWFl4bnhsb0hpdzJ3LzJoQWJBQVpXTWR3RkNDUjh3SlFta09y?=
 =?utf-8?B?MHM0OFRSZDR4L3F0cTJmU2JRZHltWjVEd3ZoLzNqQUp3dkcwVTFNSERWYXBV?=
 =?utf-8?B?TE04bzk0dkg2VDBqUTNVTll4UHJVQUIzQjBVZHFwWGlJZXJsWEZXQXIwamJN?=
 =?utf-8?B?bytuZk1XbDhIZDgvalZVeUwvU09jeE9Cb3dmWTg2RzJmSExmQ2NxVGo5ejVB?=
 =?utf-8?B?QzdmMEJEVXdybjJrbmFrcUdzaTgrTDBnMTdGaDRwa1dGSWY1R2Q0RXlMTktH?=
 =?utf-8?B?NFhSdWN2djgvVk1kbldpc0VIRlVqTVFPSkVacGdnUUpLTnNYSHZMSWFrVWZX?=
 =?utf-8?B?NTEranF2NmZMemFVRVhrM2lFd1N0U1F2MTZoWStEVDZjQnVwVytSL3cvL1Zj?=
 =?utf-8?B?QlgrTCt2YmZ5Wk5Cb205YVdLTlIrUjR0SGpmKzhZN25MWXk1ZW1yNzZUWnRT?=
 =?utf-8?B?d2dsVFg5TmFUVmJ1aXdiQWUrSkJzR3RGaTJTa0Q3YXg1TXRaK2VnUEsyY04w?=
 =?utf-8?B?SUxpTmdvakZSMGswRFBqTGJhNmlBdzFWWGQrZEhWSHFpVEt1Ym11dWhFT2R3?=
 =?utf-8?B?U1RTSVJIZnBPdjR3S3VHOXVHRlMzQldBYlFiV0N2d1d3cWcxRERHcDFpMncv?=
 =?utf-8?B?eGliUk5DVUVJUHA3VU42VHdpZHMxd0pwbVRZK2V5RVo5ajg0b3d0Wk9GcFl5?=
 =?utf-8?B?K1FPVVZxUk9rV1BhT21CY0Fxc3I4eGFzRzRDRStDaERSTXVYWkYvMEdOb0NK?=
 =?utf-8?B?TEY2UU1JZHNQajkybFNlOGhqTTdVUTJ4ajN3OGRaZ1Z6SlRnM2hIWlE1MU5k?=
 =?utf-8?B?UmY0ajMrUDl0d2VSblBaOXpQN25XNjVKU0ZGZEdBbUh3MkNmbWo5ZERTbXpa?=
 =?utf-8?Q?CG6FqLVooUbCXTRY8JAORnvj4?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fde23fc-f47c-42f9-fcca-08ddbad5af37
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:35:08.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6i859fJvyg30Sd+xJM/Ut9TQ+PJ2qC1WEoZ7WLjvlLUHxzm5SVNruaXrGw0ijyem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5810



On 7/3/25 12:03, Paolo Abeni wrote:
> On 7/3/25 11:03 AM, Kamil Horák (2N) wrote:
>> On 7/3/25 01:46, Florian Fainelli wrote:
>>> On 7/2/25 15:02, Jakub Kicinski wrote:
>>>> On Tue, 1 Jul 2025 09:50:11 +0200 Kamil Horák - 2N wrote:
>>>>> PATCH 1 - Add MII-Lite PHY interface mode as defined by Broadcom for
>>>>>      their two-wire PHYs. It can be used with most Ethernet controllers
>>>>>      under certain limitations (no half-duplex link modes etc.).
>>>>>
>>>>> PATCH 2 - Add MII-Lite PHY interface type
>>>>>
>>>>> PATCH 3 - Activation of MII-Lite interface mode on Broadcom bcm5481x
>>>>>      PHYs
>>>>>
>>>>> PATCH 4 - Fix the BCM54811 PHY initialization so that it conforms
>>>>>      to the datasheet regarding a reserved bit in the LRE Control
>>>>>      register, which must be written to zero after every device reset.
>>>>>      Also fix the LRE Status register reading, there is another bit to
>>>>>      be ignored on bcm54811.
>>>>
>>>> I'm a bit lost why the first 3 patches are included in a series for net.
>>>> My naive reading is we didn't support this extra mode, now we do,
>>>> which sounds like a new feature.. Patch 4, sure, but the dependency
>>>> is not obvious.
>>>
>>> I don't see the dependency either, at least not in an explicit way.
>>> Kamil, could patch #4 stand on its own and routed through "net" while
>>> patches 1-3 are routed through "net-next"?
>> It can be done this way, however, even the patch #3 is effectively a
>> fix, not new feature, because the bcm54811 PHY in MLP package only has
>> MII-Lite interface available externally. As far I know, there is no BGA
>> casing available for bcm54811 (unlike bcm54810, that one having both MLP
>> and BGA). Thus, it cannot function without being switched to MII-Lite
>> mode. The introduction of MII-Lite itself is clearly a new feature and
>> it is even (theoretically) available for any MII-capable PHY. So if
>> putting it all to net it is really impossible or contrary to the
>> net-next vs. net selection rules, let's divide it....
>> To get fully functional, bcm54811-based networking, all patches are
>> necessary so any other user out there must wait for both branches to join.
> 
> The above makes sense to me, but I think it would be nice to capture
> some of this info in the cover letter - the fact that many people were
> confused by the series is an hint the info was indeed missing and required.
OK, tried to write more about it
> 
> Please resubmit with an extended cover letter, thanks!
> (unless Florian jumps in and explicitly asks for something different :-P)
> 
No such request appeared since yesterday, so submitting an updated text 
version

> Paolo
> 


Kamil

