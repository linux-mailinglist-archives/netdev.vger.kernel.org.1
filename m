Return-Path: <netdev+bounces-153631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 201079F8E3A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A98116C4AB
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583041A83EF;
	Fri, 20 Dec 2024 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="n7BeUfuF"
X-Original-To: netdev@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021088.outbound.protection.outlook.com [52.101.129.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1DA19ADA2;
	Fri, 20 Dec 2024 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684668; cv=fail; b=iMAkbwc+Ahgu/XtTTleJZL/wxv1OEcsPUHuTyFvregcPo96geEtmn95BSrHU5C9k1nSGIxcXuAeQDcoRc8RBR7TDui4GCKtA+jlmau5ZZKUDKv1ryBxkxdJXNHw/xzAkK/vZd9a/tpn/A5u/t1RQllE9mgYprqZAObic7gYZhdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684668; c=relaxed/simple;
	bh=gJd7f5uVGFGpG++ysJe8OL+76biqnT2fwNuJjauAFEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GipX05YSOIqmGRm+mAeaE0dy9TYMkwHSZjO5wtUD3+32Alkfr0Ym/XJTjPVhKbBmYFc3BBlYICd9pShqgbh5+Fm63B+SoLGGE5dkdH4mNvRFFe9Ee6/5Yp6B/0X6Q+a7hAw2ukDdj+IRy8vdQupYIUhdAq5xVAHLoK3oNEBQkLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=n7BeUfuF; arc=fail smtp.client-ip=52.101.129.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wwff4fRjMV6itOqvSKvUHqdvTxSVE+y6PXXa0UqRWskU48DKaIMA7TTdWa5sJ3MQKpFOmxjqJjy8uLQ/yiWiLhBiGCr42PsG/LBTUxXHYBLcWJQBgBUyOYV2cKMyhac0rVqhlshvbnD14Dfc8b0rmShPzJkZuYklK89UUn/VCUsCFEyQDRQcBG0TOcMA5UgY5N6CGodAbmqv2XMlbUUmdgFQzk1tqI0QITIl5zuftN+67uXyMjIlSDqusVvOOJsrBaWJXIfHdcGqlpZAPj6rVLnlQq0g9KL0MGiFEeWjdqd95vZKmsatabZZ1iWfTUr7XPrBYsxFCmjrTaSz2V4hZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=764FN0kjKGwrqKqHzfTio0GE0ZmimsPvMmxa1MbNajc=;
 b=G5dE0pZMkAY6vm6NVZBYsQ9MX2Sk0O3EcHCZRBtaHy7gpE3rLh+5tgYdnt7B1ekXZeT1XB459yz9JJdTuSNKLiRI8K8b+uJZxLt8MiGW01xxTUXxgMhTKmBPxw01g8EGKKWEVjpDhzUxFN2l8LnqOAUoddDwlO//6n0YGhJJTEiXbGu47aqPGzhIkFYnQBkvaSobTZduauv1Z8uiVmB9tvrHZLy53jjAhV9mB6iuC0jWcv0Tvcie77sqc4nbSwrbWO6ZpE35wkfqtGVQI8TQaJzOij2mMvd/NS8SGJDjzn+p5MA73bf4jfVjcglXG4WoT+hgcbCGKjpX50bU+E6koA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=764FN0kjKGwrqKqHzfTio0GE0ZmimsPvMmxa1MbNajc=;
 b=n7BeUfuFHNiZ1YqSmV9ekjWa4h+LXopoTenwBqT4ahWSe8RuYJ2uYQ68vywGgtUSw3vrmCEX2p7dmv8fGrJwu8HZvATp9QiloXvIy/mjQzvErftKnpOsDoeOjWunfvS9ARF6QGdCbP/PrjYUnZxU3Bwy1eWRCg9DcoPXf7GhOrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by TYZPR02MB6011.apcprd02.prod.outlook.com (2603:1096:400:1f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 08:50:59 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%5]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 08:50:59 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: ryazanov.s.a@gmail.com,
	Jinjian Song <jinjian.song@fibocom.com>,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	helgaas@kernel.org,
	horms@kernel.org,
	korneld@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [net v2] net: wwan: t7xx: Fix FSM command timeout issue
Date: Fri, 20 Dec 2024 16:50:27 +0800
Message-Id: <20241220085027.7692-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <da90f64c-260a-4329-87bf-1f9ff20a5951@gmail.com>
References: <20241213064720.122615-1-jinjian.song@fibocom.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|TYZPR02MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: f15d42b8-abcc-49fd-6aa1-08dd20d36c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em42blhvT1ByVkkreE9LZzdVNzBNcjJveVByMUNaRllRVlY3OFZWMTZDTmFl?=
 =?utf-8?B?dzdHQW1lNXlWNmtLNFFBOEFrQTdDa0tvaE9PZVBhbE11VFZqZ2liL3NzRGtR?=
 =?utf-8?B?N0VldnFtTHF3eXYrRDBMOGI0ZHB1SE5NT0tOQkF1L3UwUldjQ0hsT1ppdmkx?=
 =?utf-8?B?eXhLTXRIRnltMWQrQlpVN2JjdFFkeTVNdHR5VndsQ1YvZDFEd1dZSmJtWnZ4?=
 =?utf-8?B?VUpYRXBVcGZxVitsU0VZelBYdjBFdCtaOU9QdmpXTFBtWFdobHpURVR2WGV2?=
 =?utf-8?B?YndWcXd3em9NMTk1clVwNGVFZWZNL25meDViR3VRYWozUXFBd0FXMmk3Y1pw?=
 =?utf-8?B?cHVMempHam13MWorc1hXOEpSNkdORjVVZzZQMVJXZzVKc2I0Z3BNTFdNNEhq?=
 =?utf-8?B?NVBvL00rSE8vdUlNa2RPMmZyRlhTejZObXNFdU9TRnNsdkxaZzg3K1d3NTdQ?=
 =?utf-8?B?dEtxcE1od1EyTENWTTJPNWxaR3F2d3hRSXlJUXJkWW00TGJLYjExY1ArMjhW?=
 =?utf-8?B?aFZ5R1FvbldoVU1KUzVueVZrZmVKaUF1RUd3MzBYMFJUODhnR0xOaStWT3Uy?=
 =?utf-8?B?R1ZyOGZzUWU1WjdwbldEWUtSS0NUR2FGNmYzS2dOWHdpS05qN1lEYVF0VERl?=
 =?utf-8?B?R0NrWDA1cUYraWpxckF1MU9CTEI3WDEwSDFBOUZLODZYTUVoK21ITndmUFVB?=
 =?utf-8?B?QTB4OFZDMEN1djY0cjI2anI2MEhOUkJYWW41dVIzL09YV2JaWTF4dU4wbnFV?=
 =?utf-8?B?N3gyMVlSZFdEL280OFpvZkNkNkNXeS8ybGY2Sk5rRnUrS0lRWmY1NVo5bVFT?=
 =?utf-8?B?VFYyd1EvVk91Z1dwL1lPVlFnaGRKNmdoRVNLOE1ZSEdtSTltbEFzb3c0WGMx?=
 =?utf-8?B?Vzdwd0hwL1BVd29tb29LUGt6NTQ3bkUvZlYzc0lDTllYbHRUaEJPRnArbFE3?=
 =?utf-8?B?SE5YYk5xN0RBN2hPTWpSMU0rbGdnL0tSUG1meFB3TWw5NzZNczQydXdIQ29z?=
 =?utf-8?B?SlpqRVhLYWpMNkRRM0x4RCt4S3ovZ3FuQ05TWWhUUDV1cjRrM2thbDVnaUkr?=
 =?utf-8?B?K2w1OENaM2FiKytUM1U3SkZEeUV0M0E4dmlGL05RbzJ5a1I0MEpXTFM5UkI4?=
 =?utf-8?B?TzE1SmZ0UVAzTXl5cktWSW1KeHMya0pqZHNVSjV4aXgrT1FSUEwvN24xaHRo?=
 =?utf-8?B?VmZqTDlBMDk2MDFDbnRVaFNrZ25xYjdURkxHclJ5RGFmek1jdkJXbmhOYlhu?=
 =?utf-8?B?ZFRTTU5YelZkQ0Z3Y29XR0ZESERkUjdkNEFQd3hlczBxRldlaTZNWHVaeWVv?=
 =?utf-8?B?a0xhZ08zZlpVWUorYnFSSkpBUVVwbStXVnFiWDY0RHQreTJZS2xKTjFmWFhU?=
 =?utf-8?B?cWVpTlhHb0NJdXdkeGdiOGg5OGgvSUJhRWJyeHJxd3JaVCtpdlRwME85Q3lW?=
 =?utf-8?B?a2xLUi9sbFBIL05qWEc2aDBhMStNV25jRGdaV2lzc1JaZXFUTytNUGx2dFVB?=
 =?utf-8?B?R3lwKzUwWFRFQWVGMkRvcTZ2Z1k4UXdxVWF1d2xrUHRPY1lVSERnTkl4aW9O?=
 =?utf-8?B?YXBhc1dyeUZnbU90OWsxT04wREFWSmdPdFp2ZkdQeXpNS2RkSWNRSWxFeDhj?=
 =?utf-8?B?U0FQck9wWWNLY3VGYlhQT1Z0TCs0QVBja1RncVFJcVJrbWN4ZmtzbEJ5UUV2?=
 =?utf-8?B?SEJ6ajJKbjN6Rk9VcDVBSGMyRExWcm42SmM2dGZvOEdwNysvWEt6azRZQSsw?=
 =?utf-8?B?bDJoSHJlZ0c3eWd4YmU3M2xtNzVXZlhuc3ptblF4ZjVMZTdja04xSkhtcG1T?=
 =?utf-8?B?VmhSdFpCbEtjOTV4bjMvU2FncWJZQm9hZ25GVE1XUS85ejF5RjBCWnovSXJa?=
 =?utf-8?B?MlIrbHdXcU0rR2d6c3RRT05wWnpGbWUzWlRVbWlqT0loWm81b2NDcVUxRGFF?=
 =?utf-8?B?bHFXWTBsendEOXVRNmppeC9ycEhrR0pjNFdOVmFidEhjVnAwS3l2aWVRVlR2?=
 =?utf-8?B?RzBmSUtJVjFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUZycit1VGJpcndQOFNudldUZW15NXhMZkMxaENpdXk2M2k2c0cvSXZPRWhW?=
 =?utf-8?B?OHNjTWVYTUUwd2h1aVdxbGtac1VOeGI2d3RJYTA4WkJxMFk4WEpTT3pGMTY0?=
 =?utf-8?B?N3Q4K05JRFhHREVUT3NCNTBzU01LK0l3SHJFamVMVUR5NDdQVlExeUp5UGRs?=
 =?utf-8?B?NVM3UGR6OTRrUm84ajB5WkdOWjJVOGlmSjJRdFVUUE13ek9sWHExL1JWVmUr?=
 =?utf-8?B?TCszMUs1SGRkWW9xQnRFSjBhQ0V5VFAzRE91eExuRnJCL1k0TTFGZy9HVElP?=
 =?utf-8?B?VUpod3NQVFBQNWZTOVNpaHVJNlBaK3RTeitLdzhvMHZPQWNnY3poRG1Qd0Vn?=
 =?utf-8?B?ZjQxclh3UVp3RnNQOUNzUzBrLzFMWU40ZjRkTUFzSWF5aE1JdG5TMjIxbjFL?=
 =?utf-8?B?UGJuM1BucFFlV0lWWVpEZy9KeXZhcWdCSFVtSGFMVXpuVHU0TzY0M1UzUk93?=
 =?utf-8?B?dzlhKzJiOEIvdFdqSmtHSllkUDQ0dm1tUXliNS9nQmRvZUVOY3d5RElKVEw2?=
 =?utf-8?B?WnZpNjdNZjBxTXN3MXZ1dXJ3VlhHYkI3aUV2ZnV5cHNCQ05GSHVtWDVLZ3JB?=
 =?utf-8?B?MU1IUFQ1M1V0R1lDUDMzT0VockZhMzFYZHFXVGQ4RGR4QjdKWGRlbGN2OVRY?=
 =?utf-8?B?emYzK1I1OEF5eThaZS82anlhQUNiaVFxLzd1Y1plNjFQYzJDOVVSa055MU5i?=
 =?utf-8?B?bG00c0ZrSTloeWJSaEd2bXBTay9BV2tmR0tnNDNxMm5oZVFrc2c5OU43RTZl?=
 =?utf-8?B?cDNraGVsWnVkOVFaMjFTaTFJeTY2NTBrRHdIZS9iL2lSdURGZGxLRlRDMGt1?=
 =?utf-8?B?c0I4TXJVMFBnbW5ocnRpay85aE1aYjZjZTAzbU1aZzMxM3M5c2xrdU9PNmM0?=
 =?utf-8?B?V042dHdPajRRQms1Uk5ody95dUdNaU9JWHhVNjdyTGErTWZIc09pVHdoRlRm?=
 =?utf-8?B?Znprb2ptVGNyTGtmNFFpa3lDblJuVEUrRjFMejhPWERWcnZmUjZzc3g0aFNP?=
 =?utf-8?B?K0JZTkkybm1uckJTT2Y2bVZEclBpbTVybjQ3R256Q0Y4ajFKb0JLN1pzSk13?=
 =?utf-8?B?YndqeENPWWF0bmg4RThHQ2JyMmZRK2JnZUs0UU1yTXhwMnU4MzlWMDdOQTQ0?=
 =?utf-8?B?bSsvRDdoUFRLUURiSWdHeTVBWmNLQnlvMm5DOUMzZVRmTkszQVd4MU5nWjBE?=
 =?utf-8?B?S3lSSHAwZkxFVDRXMjZsSExxVGJYb0RRUThvVEE0bDI2d3IwdU1McytoSXZU?=
 =?utf-8?B?SGY3WjEzZ0FBZno1T0Yza0VraFVyLy82ODAxMEFrblNuSVJhTFF5eVBlQ0Y1?=
 =?utf-8?B?dWxyUzZkNmtxZHFWSCthU0tOSzJUN2VOTjQwdmdWS3JHN2Rnd1J5Tm5ONExR?=
 =?utf-8?B?M0NqK0pWTUh4ZDE4QkZ3a1haYXBkRXIvam1EQTJMeWhKcXdrOVQ5dG8yTU96?=
 =?utf-8?B?eXJ1eElkbkNrZHVpYXFiNHVsUzhiZHFRelJSS0JSdG1ETlJTaWdBczJxeGta?=
 =?utf-8?B?MFR0clNkdEdOSTZFRWtNREc5cXFlbFFoUncveDNpU0tTUjdnWDFwWTBVdURn?=
 =?utf-8?B?ZERnTlZjNGlrMFB4QTZwUzMrV1VFMzY2a0gzbTR0UFF2SVNoYzNGQlpYc2pS?=
 =?utf-8?B?UDhHUkNOcVRWNzZTaVk0VDVneGd6aWdwcXdLQ3lhQ3BqQVRhbGxZUldnb0Vn?=
 =?utf-8?B?K05VVzRIb0htOUJ1S1ljUU1nZjlibUtrUk1udGRjMElRaWZMM2xvWHdSc3gr?=
 =?utf-8?B?V3pJS2hxM2FhQ0JoOTZVdFFwbVkzNXUwQkR5MzVvNGp6T3cxTnAxY2luUTQw?=
 =?utf-8?B?V05RZWsyayszellmUkxjZkRwaCtBaDdHQzcvNmJ3VXRidkhmd29KMElKQ0s4?=
 =?utf-8?B?UXdPamVJalFFSjFsTHo1M2NQdjNNbExnemZvdmNkMTFqOVZWRVdrbWwrYlcx?=
 =?utf-8?B?TWJuM3lQVU1nM3dLOGRkdm1OOEM4cGRza084bEVQODRTaTJ0UUxXM2R3eUhi?=
 =?utf-8?B?R2RsU0RwWXZsK2NCdW1LdVNZS3E5SGhZNUt4OERYL2cwTDlxQnYzeURXM243?=
 =?utf-8?B?SHZtZkFDT1Q5RmhBb01ibkoxc0dCV2tYdmNvUnluT1JwWGQ5T2htSm9qTlMr?=
 =?utf-8?B?OVMvMGU4WU0vRnZVZHdvd1RSVWJBRkMxRlM4V2JBWjgyNW1Yb2FYbklZMWZV?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15d42b8-abcc-49fd-6aa1-08dd20d36c45
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 08:50:58.9580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRJerlumVH4mxSKM+c91hjW23SI03XUfDAk1DPTAJ/sULrY4x/OYwlAnhm3xM88J2vl0Ipa5nrRyMjHH7g8YaBVJ3/CPpcK5cQ9psMHlnSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6011

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

>> Fixes: d785ed945de6 ("net: wwan: t7xx: PCIe reset rescan")
>
>The completion waiting was introduced in a different commit. I believe, 
>the fix tag should be 13e920d93e37 ("net: wwan: t7xx: Add core components")
>

Got it.

[...]
>>   	if (cmd->flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
>>   		*cmd->ret = result;
>
>The memory for the result storage is allocated on the stack as well. And 
>writing it unconditionally can cause unexpected consequences.
>

Got it.

[...]
>>   		wait_ret = wait_for_completion_timeout(&done,
>>   						       msecs_to_jiffies(FSM_CMD_TIMEOUT_MS));
>> -		if (!wait_ret)
>> +		if (!wait_ret) {
>> +			cmd->done = NULL;
>
>We cannot access the command memory here, since fsm_finish_command() 
>could release it already.
>

Got it.

[...]
>Here we have an ownership transfer problem and a driver author has tried 
>to solve it, but as noticed, we are still experiencing issues in case of 
>timeout.
>
>The command completion routine should not release the command memory 
>unconditionally. Looks like the references counting approach should help 
>us here. E.g.
>1. grab a reference before we put a command into the queue
>1.1. grab an extra reference if we are going to wait the completion
>2. release the reference as soon as we are done with the command execution
>3. in case of completion waiting release the reference as soon as we are 
>done with waiting due to completion or timeout
>
>Could you try the following patch? Please note, besides the reference 
>counter introduction it also moves completion and result storage inside 
>the command structure as advised by the completion documentation.
>

Hi Sergey,

Yes, the patch works fine, needs some minor modifications, could we 
feedback to the driver author to merge these changes.

diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 3931c7a13f5a..265c40b29f56 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -104,14 +104,20 @@ void t7xx_fsm_broadcast_state(struct t7xx_fsm_ctl *ctl, enum md_state state)
 	fsm_state_notify(ctl->md, state);
 }
 
+static void fsm_release_command(struct kref *ref)
+{
+	struct t7xx_fsm_command *cmd = container_of(ref, typeof(*cmd), refcnt);
+	kfree(cmd);
+}
+
 static void fsm_finish_command(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command *cmd, int result)
 {
 	if (cmd->flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
-		*cmd->ret = result;
-		complete_all(cmd->done);
+		cmd->result = result;
+		complete_all(&cmd->done);
 	}
 
-	kfree(cmd);
+	kref_put(&cmd->refcnt, fsm_release_command);
 }
 
 static void fsm_del_kf_event(struct t7xx_fsm_event *event)
@@ -475,7 +481,6 @@ static int fsm_main_thread(void *data)
 
 int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_cmd_state cmd_id, unsigned int flag)
 {
-	DECLARE_COMPLETION_ONSTACK(done);
 	struct t7xx_fsm_command *cmd;
 	unsigned long flags;
 	int ret;
@@ -487,11 +492,13 @@ int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_cmd_state cmd_id
 	INIT_LIST_HEAD(&cmd->entry);
 	cmd->cmd_id = cmd_id;
 	cmd->flag = flag;
+	kref_init(&cmd->refcnt);
 	if (flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
-		cmd->done = &done;
-		cmd->ret = &ret;
+		init_completion(&cmd->done);
+		kref_get(&cmd->refcnt);
 	}
 
+	kref_get(&cmd->refcnt);
 	spin_lock_irqsave(&ctl->command_lock, flags);
 	list_add_tail(&cmd->entry, &ctl->command_queue);
 	spin_unlock_irqrestore(&ctl->command_lock, flags);
@@ -501,11 +508,11 @@ int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_cmd_state cmd_id
 	if (flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
 		unsigned long wait_ret;
 
-		wait_ret = wait_for_completion_timeout(&done,
+		wait_ret = wait_for_completion_timeout(&cmd->done,
 						       msecs_to_jiffies(FSM_CMD_TIMEOUT_MS));
-		if (!wait_ret)
-			return -ETIMEDOUT;
 
+		ret = wait_ret ? cmd->result : -ETIMEDOUT;
+		kref_put(&cmd->refcnt, fsm_release_command);
 		return ret;
 	}
 
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.h b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
index 7b0a9baf488c..6e0601bb752e 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.h
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
@@ -110,8 +110,9 @@ struct t7xx_fsm_command {
 	struct list_head	entry;
 	enum t7xx_fsm_cmd_state	cmd_id;
 	unsigned int		flag;
-	struct completion	*done;
-	int			*ret;
+	struct completion	done;
+	int			result;
+	struct kref		refcnt;
 };
 
 struct t7xx_fsm_notifier {

Thanks.

Jinjian,
Best Regards.

