Return-Path: <netdev+bounces-111686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F419320D4
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 09:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D301F21BC2
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 07:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F0F1CF9A;
	Tue, 16 Jul 2024 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="FTJ79lCA"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2135.outbound.protection.outlook.com [40.107.215.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1EC196;
	Tue, 16 Jul 2024 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721113224; cv=fail; b=ibFr++Gt/Irna9CC0V5goreCT3Psg60OEfnkHO3dxIq/EnSuVb3Cp61w13e7XUd4hJ1Ru1WdlfEqafXCE/nBhqTfTDpJeYvwiuGziKRfCH0txt33TEy7yfNEyWgBClFeaUSo/CAgXmgpg3JmWYAhdfSa7F4+uq7bYX55dYrRR3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721113224; c=relaxed/simple;
	bh=RNUEmOaoXHWw0erqTMa4JO0uXQCw3XbwC/mnCOwPink=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rzQRT8YIc8pzphn067avVJzBP3CrG/AREqe+uLY2z8HTob/YoOwF3LoRnO4qwrL2Wk63QTXv+eulrR8kgng5dmGjMqfa4wF/plUJJCPcyAvLS4T3QWlpQp/fVzkh2x8Kh77Kctd+LFPOsihjn0oH+rdBXqJfzQmPEv2uLLT3ZLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=FTJ79lCA; arc=fail smtp.client-ip=40.107.215.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3hOQLFw5xEx9p4HfZsSi2cXHKjZ23BqKOrdMCnRCYDKSXbs9hsikSy2OKOTFTgS3TclCcorikklzl1ho87TD2KXd77/R6v3wrTP6sP5N1svxyEl3aYN0nTHX/U+KXH4qaJnnuA0YkBmugI3AgZ0HuvXQKDU/bA/k99qWji/IfH/sFEfmtYe+eYPo/aI7FqxP9NMrbYTOFRRQsKAbFQ9CMwi1FqxHV6uYG13I6l50zEb32vr0fHiX0R4Yt5DQIo8hLGyohRuWSrWnKAOOQFeYuh7YQyc/tQPsDIg1ceMqbJjyLn1BSw/gdpAaJiZRP68YJCYfLPmk60nNGu/BlKdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqHTJV9kSan5nnod1NtAj4qztebsTWujOfIQ3Iojxw0=;
 b=S95tmcI/hTuw8vuMpZIaSDWS0UMoKrjWSvH0wK/AEf8/BciGakf/q0xw0vpIhYrXxa/sONKnNz/UZjZDB3pT7vkTNx8w3VOVpXRHLDWSrujnQKK6HhmhIh0AKM8zzl3preHrS29PQekzssou117N/HSeHLwL8cQ6C/IMRixpxTNf7GCP62UtfWtXPIQZuLZ9d1hF+76RXZsuoGD+66Hf1jOXvXjGgpwudXWGPoFSoDcQkI0Iq2ysC0gBrvYRd21x/xt/mkSvVWSKR9/LSBg8zJNrTQT7ovCyGKmuuR6XTH5LQ6QetjN5EG2QMQVA2eGGmt0HeBotv7PXYYtfMC1gKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqHTJV9kSan5nnod1NtAj4qztebsTWujOfIQ3Iojxw0=;
 b=FTJ79lCAqd/wN32yRZOhSQDJPF0NVLgtIexgK7aPe1pkzIRM4wMU/oYc8oahXt9sRsFo/tYnXd+rvm1N5DJH3EkDtYCYauKdjXi5svRJnSN8tUrO1cvTLJ0Q3rdXOWGRxHKMnjWO1NLwgSorMMs44lg+s7FCyVUcGJ80k+DRv1MZAKWEBRGNGMS4b0/QoeyEFtkppM7ewncXTff1iOZewXuM6Ky4zw2BkP7UBEKQ8hupEH6bcJ4fUcEsgZVcsIquEbzDFQ0ApS9VbfNamkf0bZKLbs9xFC9rPG9Ev36gAYAfnZ44cU+/AYS8QiL0hUza8EJsj3sql1rIjsIEEfHChA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEZPR03MB6443.apcprd03.prod.outlook.com (2603:1096:101:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Tue, 16 Jul
 2024 07:00:17 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Tue, 16 Jul 2024
 07:00:16 +0000
Message-ID: <db340e82-aba0-4ec6-8ab9-622073c43226@amlogic.com>
Date: Tue, 16 Jul 2024 14:59:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Add support for Amlogic HCI UART
To: Kelvin Zhang <kelvin.zhang@amlogic.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240716064346.3538994-1-yang.li@amlogic.com>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <20240716064346.3538994-1-yang.li@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEZPR03MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: af9d264e-3d39-442d-6a09-08dca564f20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S01yQmkvNTY5RXVpaTF2SzFINlNnc3I4c3NoaVU2YjhKclc4K3V1ZG9Ubis3?=
 =?utf-8?B?UkNha2M1ck42Y0RMQ2hIOVB0eE1aRzVNZ20xdE1nZ1c5SFZZYjgrRDNOVWZO?=
 =?utf-8?B?WGxzUDFOUmFLdUp3c2NLMnVlNmVVaVZJWG90NElMMStZenJQbEk0bzEvNHNV?=
 =?utf-8?B?OGppb1lZR2xoVXV4WVNJUUdGM0NnQzNUVng1RHQzdWFEN2ZvdVM5cGl3TDU4?=
 =?utf-8?B?SHVkRWhDaWo4d0VIKzdncW10bmNCclJMRjM2WFVZazVhZkp2QTVlQldmVm9S?=
 =?utf-8?B?YkNBZHRHNEs0VUhTRDQ1cjhNRW54L0VHMnE1Nml4NkhKbm02aGg3bjBOYUo3?=
 =?utf-8?B?eDBqN2YrdzZSdDBhS2M5cDRma3Y3VkMyRlV3MTZJcHdHT1pHdnVHTGIrcmJm?=
 =?utf-8?B?Z3BVRkY1bFVzK1E2UzRvQzRBakV1eVR2WWlWMm1oNllWVjFNU0JyaUtCQm8z?=
 =?utf-8?B?K1ZmQVJtK201REZJVGtsZ3oxajJBamtEajRmY3FOclZNcGxjOG5JMnYvQ0k4?=
 =?utf-8?B?SWpaMUFnZWhtb2FLZXV6WS9vbGF5SDhidnE2UnpGUGxFVDVQQWc2dUtENDBu?=
 =?utf-8?B?dktsSlh2STB0NTNrTnRoYmdhTm5MSkVxd1Awd1dHdjhxMjlZYWZWSVUzaWNZ?=
 =?utf-8?B?ZEdITUU2eU56OFJvRjJLcUNBM1dQMzdLOUk3bkJuNEdyZjdBWHowaXB1L0xD?=
 =?utf-8?B?N1h6YTBmcFQxMlBuZ2U0Q3VEUjJqQlNQWDJFRys1TndQaGRhcjFMMmIxRFYz?=
 =?utf-8?B?UGtwdERHOUZVWThWOFFxQWhOOUczNjRmdjgxWVdmc0x1RjFtOU1iMkljVlhs?=
 =?utf-8?B?eCtRb2FidzZLcjRoL2lkMVo2ZTlZbHJ1QWRwY2xpOCtCZ1RiZThTYlp2QXRG?=
 =?utf-8?B?bVVHVyt5UzlxM05FSnppZDd4eUlGd2VMc2k3OUtVcjlQclJQazlJUHN1VVky?=
 =?utf-8?B?R00zUU5zUHVwM1FKUWx5T0xDMmFzcHdYemt0a2tHSnZRbHRUZEpBSWRnajVH?=
 =?utf-8?B?T1E1VnBNem5FZ1NINmF0WVFVYkNXeWI2T0dTZkllMitVVUhVRDhPSXJ1ODJP?=
 =?utf-8?B?azZzNmozeThLbzlaVVRWa0U5YjFEZGJpKzlKYTVHeFA0dTUvWUk3VTI2K3Z5?=
 =?utf-8?B?bnBkaHlWUXhjdFovdE5PTXpjcG5NM2QxSWtXbGU2R2JCR2dnaDRmQ09EMVQw?=
 =?utf-8?B?aTFURTVETnpqTVVITTN2cTdTZnFWRU1yOW5FbURlNTFtN3dMTk0xcm9pMnNr?=
 =?utf-8?B?WDg0QWtldm1lQk80bnd4UGpoamlaWnlCQWpCUjgxTE0wWlc0eCs4TW1naTZX?=
 =?utf-8?B?Y0hCWXhuemtSdk9vem5QU2t2RFhHbWdVL0p3REFCKzd2dkNOZnMyN0hNaWUx?=
 =?utf-8?B?T3ZVQzFyQVFxOEpGUG1rdjJreWVZSUdOWEpQT0Z1MmVkRmFTZTk3M0E3TCt1?=
 =?utf-8?B?Y2l4WjcweWxWSDlWVm1FbHVnanlYNlZIUkFNNjNxSFFWQzh6dG8yeWlmbHkw?=
 =?utf-8?B?VW5BbC85NlhiSW1OZDFaUDhZK0xLckJGQXBQSG1sS2Z3VjRzMnNoUExVZzZ0?=
 =?utf-8?B?VGNnNmg0MS83bzd3MFdBQ3BMNUNlU25HWjV5LzJ4Y20vOUUxVWNMemFHUWxy?=
 =?utf-8?B?eDNaUmhXWE1GcE9TOHFjeWlDTEFhNEd2RjUrVFhXTktqeE9XMmpSZTFGMmFP?=
 =?utf-8?B?SkdKY1lneXVrWkp4OWs2ZzJKZy80NE1IMWhKUWo1WHgya3hlQW1oZGNBL2dS?=
 =?utf-8?Q?eqrh6UDMui/7PydrsY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnBXeFhBSk5HY2JHUm1hNEl3bnJyZnFDZUNWT2FHLytMMW9hTzdySDhzb2t5?=
 =?utf-8?B?UXRUYzBCdmtjalJNSlkzc29nRVk3K3loQ3MwNENwdm1jTFlyc0dBVGZJbUZh?=
 =?utf-8?B?WVY4S3pHKzNZWXBwaTBhZDM3eC9iQkhsU1ExZkUwT20xNFN1WmoxOFVKODBl?=
 =?utf-8?B?NUd2L2NSVlBWZ3gvN0pXNUNSSGhXMFpXRnN6dUJKaDRvZXRteWVFcEVlTWND?=
 =?utf-8?B?WktvSGRYRXhWZDJJN0FOb1FxM21ycTNpOG0vWEwxYzMzcEQyazJwaWM2M25s?=
 =?utf-8?B?SGhmQUtzazFBWnRNSlFDWGdJdzJaVDFIL1c4RW1KclZwMkhaMmw1SzdFUVlC?=
 =?utf-8?B?OVJkVWtndld1RFZyUW5IYWQ5elVPSHhXSjY2TzJxRVUrRnI4cnpIUWlyc1ZD?=
 =?utf-8?B?Vklka2JRTVhNeGExVEJjQ1dyN1dtN1Flcy9HYXltK1hLb2FkaUt4Ri9lRDY2?=
 =?utf-8?B?NzUyYUoxcnRYOWJzZ2lXbnNlZ3QvQjFIZHJwUVp2N0lUV0xZMUc5ekVkQXNu?=
 =?utf-8?B?bGZyL3N6QWNpZUxESHpHZlpJb3BWU1lTcldYSUJ4c1Arc1JFNGQxWGhobjNz?=
 =?utf-8?B?UDUyeGltRWg2TkoyOFpDdEVGRXNvMlZMUnR1OStFUnZFV1lmWUpPR05xV3ZZ?=
 =?utf-8?B?R0YvVEFXeTE5c2hVWk9vRFVoUUJyTWt0YXk2a2FCYmRpQWh1RjZXWXBEalVK?=
 =?utf-8?B?U0U2NStHanNoQy9VME9kQStIS0lsV21YL01ZeE1KZ3NHeEhOVjV6ME4xR3JQ?=
 =?utf-8?B?bHAxREQ3WklOaHRpVGYvd3Z1R2ZMN2tvWXE3TnB5OEJqNjBBblNOY0c4M3RR?=
 =?utf-8?B?R1d4MHEvMnh4SVYybTkwWVU1elNVM1V2cmxCcW9RTStOVVdZWnFiN3R4ZnNY?=
 =?utf-8?B?QUtQeVlmUjZ1U3M1eDAwcDBNWDNVQWpxU0V5MVFROUJuOWpXV29Gc3FiQmpH?=
 =?utf-8?B?elZ2UDlsakxLZjlLVkg4bDE4d2FhSHRva2FqTERIVkRRZDRJajBhOUZSU05r?=
 =?utf-8?B?RlJCVHozQm81OHo4UTNETDZYZlFiN3ZhYTR3bTNQRytuL2s0SjZWa01RR1lz?=
 =?utf-8?B?L3NhL3FLNGhrbnRCVURmMjNxVFI3Sm1WeGJmdk5UeUNZelBkV0drem9nZkVw?=
 =?utf-8?B?MWhTRnVhR3ZMNkVHK2lyQXJHVWFCS004NE00dWdHOHl5YXk3eTJNNTh6MGlV?=
 =?utf-8?B?c1dKeHpzaWxDS2hMVzR1aWtrOXV2dy9Qc0E3QlpKaEpGQUs0V3hJQkhMbE44?=
 =?utf-8?B?Wkt2WlR5SWpUdG9HVzNjbUJITFNDd2J2YlM0ZXNTbUFGNmNmRWVzYWpoOEpG?=
 =?utf-8?B?eTI1bUI5bVJGTHJEaVdUR3h5NnI4RjFxVXppYTVhQTg2NlBVY0NPV1ZiZ1hQ?=
 =?utf-8?B?bFcycXJsb0pPTlZhZytqSWlIaVFXejkyOXpQNEx1M29DKzM3UjVvdWI0a1hB?=
 =?utf-8?B?MHNrWkJCUEttWjQ3cXpJQ1ZZWEFrcWZhYkZjd0ExK3IzM215eTVSeHJJbDdQ?=
 =?utf-8?B?eHBESXBIR1FPYU9LRjkyYlJvWlp0N1k4RDZqMC9ucWNiMGFsZkdJUjV6T2FP?=
 =?utf-8?B?Q1M3RTYwVW1iUkswRnVSRDFSL2s5NjN0bTYvbEFKR1RQL2VLZmR6MSthM09q?=
 =?utf-8?B?bzQ1Qm1UU3ZnM3dLbnRPZnNBYTM0NDhYSDBIMnNvSThFcEl6eHRwMFlYY2lW?=
 =?utf-8?B?a0h3Umg3SjBpK3Uybkp3ck1ZMHh3dVVsV3kyOFBodFU2WC9sYUw0L3RWZTlr?=
 =?utf-8?B?aUFFZzFEdUlnYzhSOXNBa1pXeDhOc0ZZMldVMVVuZEQzUWQzMytPeFNScFpP?=
 =?utf-8?B?dmZoSmliMTBFdHIyK1pkTWxMcVFuT2JSZkIvdEZzVmdadGthTjBIUzN4QTRQ?=
 =?utf-8?B?M2ZsSTNlVGZ3WjUxR0RkNWswM2FaVncveHZYVjM0aTdNM2VNYUFEYlFHaUpF?=
 =?utf-8?B?Q0x5Tkl5cVU3QUYwcGswc0NlandzU29yZWNNdGxnTGVtOVNreEFuTm1QQzZN?=
 =?utf-8?B?U1N3bTJreVY3YVF3UVlXQXVDSjBGSUtEV0c4K3ZqUTNmK1RVSjFKZjhpZk82?=
 =?utf-8?B?anBpSFE2dnB4K3BpblIvN1A0YklIbDFwTmY2cGxTKzVNZWF1WFlTYzQ4ajFy?=
 =?utf-8?Q?AVObjXR0AcC/YLLAKSroVGHtN?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9d264e-3d39-442d-6a09-08dca564f20a
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 07:00:16.1118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bi+7qp5HBeNxHrgGtTCS/e9d+liicTqie60noq4HJlQuGOqwmj1cdi3rpHvoIVH8pv3ZTaHJRpANDajwBiwI4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6443

Dear all

I am very sorry for my mistake, please ignore this email.

On 2024/7/16 14:43, Yang Li wrote:
> Add support for Amlogic HCI UART, including dt-binding,
> and Amlogic Bluetooth driver.
>
> To: Marcel Holtmann <marcel@holtmann.org>
> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Catalin Marinas <catalin.marinas@arm.com>
> To: Will Deacon <will@kernel.org>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Yang Li <yang.li@amlogic.com>
>
> ---
> Changes in v2:
> - Employ a regulator for powering up the Bluetooth chip, bypassing the need for power sequencing.
> - Utilize the GPIO Consumer API to manipulate the GPIO pins.
> - Link to v1: https://lore.kernel.org/r/20240705-btaml-v1-0-7f1538f98cef@amlogic.com
>
> --- b4-submit-tracking ---
> {
>    "series": {
>      "revision": 2,
>      "change-id": "20240418-btaml-f9d7b19724ab",
>      "prefixes": [],
>      "history": {
>        "v1": [
>          "20240705-btaml-v1-0-7f1538f98cef@amlogic.com"
>        ]
>      }
>    }
> }

