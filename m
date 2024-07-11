Return-Path: <netdev+bounces-110783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93F92E4D9
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CF51C21C9F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCD515958A;
	Thu, 11 Jul 2024 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="w+1+Mo+7"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBA157A74;
	Thu, 11 Jul 2024 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720694022; cv=fail; b=kn4lP5T+85b4vNme6Njr2VWBOEMKKCP1IcIxEq99lPwqRyGHn3gApScYG5lmCgRjuW/re7TxmgVUJn9wvrdqqFR6y8UBIBHHP87A0qgU6YTYXdeIsC3SVnPoxHTScNDdeW4bkbPOAQAAz3POCAIiCVZEVWsGCwRYsxWcS6bEN3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720694022; c=relaxed/simple;
	bh=EwVHBxO9pgFTX7mlHbiHJqp1vPL1j4ztJ2zoMBDvFVs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qD+9Cvkeoe0xhfz7lSqN/gNESnWrU9M2yvfI87OyvbJewVkwjCllFLWngwy0rem0EF2iwAjp7+veGPjH0Gd6rISRDW+PzAiltY4A8N1jY9VhReG8TqfcSyqPOVWQ+n4U13Ul9MkM4KosJbvYujv7NP5HqtQFUvpfnOT4l39H2pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=w+1+Mo+7; arc=fail smtp.client-ip=40.107.117.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5IaCSVrgTLiqB14XLJEUrbwmHf8NkETJF1tC/ubv/MK8yWi8O6EKfiZ3eizaw+pnjG6NiX9vn4UcwFQTvnccOXKsHHgqcMAY6GirqyMtA11ljzx41epWTzTHsV/UmM4mhLSBAtsaFUREq/HLUT72m0zIHisCo6mvgvZ5VeHe8l/NkTb+8TdJEhuu9ZFJlqHnn6OObAj3HwaupI6IfSE8eiMrb+qyd+Ajx1/FAj+BLOcyUHSV421ulnNDjirKVBg/8SJiUN4PTn+n8haMYMC5Xo0s4VgRLKa/gHs7ZeM/55SEYnpwx0EAdMZzdgLdpUUYUq9oSRac5YPyrK5Ym2oKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7WiNeJzRXMy5rHrdWvdp1GmXgoigH9V2DgVD0Zi/qs=;
 b=cmDHzr1uVlhJ/yyAhH0mvhz0BoPbzHlIRggwyygcTtvE5/g4blxqIM6uT2+Ee2GZXz1+T9EDae6c1tHfzVmUPja5iJlcUYG1AkyJrtPNKQvWtSd1Mm0zhkLvYbfOUb6086T7hZSlLJp4yNNgG4SZqgeVwApi7jd1A4STWr8OYa7vmuih5AQDw62OuVr4TFoyvWQuTBJ92gCoE4pA8bIbPlAM5zVACHi78YaplqQMBeBVT/yCPAALHEh7n2aqO6p1C3kb2h/ELo+JxVJElantcImyOyeF96/PdcMOfbpWHTeEEqN4CH54Z3r5VDQ/2WBd14IxRakDWltA7UmMq6tv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7WiNeJzRXMy5rHrdWvdp1GmXgoigH9V2DgVD0Zi/qs=;
 b=w+1+Mo+7Tb4huGdBkPhVSBG9v03jFl4r6BWl2QgRP7PHHRYOmYi6/o6O/9t2khMRKj/otLrFdibqNc0PeLuE8JOoFxOkpNCixNx4yPylDigQJZjzGNeqsDNpX+H00hiNQqkcXm9jNl+Ypvv+aHoy3WpFeVGGa8ojeUFri0osdQJJkQLFOJ5geYZefa+yRttaeVzg5OfmcDMLpW2zLzPDZs4BQjGXiTaRaAG/hfLh2lYQBIavnRWyp5Fou7SkmAplA2AQlzgCRbTGC0AGCHiSMctapMAk0se8q9Xu6dyp08o0uJTUYu/qGFyrdG5rXzsyQtAg3rFZSZRQJvFsbmwgdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KL1PR03MB7491.apcprd03.prod.outlook.com (2603:1096:820:ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 10:33:37 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 10:33:37 +0000
Message-ID: <4f5bacb8-6361-4f4a-9c51-9ec4eb30d2e2@amlogic.com>
Date: Thu, 11 Jul 2024 18:33:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] Bluetooth: hci_uart: Add support for Amlogic HCI UART
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Ye He <ye.he@amlogic.com>
References: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
 <20240705-btaml-v1-2-7f1538f98cef@amlogic.com>
 <3e364c38-c5ac-49e6-9a9b-5b2b4e3cf5a1@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <3e364c38-c5ac-49e6-9a9b-5b2b4e3cf5a1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27)
 To JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KL1PR03MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c601cca-5d81-4aca-c158-08dca194ec0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlE5NTYxK0J1SnpjWHdGWlNJMm12SjFnSXJnK1UvcVRpdGVQYnBib24wQUxh?=
 =?utf-8?B?Q2tVVVhYcGgrb0RMQW44UHNFU1VvNDZMZlJBUCtTSkVCYlF6cEJKQ29tVzhN?=
 =?utf-8?B?MDJHTlBHZlZPUUVEK1RtRUdpRlhkd2pjaWlOQlZReVpXOW52ZFBVSms2TUY2?=
 =?utf-8?B?MlBGYy9ZN3BjZ29hZlJpMHJFUk5QNmFVcGJnU0lNdkFQZ3lrWnhUTDFIUm9a?=
 =?utf-8?B?WFZQWHVFUFpEdmlSc0V6dGQ1MTFYeEtoUHZmOWhhNkF6Tzl1TFZmbkZuZE5m?=
 =?utf-8?B?cVcrMEt1UXhUa04xcnZ5aFFVMUtCOFBCZy9kZzR6YkIwK0VqZFYwMkE1QVVq?=
 =?utf-8?B?VXA5V2g0cEc4VXNNdHFvN05HdnIwU2poRW9CNXZjdkh1aXZOTXlwV05XbDA4?=
 =?utf-8?B?MDhFWVA1OS81WGI0R3ErOFd2Ym1NaE5STlMzby9IQ0RUQm5QMUFsWmZYWENs?=
 =?utf-8?B?Wk5VbnI3ZktkYkRYSFJCZWJxWkVFeFJjRXl0c1lLMHhpYnJJd2pBS2V6eTlG?=
 =?utf-8?B?djNMcWx4S1lPUW5WY0xBMHlDU2FMTUpKN1h4cUY5Zk1BeTNMVEtDWDYyVHds?=
 =?utf-8?B?NllVSThPZmFlYXVTQ3grYnIzSVZOaXZVbkN1WVZDRWgvS0JpbHhxUVd4dVc5?=
 =?utf-8?B?MkdXNGUzRkQxaXpOaCtzam1ESUlmVFVZcDF5UldLRXp2RVBQdFpSWkNJK1hy?=
 =?utf-8?B?b0taOUYzWTdKNHN2YlUrdWU4WEpCZmhPa2lXZlhRN0srcnY5cHRhRUw2WXg4?=
 =?utf-8?B?Z2xBemdXL0lNdC9XQzlEd0Z5RTh3OUVCbzlWVThYTEoyV3JaNzNMNEpmaHIz?=
 =?utf-8?B?MFN6OEQ3aWpPaGU5OFJyaFpPTVdGeERISlNTREVCVS9aSng5MjNZRnMwZDll?=
 =?utf-8?B?SWFhSnpKSWxQNmVKbUZDNDlRbGJ4QzBzQ2RUTG4wN0YyNHBtZUU1WnNCano1?=
 =?utf-8?B?c3NRR0VTcDA0dzZ2elk4bWxzTVBRbC9nQjZJaEFjb1B5Tm9TMi8xdXRBWnUv?=
 =?utf-8?B?cjZYWm9vUWRxQzR1ZzhWVWU0dENJaHhCVW9wS3JBM1B2MEM2M3N0VGNHNlRs?=
 =?utf-8?B?a2pQT0wyU0NwOTdVSERwZC9TNE53ZXBUdXJON1lybE11Q1hEeDR0ZVZicmZt?=
 =?utf-8?B?VEVsdzg1NGgwd2NLS0x0Mm5YekZvNkZMK1hDWlFJRXplVEF1QW14VE5OU212?=
 =?utf-8?B?TXQ2NVZHWDhUbmh6ZTFsd29TV0ZoQ1VqTU5kQ3YyRkJYWW9vRnB1Y1VkbEFt?=
 =?utf-8?B?NmRyWWtvOXMzUWZVWUZ6ZzFJdXc4cWtoUGlQTTBSS2MwakpGRmxBemg5VGNJ?=
 =?utf-8?B?Qmp3ZHdEa2gyMnFHNFY2TS80VFFmazM3TXkzZ0R5aUMzN2FGNUZvOFdzNUNr?=
 =?utf-8?B?RTJSL1U4VDBkRW4rSDlMaVhPMGlRM2hteGJwQit0bm5DZnJZbG1LSjNzY0Ju?=
 =?utf-8?B?MTd6dDFKTHJyRXE2TUo5RlBtc25CSXhNNTdCMFB5WU9teTExdWZYRkY4c2tL?=
 =?utf-8?B?R0taaVc4bHpjMTJtNEFxVUNhS0phd3RXeHBPdTk5c1VFbU5KeXJPQnNVblRp?=
 =?utf-8?B?ZXRjREtzbWoxSFJOUmR0YTFEVUZHaWJVQ09tUDM5UmNHakpRVVdmYXZtZm5n?=
 =?utf-8?B?NUhKMTYyYmVTSTQ1QUtqdFB6eE05ZmpFTG1hOCtPbTRSR2RITHpOR2JBSlpY?=
 =?utf-8?B?VTljaE8rcVVyWDVNRkJ1N2VYV3RzanZxSXR0TUE1T2hUTDlzVE1ieGJtQTJL?=
 =?utf-8?B?NlVPL1BkcUVKekRDR3A3VEE4UElWbEFPR21rTExjWjI4U2x3RkFCZndpLzcw?=
 =?utf-8?B?MlJaZGtacnd3czRHZkZCcTN3UDE2eTRndEtpaWpmTDdOV1FJKzZwcFIyVWdy?=
 =?utf-8?Q?IwcpsZywUROhr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wm5peUdzNXE0eENyVS85UlZKTzh3TlAxeUV6MWx5Q0VQdVhhUEU1VDl1UnVE?=
 =?utf-8?B?TGdxV2RIQkliVmhmOXg0UkVUR3BEMTZDZjZvUlZlaXByVkc0WDBoelJDSVNq?=
 =?utf-8?B?RkJ1VmZtd0xzSUxtR2J4dVpZbklpdjZJV2ZXbFV2NTNTRktqejhhRDJUYTBS?=
 =?utf-8?B?S0srSFVGMDJYc2l6N2ZJVXUvVExDY3poRXBNUUdDdTYwaGVMUExBQUcxNmlV?=
 =?utf-8?B?TVpzbWgrLzBzbjBJbmpNeC9Ib08zWExHdDdicjJpa21VMjkrR2hKUm01V1cw?=
 =?utf-8?B?b25mRkxLNmlZVlB2bjRaNENFNnRMQzM4V0lSTUN1d2FtVHp5aldyUG5SQ0hz?=
 =?utf-8?B?a2pwMEpoa0U2SHJVQWEzNGRXNW1MKzZBT0NYa2pOdTNzQlFVSXlLOG9CNDZx?=
 =?utf-8?B?NEdIWTQ3ak5zVlh4N3JJME9oLzNaSm5tQnVaNkp2TlhwOFFCcjRFRGpta0VJ?=
 =?utf-8?B?UWV4Smc1QTVBTFg3Q1Zmc0tKRy8yaUVlQ2VTaVZjSVlSelNnd2dnQzdadmRq?=
 =?utf-8?B?RFhnUWo1S2lzM1NvVmJRSFVScktmakFOSGo5ZVkwKzBpekliNWtmZWhTemto?=
 =?utf-8?B?SVRvQ2QzK1ZyT09BaVE4YTFoYkVqb2hMUENFSFhGVGc5cUc1WS9ROWdsQmUv?=
 =?utf-8?B?dERjd2wyMzdBVEQyUWRiNTlQMnl1Z29KNjdSdWpzVExTczlmelFEY1RVV1Vv?=
 =?utf-8?B?SnZyN0YycXF2Mmh2MUZiMmZ5aEgvaWMzcm5QSnRGa0lMVmpHYSszakZqeE0v?=
 =?utf-8?B?RS9aYUgwbWhxVHdVVEdaOGZDU2Ywc0dVZVhhZUpuYWkrSDdLaVIzK1BPZFY2?=
 =?utf-8?B?UUVZaVBkMks3ZlVjVyttRW5qWGtIeFExRWdIRXBLSUtHUjk2RWRmVmcvbTk2?=
 =?utf-8?B?V25neTFxRFNQK0lqRHFHYTRQb2tmSkFZNDZiTkc4cXF3VUdSODl3aXNlRzlE?=
 =?utf-8?B?V0F6MmZNS0VLbStNaVY3RzcwWVNxS0RWaFMvZzJiN1UybHhHUmo0RUhLNEl5?=
 =?utf-8?B?WkRSZXRJVmxkYXg5K0ZzamVHck16K29WQ040V0wzT0lnbkNoa3Jmam1oYzFz?=
 =?utf-8?B?QzBVTGZHWE9rV3ovZWZmNUdmQTJDWXdUY005UzVYSTdjb2xaV0RwS3d4am5u?=
 =?utf-8?B?SjRTVFVpSENFM1psVEdYT1JucUtsOUZBWGpKWVFrZHRCRUs0VzhwUDlFdTc0?=
 =?utf-8?B?VGJpalRmWFZDQW9iRU5DdEtuZkEwdlBqVVc0MHFrMHlzNUUzN2RKdVhQSlVn?=
 =?utf-8?B?dDc4cUdZamxHYlJYdVVvT1B3UWNMRW9BUWY3b09IdnZ4NGpBZGlyRlp4d1Vx?=
 =?utf-8?B?bHdaZ29tWm9qd2t2ZTdvb1AvWC82anZIY25vNG84U2Ixck9oVnhDTFZ3RHgr?=
 =?utf-8?B?SDVtZUZXS3VqSDRPdXlNcU1OcHBXUEE0dnVpeDI1RFR2RnFEckFtVFlkeXBH?=
 =?utf-8?B?VDNJSWRJd3ZYQnNKM2szVmhOQzNSWTA0bmZBeUpwUmNPWVorU1pQWnBGcmQ1?=
 =?utf-8?B?eEc1bDVxVHdISXdJNVgrUFBLaFlrdzJ1ZUg1QlpRbUIyNGlORUl3dnJZUGlw?=
 =?utf-8?B?b1lhSXhRbkx5WlZxVnNGdkl1dTRiVkx6bkF5KzRCVHU4Zmt6ZlRTSTRqNm9P?=
 =?utf-8?B?NXpiWWtzVnBtcFUya3ZZcGNWNnlFYzJxSUNjcVFScWx3RGhxNmR5VjZkeFRN?=
 =?utf-8?B?WE85QTlXYzkxaDVUU01lTFM2RHJpYVRJQnRTTVFMNFp3R2xCZDgyZStGUXds?=
 =?utf-8?B?N3J6Z0VwUGdYcU1MV1NCTUZ6akRBSGUxZUplSGl0TEdHRDVkcUxBZ0xqbHRB?=
 =?utf-8?B?emxHNi9ZQUw2Z21RV1hDTFJCdC9rNG5INVNuWmw0MUU4WGp6TUhRZmVaaDh6?=
 =?utf-8?B?Zm8vU2JnSjJIRSs1Q3M2NlV5aXNYYkVXdkhkNlFsZFZtakZ0SUVDaDBSZTlS?=
 =?utf-8?B?bHdoTjQxZW1tWW9BbGdQNzUrMjdWQmt5QmtWZDdhTkh5NGpUVVBZWGNTUlJD?=
 =?utf-8?B?UVh4aWMrRDVoNnZhc3k3TjZHUWUyaUIvcDNTRTlRK2tMUE9Wb25iYS84SE5h?=
 =?utf-8?B?RGhDU0FkaFUxQThSZ1RjMUlZNzcwVWx5clRTVzhra1p3SWMzMElwdWk1TUJQ?=
 =?utf-8?Q?WljbCEkzRfbDwzzrwuqqgPTTA?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c601cca-5d81-4aca-c158-08dca194ec0b
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:33:36.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81aByObsU643hYePZ8m0WtDadfRwt3vOeQvWfzFauo8gVLM3aEvNfU0yWDuDMjlTCJe6ZgVM9RANur9Zc0PIMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7491


