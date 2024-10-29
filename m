Return-Path: <netdev+bounces-139806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC559B4411
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AB11F235C2
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 08:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DE820125B;
	Tue, 29 Oct 2024 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="U1T6X1Yx"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4541D5AC7;
	Tue, 29 Oct 2024 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190165; cv=fail; b=OxwGrbLeMPagGEZaxWfP5iukKXU5g753OuwkMvbUA73C9BxHxURfG4kEi670O/Df/HbNpuu0wd4j/RsZ9Y06gY46flIYiotkl24xL1puaaRRbhq48x3tyjvBnXJKCJ0kMchOt3KTeXgjmFiwhXPYzXank1UTVn92ZsBxu2VUTTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190165; c=relaxed/simple;
	bh=La7uYPjW5wVeik8Pkpo5cTEfLUUf8EVpjP9r10Y7vyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zh2W1IcvR+Zr8lmFLqmsxmxVUXCYpPC0a0u0RbBtem2gDzsQkzcf3k3vuIMXtrlKVdDIF5fT+jPzy2LXUSdABnj39YFtCcEIy77kzmgnjO2nUeHTCgiZ39+ODng13umZjNuL1+yoWDMGvpeCRsjD9GPOkmnGFzdCSSYqdk5XOSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=U1T6X1Yx; arc=fail smtp.client-ip=40.107.117.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfwgKJk7kRKGUUrGwIUabPgeGPKrl8RjkHlvGbsSZ81R/hhBO6Q3BBlJXHDEN0nwLGTj2gGO8PTSAhw+ZHS4sEBc/VQ8c3jZCc50sPZUq+y01OeVm/4QRJB7AsTbgdHf7zDqePxa5qQt2MbDjgMSP9R7n1CGpItp9fwjYSXNevAHt22aMtLpTaBdy6IrwxhKb9q2P14OvTJEYc4D8tIwBgQbhO4YaDVQnN1CI3Df1MjS20p8i3yjxkjBN7MC+QaqvtwIl/s/DtvLGCl846x4PT7HruAAdizPPL8zeYMvn+Jqkpw6PTd207NJAJIAH0uvAm+0+QfpnIIFMs9bxb031Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2zXkB1k96f0cFV7oh8D3tIGindJppO8RN6kzrT2aOQ=;
 b=vDnn9aYNRcE81y/KCrJauEgWCErnoQQrDuo1CmUae0tS9ncOdWx24Qn8XL/NHaE8gmfCv7Ozxf1XuKeGk7bAtqDOxSmIQifEbA2dn3I676UgF9lXxEYFwMHZkULcqrsUM55QzAiRlPZBg7u8sGwCh/nx5uMAAmPzHD5kIg+3NBpb8E4Tp4TIzk6zj8B1JAEGOxr9+1PpVTq48UeGG4Rkq1b3v5F+/pcpzMHgHoIjfAjg5Q9ex4+i+NseogfrckHVqks+AbbNO6L4TxmzAehOyzTvN65SeEqIS4/5Lms/Gpfnd70DZZv6TouOToSg0A7WmGox5Mpz9y+fRFy2eYaBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2zXkB1k96f0cFV7oh8D3tIGindJppO8RN6kzrT2aOQ=;
 b=U1T6X1Yxswd/4a9x0FSCFcaJoc+jlaFPKBZEDg8bikYR66vqyzZZlsDh2M5A2zTmNwiJUen2T4yldarEFW0mYZQB393gUrjQ5swOBTBNQhdhYYmjSANnVLqxPskQqxM049ehkxzllJjrLwGqrhWPAoflQMKPZDjpWQk5ewVGMoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from SEZPR02MB5782.apcprd02.prod.outlook.com (2603:1096:101:4f::8)
 by TYZPR02MB7008.apcprd02.prod.outlook.com (2603:1096:405:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 08:22:36 +0000
Received: from SEZPR02MB5782.apcprd02.prod.outlook.com
 ([fe80::4843:bf84:bd17:827e]) by SEZPR02MB5782.apcprd02.prod.outlook.com
 ([fe80::4843:bf84:bd17:827e%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 08:22:35 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: ryazanov.s.a@gmail.com,
	Jinjian Song <jinjian.song@fibocom.com>
Cc: andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	helgaas@kernel.org,
	horms@kernel.org,
	johannes@sipsolutions.net,
	korneld@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	loic.poulain@linaro.org,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com
Subject: Re: [net-next v7 2/2] net: wwan: t7xx: Add debug port
Date: Tue, 29 Oct 2024 16:22:18 +0800
Message-Id: <20241029082218.10820-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b3aab30d-7c9a-451a-aea9-6bba72fe986d@gmail.com>
References: <20241026090921.8008-1-jinjian.song@fibocom.com> <20241026090921.8008-3-jinjian.song@fibocom.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To SEZPR02MB5782.apcprd02.prod.outlook.com
 (2603:1096:101:4f::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5782:EE_|TYZPR02MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a52585a-7e8f-4160-e9ea-08dcf7f2d7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0V5MmQ0eTgwd0NINzBjRldRZlQzL2g1a2k1dTd5WmQ1aFV4ZVJLZ2Z5MDZv?=
 =?utf-8?B?QjNxNWhBU2tnSzRkTFJLeGlKUTdJeFBMMTZHQ0JNZWlnUnhndTF1cGUvVUlU?=
 =?utf-8?B?N3JMbmU4Z3V4TnVqMnFXeEdXcW5LaDhjaUNKNmZTWFNnZnpHbDdQMWsvV0dz?=
 =?utf-8?B?SElaLytBeWpabXA3Q3U0alVOMklwVURpajlOYnFFZGV6Z3dIUHFnQW1vTHFT?=
 =?utf-8?B?U1hwK2VGREZuSUlLd1JZRDVtbFQzb29FT2JSQ3V0NDFhdjkxNEY3VG5STXhU?=
 =?utf-8?B?a3F4T0NtTmh0MDVOQWFpNVJWVTFrbFFodnhlVE05Wk1icEk4TE1NVHlzcTdM?=
 =?utf-8?B?cDZGN3dVWk1YYndyS2hVRHdPZ2NWa1hOLytqQmRjRGVrYXBZUURpNk1rbzZV?=
 =?utf-8?B?bDAzaSt1S1lZWlpWRzIvVHd6NkF1ejlFaVZHcW5EVkJHZTZIQ2c5T24rbjVj?=
 =?utf-8?B?TWNvZEgwZE95OU5VYk9TeDU5dWVIYUJBMHhuUERGbFZEdU5jTTUwUkZ1SXZa?=
 =?utf-8?B?S3BEcE5xNVBBZjQwcDlzRkdLNG1FNWdWckFCc0VXQmF1VFl5WS90bkVZb0o1?=
 =?utf-8?B?WHBsYUpJc0paWUVQejdVdFB1RXVxbEptL2srNDgvNVhRZ3l0NFFhZTRoQzkz?=
 =?utf-8?B?aHFCUXB6QlNldW5RbTNKMTQwaGdHYWpzK2Y5ZjlHVmlpcyt6ellpVjJKQkg4?=
 =?utf-8?B?OEFZaEU5OEt6TGlyWWQxdlhDazJabHpEN3lsdFF3UjBocTBkWSt5ZlhoUElW?=
 =?utf-8?B?WnVzS1JhT1Y5a29pWFJzK0JGdjhiNCtaS1BtWG1YUlkyKzN0UmlreEdib1I0?=
 =?utf-8?B?b2g2YTdkNDVlSDN5M2IzSHZrTDJkUjVMWkwxdWpseVZXMHZaTitqT1ExQzJi?=
 =?utf-8?B?bUEyZzQ0cnNVVUVIMDVBb1I1U1FmbVI3WjB2dFhhT3BpSVdFSHVCcnV6dzhH?=
 =?utf-8?B?Z0oyZDllZFg5WVZjeVM4ZFJqOFRnbHM0eEZnZXIrWlJqdzVDdUZ2SE1XUlpM?=
 =?utf-8?B?blk1aUxQWWlOSUxWVDEyY21OcXh1RUZGSUtGV1hDSkZsTG5CcmFIN3A4citq?=
 =?utf-8?B?ZGptVmZGVm9FaWVPUVA0NmdZbmcwdDVjSFhyTk5icjAwTjZwNWt0REcvN2lR?=
 =?utf-8?B?WnFOWVkrK21ZeXNJUWhCeFBzZFFQMkFiMzh3R2Q4QVY2dzZqQ2VnSHFmeFN6?=
 =?utf-8?B?S2o4ZUM4S1BpRVNPSnhZMXVPWUFwa2tCNitKS3hySmJwQXFwcWRvTjJnRGs2?=
 =?utf-8?B?S1UvZjVqRmwxTXMyRXlFR0YyYkowY2wvbTVOanFaZFpaV3FWUWxRSWJmalhZ?=
 =?utf-8?B?QWYxUldnVTVYQ0lQMitxZ3VEUFdNWWVuMWdOSE43QkhnclMxbXZ3MUlNWWhR?=
 =?utf-8?B?UVdsZHZrdmIwN3NHTlpIVFRmVjZUTHBoK2hPamZ0VmcremhFTXFLb2xXVU1C?=
 =?utf-8?B?VW1hWXBaOTFjREs5U3dnVnc0bmdQVEVXcjJWNSs0VGsrUzBwanVyMTByNUwx?=
 =?utf-8?B?SlY1dFpNZnJ0TU5wMFFwRWxzTFJkRmRkQStjMUlvS3czRG5HSUprTWNIWDkr?=
 =?utf-8?B?QkRSZzd5YkllMjg2bkJZOWIyMWNWWnJtdmZQOFlHbXFsNTliR2dmdk5sZXd1?=
 =?utf-8?B?cnVIcVQ4b09XOXEyeWJSenVzSGxMZEREZjF1VlpuSnpkR1lPS1Z1V09yVWZF?=
 =?utf-8?B?M1JBNVI1bTZ5T1oyMVI1R1R6bkdWUzVzREtIaFdsQmJ1elRCNzI3OTFIeEdH?=
 =?utf-8?B?ZEYwT1gvVXZ6dVVseDV2OTlSWkRSUHdITVBoMitBeEt5VDZDd2dBeE9rVnVS?=
 =?utf-8?Q?InkDYq4ee7AngyqlYffK+DoeBSyHMTbGaDXoA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB5782.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0N5TzBaTFlXVG5NeDlHQUpRem5tYnRjT0xVZ1RCc1hUeElCN3lMRTBvM05W?=
 =?utf-8?B?SSsxb0dYUE5oT3FNWGhsS002eUg3djdUa2w5SmZKMnc5RFJNK3B1bHpGMnJD?=
 =?utf-8?B?Qm13R3crRUcyN1UzY0FBQ2J6WnVvWm1Dbzl6REVobkk4alFiUmtpdzBOWWtG?=
 =?utf-8?B?VUpsVEZpV2JINHg4cGQ3dnhuYlNWVVJLQ2pJYjI0YlE1M1RTaFdsZGdxM2dB?=
 =?utf-8?B?WXV5WUw5YkhXdTdwdC90c21DeGRNOEZxL1dYazhaamtJa2xONS9rb2EyN2VX?=
 =?utf-8?B?TWQ1a2lGcE5JaWVUUm9yMy81UnA2NWtLaTVBejJoblFRTG9LNDRyelRYZzBo?=
 =?utf-8?B?b1o5aE5FSTgxL1pWSnZXdlp6eHI4NEZtdUpkMTR4aVBjbDhYSmJuQTZzclFU?=
 =?utf-8?B?NC9HRTVqOWVTUTB2eFkxeFZvbThBQnZZNjZ2aDJNVDd6RGhtYjRmdkFiNGtZ?=
 =?utf-8?B?WXNjSytjN2tYSmlheU9haHJCV28yK09RbWhYUTNpMi93RUgxRnh4bmhOOFkv?=
 =?utf-8?B?aWs2UGRFcmZ0VkY4eHl6K0tPREJhQkVjUGhRQjJiMlY3cFVmNjJzdlRmSnBZ?=
 =?utf-8?B?bFFnVW10M3ppQjdkNEtKcWVTQUx0Mm5zeWNsdGVFZHgzWkNMVmk5NUdwazdn?=
 =?utf-8?B?L0lOWlVsUWRtNUlaV2NoT2tXVWM0NXU1ZUlNSjlRTU1lS3lCbnozQWZFV245?=
 =?utf-8?B?N0JoWTM4cjg0MG5ZVHFLamUyT0tEVENUWldLN2VydTE0OHRjSzUxdEFwaHRM?=
 =?utf-8?B?UU9iendDOUJIOWNBSUxGOFhoWXk2WktwQTRUYzQxZ1B4ZkNEVUh4c29zQldi?=
 =?utf-8?B?NWY1Ukh1eUZlZ1JjYk9vbjZkRTB4TU9Fa3gxY2JGd1R2U2c1ckQ0Z3F2b1E0?=
 =?utf-8?B?eW04MWtNaTZkUDcra1ZjVENHTjdsZTFlV2R0alVHODNaVVNyWTdHU3AxZ1F4?=
 =?utf-8?B?ZXFQZkNGeTkxTC9VZjFtdFNXcmpQUXR5U0NrNzhueEVKSE4vMGl5TkF2ZGNF?=
 =?utf-8?B?OEhUK3JIS3RtVFZoWDN5TTVTNzM0Y1kxUEdkbVh1bllBT25VK21jVjRBN2dI?=
 =?utf-8?B?M2RwcUx4TUxqcEhWd0RYR0tNVlBvNGdobnNjTURKaFV5VEliVElpcUFwNVZs?=
 =?utf-8?B?dm9nRVRuOWc0QkZKRkFDOXArVHM5ZzZSblAyTUlZaHl2T1NYdHhXcFlFVUZz?=
 =?utf-8?B?UTV4emNVWHVlM0lkMG1qS3lsblpwaVpGY3ZyQVowcER6YlEwUklSTmVuOWhh?=
 =?utf-8?B?dDRmcHNCS0ptbnJHNkFIay9IWEhGRXF0UVFrL2k2N1hLZHVRUmZHckNoSHVG?=
 =?utf-8?B?WHBYQlhNdFlDTHVMbkFxTkVGWEI3SWdDM2dEVFhSMTVFYUdYVzdIbGJSdFhE?=
 =?utf-8?B?TkFPcnU5QU9PS1hqM2JkeFIyanRkV1FkS0N6ekV1K0w3UFhjOEFIOTZ2VHMr?=
 =?utf-8?B?WitpNW9LN2N4elFyUzJyQzNlZm1GRDNuUWpueWNYTnhNMTJyaStFSXVSSE9T?=
 =?utf-8?B?OEdsT0x0Q05JTnUweUVhdEx2T01MWGl6ODliRWd2REZLQU5SSk5jQnB2VEZM?=
 =?utf-8?B?UXBua3NqLytXdVltUjdlMW9MekZVZU1qSzNMb0lzMmR1ZHdwZnpQWE1sRmJw?=
 =?utf-8?B?Z2oyeE5lWGlPM3NZQy9IbTM5WUdVdzNOVGZNRXpFbDFFTmxWZDFqamxvRFcy?=
 =?utf-8?B?empjdHhna3FLelQ4L2V3eHZQMGJpUG5HVXhzc1Ywd1ZUcWVPOG9IdlZyK0Ew?=
 =?utf-8?B?dTBNNk9jUlQ0S0gxZGFaamw4bk9HTVZVODl5MzBFMVA2WFZsNmdpVGFBTWY2?=
 =?utf-8?B?cnFCaTdCQVU5M2VGL1NkOXlBeXlKUm1TSG1NNGh3R2p4Tk9IVDZ2eFFSZDBx?=
 =?utf-8?B?TjJ3aTZYS2xZa09NR0FrTHNLV1BjVC84cnZUbFpVSVZsbTVHZ2gzak50WFhp?=
 =?utf-8?B?bE03S1hFelBkR1I3V0F5MnN5a2Y1RXNneWxIWGRIb3NGMmlVUnJoY0hkeFVG?=
 =?utf-8?B?RkJLWnNlOG1HYjIxM1MwZWRQTnBMUjk3dFpFSk9YVHVFZlFXanBwSE40MnVS?=
 =?utf-8?B?VkNlUFVEWnA2TVNTd0ZsNXNtSGhwQllhNFk0em1Nd2NVeUdURE1tNmFRaWhn?=
 =?utf-8?B?eXR0MHRHeFVqMm4xZExYcU9SbHFwMjBXZzljM1dTSjVMeHJsU2w3MmVmdW1S?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a52585a-7e8f-4160-e9ea-08dcf7f2d7b4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5782.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 08:22:35.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/AbBLtrzOSXqp5UtIVN6jSFTYFwL1yEVJLlxrUVdvkOup03yq4QeFIURvLIu/0UbJEN5M7ba8O5AQ0A1y7qd3ypL1o+NRWnQcgRJtV/apI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7008

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Hi Sergey,
 
>Hello Jinjian,
>
>On 26.10.2024 12:09, Jinjian Song wrote:
>[skiped]
>> Application can use MIPC (Modem Information Process Center) port
>> to debug antenna tuner or noise profiling through this MTK modem
>> diagnostic interface.
>> 
>> By default, debug ports are not exposed, so using the command
>> to enable or disable debug ports.
>> 
>> Switch on debug port:
>>   - debug: 'echo debug > /sys/bus/pci/devices/${bdf}/t7xx_mode
>> 
>> Switch off debug port:
>>   - normal: 'echo normal > /sys/bus/pci/devices/${bdf}/t7xx_mode
>
>Looks like this part of the message needs an update. Now driver uses a 
>dedicated file for this operation.
>

Yes, please let me update it, thanks.

>> diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
>> index f346f5f85f15..6071dee8c186 100644
>> --- a/Documentation/networking/device_drivers/wwan/t7xx.rst
>> +++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
>> @@ -7,12 +7,13 @@
>>   ============================================
>>   t7xx driver for MTK PCIe based T700 5G modem
>>   ============================================
>> -The t7xx driver is a WWAN PCIe host driver developed for linux or Chrome OS platforms
>> -for data exchange over PCIe interface between Host platform & MediaTek's T700 5G modem.
>> -The driver exposes an interface conforming to the MBIM protocol [1]. Any front end
>> -application (e.g. Modem Manager) could easily manage the MBIM interface to enable
>> -data communication towards WWAN. The driver also provides an interface to interact
>> -with the MediaTek's modem via AT commands.
>> +The t7xx driver is a WWAN PCIe host driver developed for linux or Chrome OS
>> +platforms for data exchange over PCIe interface between Host platform &
>> +MediaTek's T700 5G modem.
>> +The driver exposes an interface conforming to the MBIM protocol [1]. Any front
>> +end application (e.g. Modem Manager) could easily manage the MBIM interface to
>> +enable data communication towards WWAN. The driver also provides an interface
>> +to interact with the MediaTek's modem via AT commands.
>
>Thank you for taking care and unifying documentation, still, I believe, 
>this change doesn't belong to this specific patch, what introduced debug 
>ports toggling knob. Could you factor our these formating updating 
>changes into a dedicated patch? E.g. add a new patch "2/3: unify 
>documentation" and make this patch third in the series.
>

Got it, please let me do it.

>> @@ -67,6 +68,28 @@ Write from userspace to set the device mode.
>>   ::
>>     $ echo fastboot_switching > /sys/bus/pci/devices/${bdf}/t7xx_mode
>>   
>> +t7xx_port_mode
>
>I believe we should use the plural form - portS, since this knob 
>controls behaviour of the group of ports.

Fastboot switching is a bit special, this will trigger the WWAN device
reboot to fastboot mode and only a fastboot port in this mode, How about keep it
as before?

>
>And I have one more suggestion. "mode" sounds too generic, can we 
>consider renaming this option to something, what includes more details 
>about the mode. E.g. can we rename this knob to 't7xx_debug_ports' and 
>make it simple boolean (on/off) option?

Yes, rename to 't7xx_debug_ports' and make it boolean is reasonablei, please let
me change it.

>>
>> -static struct attribute *t7xx_mode_attr[] = {
>> +static ssize_t t7xx_port_mode_store(struct device *dev,
>> +				    struct device_attribute *attr,
>> +				    const char *buf, size_t count)
>> +{
>> +	struct t7xx_pci_dev *t7xx_dev;
>> +	struct pci_dev *pdev;
>> +	int index = 0;
>> +
>> +	pdev = to_pci_dev(dev);
>
>This assignment should be done along the variable declaration to make 
>code shorter:

Yes, please let me modify it.

>>
>struct pci_dev *pdev = to_pci_dev(dev);
>
>> +	t7xx_dev = pci_get_drvdata(pdev);
>> +	if (!t7xx_dev)
>> +		return -ENODEV;
>> +
>> +	index = sysfs_match_string(t7xx_port_mode_names, buf);
>> +	if (index == T7XX_DEBUG) {
>> +		t7xx_proxy_port_debug(t7xx_dev, true);
>
>Another one nit picking question. It is unclear what is going to happen 
>after this call. Can we rename this function to something what clearly 
>indicates the desired reaction? E.g. t7xx_proxy_debug_ports_show(...).

After t7xx_proxy_port_debug(t7xx_dev, true) the adb and mipc port will be
shown directly, let me rename to t7xx_proxy_debug_ports_show more clearly.

>> +static ssize_t t7xx_port_mode_show(struct device *dev,
>> +				   struct device_attribute *attr,
>> +				   char *buf)
>> +{
>> +	enum t7xx_port_mode port_mode = T7XX_NORMAL;
>> +	struct t7xx_pci_dev *t7xx_dev;
>> +	struct pci_dev *pdev;
>> +
>> +	pdev = to_pci_dev(dev);
>
>Also should be assigned on declaration.

Yes, please let me modify it.

>>
>> +enum t7xx_port_mode {
>> +	T7XX_NORMAL,
>> +	T7XX_DEBUG,
>> +	T7XX_PORT_MODE_LAST, /* must always be last */
>> +};
>> +
>>   /* struct t7xx_pci_dev - MTK device context structure
>>    * @intr_handler: array of handler function for request_threaded_irq
>>    * @intr_thread: array of thread_fn for request_threaded_irq
>> @@ -94,6 +100,7 @@ struct t7xx_pci_dev {
>>   	struct dentry		*debugfs_dir;
>>   #endif
>>   	u32			mode;
>> +	u32			port_mode;
>
>If we agree to rename the sysfs file to 't7xx_debug_ports', this field 
>can be renamed to something more specific like 'debug_ports_show'.

Yes, let me rename sysfs file to 't7xx_debug_ports' and rename this feild
to 'debug_ports_show'.

>>   
>>   struct t7xx_port {
>> diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
>> index 35743e7de0c3..26d3f57732cc 100644
>> --- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
>> +++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
>> @@ -39,6 +39,8 @@
>>   
>>   #define Q_IDX_CTRL			0
>>   #define Q_IDX_MBIM			2
>> +#define Q_IDX_MIPC			2
>
>Are you sure that we should define a new name for the same queue id? Can 
>we just specify Q_IDX_MBIM in the port description or rename Q_IDX_MBIM 
>to Q_IDX_MBIM_MIPC to avoid id names duplication?

Since MBIM and MIPC use the same queue id, please let me rename to Q_IDX_MBIM_MIPC.

>>   
>> +void t7xx_proxy_port_debug(struct t7xx_pci_dev *t7xx_dev, bool show)
>> +{
>> +	struct port_proxy *port_prox = t7xx_dev->md->port_prox;
>> +	struct t7xx_port *port;
>> +	int i;
>> +
>> +	for_each_proxy_port(i, port, port_prox) {
>> +		const struct t7xx_port_conf *port_conf = port->port_conf;
>> +
>> +		if (port_conf->debug && port_conf->ops && port_conf->ops->init) {
>> +			if (show)
>> +				port_conf->ops->init(port);
>> +			else
>> +				port_conf->ops->uninit(port);
>
>I still do not like the assumption that if .init method is defined then 
>the .uninit method is defined too. Is it make sense to compose these 
>checks like below. Mmove the check for .init/.uninit inside and add a 
>comment justifying absense of a check of a current port state.
>
>/* NB: it is safe to call init/uninit multiple times */
>if (port_conf->debug && port_conf->ops) {
>	if (show && port_conf->ops->init)
>		port_conf->ops->init(port);
>	else if (!show && port_conf->ops->uninit)
>		port_conf->ops->uninit(port);
>}


Yes, please let me modify it.


Best Regards,
Jinjian.