On 2024/7/7 21:10, Krzysztof Kozlowski wrote:
> [Some people who received this message don't often get email from krzk@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
>
> On 05/07/2024 13:20, Yang Li via B4 Relay wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> This patch introduces support for Amlogic Bluetooth controller over
>> UART. In order to send the final firmware at full speed. It is a pretty
>> straight forward H4 driver with exception of actually having it's own
>> setup address configuration.
>>
>> Co-developed-by: Ye He <ye.he@amlogic.com>
> Read submitting patches. Missing SoB.
Will do.
>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   drivers/bluetooth/Kconfig     |  13 +
>
>
>> +
>> +static void aml_serdev_remove(struct serdev_device *serdev)
>> +{
>> +     struct aml_serdev *amldev = serdev_device_get_drvdata(serdev);
>> +
>> +     hci_uart_unregister_device(&amldev->serdev_hu);
>> +}
>> +
>> +static const struct aml_device_data data_w155s2 __maybe_unused = {
>> +     .iccm_offset = 256 * 1024,
>> +};
>> +
>> +static const struct aml_device_data data_w265s2 __maybe_unused = {
> How this can be "maybe_unused" while it is referenced always? This is
> buggy. Either everything in OF chain can be unused or not. Not half yes,
> half not.
well, i will remove __maybe_unused.
>
>> +     .iccm_offset = 384 * 1024,
>> +};
>> +
>> +static const struct of_device_id aml_bluetooth_of_match[] = {
>> +     { .compatible = "amlogic,w155s2-bt", .data = &data_w155s2 },
>> +     { .compatible = "amlogic,w265s2-bt", .data = &data_w265s2 },
>> +     { /* sentinel */ },
>> +};
>> +
>> +static struct serdev_device_driver aml_serdev_driver = {
>> +     .probe = aml_serdev_probe,
>> +     .remove = aml_serdev_remove,
>> +     .driver = {
>> +             .name = "hci_uart_aml",
>> +             .of_match_table = of_match_ptr(aml_bluetooth_of_match),
> So now you have warnings... drop of_match_ptr.
Will do.
>
> Best regards,
> Krzysztof
>

