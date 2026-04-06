Return-Path: <netdev+bounces-275622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAOSG2fI02lNmAcAu9opvQ
	(envelope-from <netdev+bounces-275622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:51:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD38F3A4677
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 471613009CCE
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 14:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80270809;
	Mon,  6 Apr 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AIhZ8cMV"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010019.outbound.protection.outlook.com [52.103.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7CA2DB7B4;
	Mon,  6 Apr 2026 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487055; cv=fail; b=icCB5JZVO8CLg03kn09WSpRRmuw4SxZhNaayIjuRFG7liAQrrvTtaLy+oZHA5HaC1h+70xGrsMIStZPWCHdXzBvGmDBKY4SIxf9c0ORsDzcGq9wtQAva2Tfc3pI777XGngbc4eH9MWv/QfhkKq3oVtxkq8KOu5NFiIie71qhnfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487055; c=relaxed/simple;
	bh=7464iPwQFr0vxOhXXg46kWDSP6YLaY7vab07L/woBAc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uq1TA7ZtAXr0WHYMOEUaGGJdqD3TNO1r9mel/IBU6ReXsTCgVtSsGI0O5wTqVjHax/umd74kzuNT/6R6aADkND1HVpqUp5F6p7QXFM9oG78QQOgK0rr4/rHpxM65QcOJQQipNe1VWKGbvGBjdIxmH4o3lxUTh0I1bkziWDrAnJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AIhZ8cMV; arc=fail smtp.client-ip=52.103.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJJzpcHIH+ip8mWOTqWqsUqkgTWqmKHWjhtSyPDtl0f91d+n8seXGhSv7UwcgXPt6Ziax3n0Rby4KDrS4+kbuJGAQw5DlKC+duY6F9udyGxS+KZ+vv59XpmO6CsX8O4jIZq9yJv9EovmGv21MlEgDgC5t+vi4KyYdVZhhimJuqEL9ptObPlw1HfElDSFz3KrOvBeUk+FdhXZ09IBLVqH6VYhmlBBmKk0JDteDdlnceFf0tLA0TUzyRmBOmiBO/LzFvP+O4yQzXwRHsDp433VrQvgbXc7cV70H1Hm4LD8xQKJFa6WXv1WwseJs8zU4umzMoB84R3qo78CUYPs/V1IAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y36frxGWsLivSetFweD47CAfgQjU8xKg3CJeaCz+lEQ=;
 b=mDaLvQbO7AE+Rz73B2Mm5H0FzOlohtvpcLbCL0gx+GBOpO+emEqVT3LYbpQBUugoqnr0xJp1BxFK+qQ6/yIUsCoFWcXAuCFioAoSRI7MmC/BRmBcqtMPH742s8G8CgDI+lsGIiEPZDxfrrXn2KFSQyboqBDLln3dgWKcO1U8uEsoZ20xSpU3tN455s1NzMLITdgbgv8uEZ9rXmyLDUwbvg3iFLpmfRTfQzrVfyBhkvpNL+FZnZWbauXD0bTZHVoDhwEhsrZmOEj2oroQaR5lVxDDWfIgP+rl/3Lt4N7sB+85hiDyX3eWZzZUeGH5pSvAkQa0GGLRQ1s2MDHGqYQ5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y36frxGWsLivSetFweD47CAfgQjU8xKg3CJeaCz+lEQ=;
 b=AIhZ8cMV4GNdm9Kovj4sRCiZo92i3RzjXb/AbzD9dy/+k2biOkM05v+5IiFaH6Hji3FOjvWwskoyO2kFiT4Ka7joZORQ2ZBCscZLxcXHvTDN62Tyem30l2gI4ZMgLicqz2A5Rv/vd9U/HwOaVa2QamsPkTC+WFecDX0Jx/wskRd5ZoT033vNExXtLtpwO57lhWgNTxaeu97XNQgP7dix9Tj7r6dUdyNwhaPU1jL5DfZwKMxO73+vSauHJ2pGyv9FB0WpbrWPBmXjOah0qb3hSioa9GLDd2oTbI5naXvsrHDKed3152ncm5gIdPJOGgXTAh4FHhkSk+zMKMKYBN8GBw==
Received: from TYRPR01MB12666.jpnprd01.prod.outlook.com
 (2603:1096:405:1b4::11) by TY4PR01MB15568.jpnprd01.prod.outlook.com
 (2603:1096:405:28c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Mon, 6 Apr
 2026 14:50:50 +0000
Received: from TYRPR01MB12666.jpnprd01.prod.outlook.com
 ([fe80::6ded:56c7:8121:fa0e]) by TYRPR01MB12666.jpnprd01.prod.outlook.com
 ([fe80::6ded:56c7:8121:fa0e%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 14:50:50 +0000
Message-ID:
 <TYRPR01MB12666EEA0B8007166ED446088CA5DA@TYRPR01MB12666.jpnprd01.prod.outlook.com>
Date: Mon, 6 Apr 2026 22:50:44 +0800
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
From: Xavier Hsinyuan <xavierhsinyuan@outlook.com>
Subject: Re: [RFC net-next 15/15] Documentation: networking: add ipxlat
 translator guide
To: ralf@mandelbit.com
Cc: antonio@mandelbit.com, corbet@lwn.net, davem@davemloft.net,
 dxld@darkboxed.org, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org
References: <20260319151230.655687-16-ralf@mandelbit.com>
In-Reply-To: <20260319151230.655687-16-ralf@mandelbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0083.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::8) To TYRPR01MB12666.jpnprd01.prod.outlook.com
 (2603:1096:405:1b4::11)
X-Microsoft-Original-Message-ID:
 <3709e5d3-99d4-41b2-899e-4b00d9ca9f6c@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB12666:EE_|TY4PR01MB15568:EE_
X-MS-Office365-Filtering-Correlation-Id: 5001e310-9fdf-4dcd-7cc8-08de93ebe4c6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|23021999003|8060799015|41001999006|24071999003|15080799012|19110799012|6090799003|5072599009|25031999004|20031999003|39105399006|55001999003|10035399007|440099028|3412199025|4302099013|26121999003|1602099012|41105399003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGpETzhJOXR4Z2NXNHhMak5jUThXYkZZSDZqbkVvMTlOV2RuOGlTZkoxb3hu?=
 =?utf-8?B?bGRhbjI3Y084YjNpNjAyeWl3anh4Nzc1cm9QeFczVjZ0KzdpcGVkSlpkMG9h?=
 =?utf-8?B?MCsrVXRpUk9wQ1BLOWlrM3BCRkNWbEx5Nzc1K1lxQlY4VTg2Rm8xRmR1RGR0?=
 =?utf-8?B?UzBkS1pZR1lJdmdGVm45T1dWdzI2SlZMZ3NTOEZzSUhJV0QwMkpmcFNSb3NI?=
 =?utf-8?B?emQ5aCsycEVFMW5nRmg3Ukg3QmJ1ZkZzUFpKa1VaS0xpK1RlVUlOT0tlejdh?=
 =?utf-8?B?bUxFRkUrZ01SOUxlU1hIalk0UHFhdm40S05xUytCN2xtdmlMS3FnSnB1cW52?=
 =?utf-8?B?RW9PdkppRmVWVWs2MlpDZVk0VWhaQ0t4SHRKdGpJeGt6aHlJWFdkcmswRnFN?=
 =?utf-8?B?TWt6YTZ5dDRzNjhFNVppOXM3TkI1eGt4UTVhcXZ2R2NNS0RqMGh5akwvSHJh?=
 =?utf-8?B?QmlJV3hsVVE5NE8zY21CNHcwdWtoZ0Y0UlExWDYyeStkMTRta0RtU3o5UlpM?=
 =?utf-8?B?R1pNcU1TUXpxUTMzbkwvd004NUJDQlQwVTU1Y1k0dkttOEtnQzhxSHQzdkdy?=
 =?utf-8?B?THhhMEsxK29jVWR3VVNSOVV3QVJ5dlZ0ZEpQNHpJSGc5bGE1QXJmRUFmQW5l?=
 =?utf-8?B?OFc5bVNYMWFDTE5iV1lBU2NhMldYWFVvWGM2blNaTkdUdGxpWXpNOTFBOWtV?=
 =?utf-8?B?M09pQU52dVR0Rkd6dWxtL0p1Y3M2R2ljTEFtT0FkeWRUdm5QbitEcCtkWnFh?=
 =?utf-8?B?cnlUWndGWGg5WVV0ZUhicm80S3o4c2pkWEVpQ2tocXdnendGNUo4U0hEZ05E?=
 =?utf-8?B?RXBnS041LzZDb3pIOE1qN05zdzZyMnRXeERHRUU3TWt0dDJlTFI3QmcwVGFM?=
 =?utf-8?B?T0p3ODlIRFlJdjNPeW0xVVZSV3BTalhJd3Z1WkRQYW1hc3d0cUlMWWF4VmlK?=
 =?utf-8?B?cjhhUXZhOHl0ZWFRdE1JNVk4bXNNbUJUVzJqcm5mSm9TK2RwaG1SVWR3RlNH?=
 =?utf-8?B?ZjdNeVh6VitLTzVxQ0t3cjF4MEVLQS9uMnNXSjNkcXMrVkJtZVN1ZDA5bFdz?=
 =?utf-8?B?ajNUQmdQNTgwb3cveE5CODVQeTJZNDZVTFBjSFRyKzhRR1RaSE85V3V4VkVZ?=
 =?utf-8?B?azFzaEZOblFGMkdGRlBjVVpLUDNaOHh1dXQ1cGw0dHRkZzBSNDlTUy82TUtv?=
 =?utf-8?B?Qyt2RjhEb1FVa3JVOGRhY3pzWXNkYlpoUFozQmxnWCs5U28vbG5YaUxQemV1?=
 =?utf-8?B?RmxXZTF6alFNaWFFd0ZDcnZva2xHbHZ1SnBnU3VaRzFIQVFveUNWMkJHanR3?=
 =?utf-8?B?UDZqRVBLMjNwUW1iRGRrUy9kL29Xekw4VGViWmFTQ04wLzhyQUFUMG5veTZr?=
 =?utf-8?B?YWpJUHd2MVVKMG56MXZ1MldKcW4zMkQxRFlmaUVGTlp0RjQwVTlJZDdHT1Uz?=
 =?utf-8?B?S0NvN3lyQTdPRXF2ck00V1VKWTU4WktvRVg4cENkamVBc2ViSHpwU2orVWl0?=
 =?utf-8?B?NFhDb05BT0t0aXdaejNTbmNaMzZNQW1UUS9IWi93T2xsOUo0cFFRWU9Wdjln?=
 =?utf-8?B?alZsOE5TTzd1QmpvYys4YjZGNTlUemJsVFpFNjc2QjNUS1NFTGxSUUN1MnBK?=
 =?utf-8?B?SzRtd2h6ZzlMSGpkWU5lOVFkQ1VkMFlUeDM3Y25zVHRXdllXM2NMQUUvRWR5?=
 =?utf-8?B?elBvYm12cUpZU24wOVJ0V3BGRkR6OURVeVQ0cDJtcDR1TUpkdDhlbEhHNEI1?=
 =?utf-8?Q?P1Eg7gZqw+RNUN8gLM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlFmYTl5dmE1YkMzK3RjV1NURERNNHhER2xHUlgwZ29NNlh5TnRHTGh0WVli?=
 =?utf-8?B?alRBN1Urb2pHMDU3clo4MTVxZGoxNzh4ZmZUTlBNNXFGTzBXYVhFS2hiR0Z6?=
 =?utf-8?B?RjlJcEJFZUQ0YkZlS0NTQ2NNTWRPcHlZczVmZklEVVNLa1VmR1J1RVF6dGpW?=
 =?utf-8?B?aHpKUkYrWDJZRTVrYitGV0NFTldMRjBXMC9WT3dIemQyQUViSWhtOEtmOGpD?=
 =?utf-8?B?aFJhdmswTFlZcGJuaFZndnlIdWlJL1c1Vm1NdEhGVGYvWEZwcjFKVDVTYkRB?=
 =?utf-8?B?NG1hQnpYNGc2M1EyZ0NZQ1pkL1o5WDJ3c0xjWDVhYkhiNUpSQ2FnTEtjZU1o?=
 =?utf-8?B?ZlhZajgzTXo4VnRVYXNCREVwRGFrRGl1N0RodS9weTBiK1ZhVCtubHYxb1VP?=
 =?utf-8?B?NFRaekxTdUdJMWY1WEVrTnNKWTdDdXo0VkpIbTFXN2dWbzFWVWNuRC9ydzNx?=
 =?utf-8?B?cU1FaGdNbHZUU24wMFZwL0Eya0dwTjJhWXRFTWd0VG44NVB1QWlKTmFJK2Mw?=
 =?utf-8?B?SUE1NVAzdFZSUDJwbmdQVnA5SHVJMVNRaTMzWHE0ZkJQYnFVbldOcjZnKzJa?=
 =?utf-8?B?eHNHb3E1WGY0MEtHcS9VbStnWE1FdDVCaS93emxEcW04R1RXemdvckRaOUZ2?=
 =?utf-8?B?SjlmeXFCZVhhRk8vMUtKTWxJNFpzVjYxSGl0OWMwQkJJdWM2U0ZzK0Q5a3Ry?=
 =?utf-8?B?aXEvSmlhcys2Q3hpeXBwWkZHQ1paTlFGV1dnTkhMNEtwMnNXUTQ2MTl5bE9o?=
 =?utf-8?B?cEN1WnhFWGt4aW16dFlRNGZsdVJSa2dvdndpMi9RT0xxWkFpVFBYZzI1UTlm?=
 =?utf-8?B?czdiRmFta3ArV01NSlVxOHZOUUtvVHIrVjhXVGZDQ09PcnlWTDNpU29mRkNV?=
 =?utf-8?B?Vm1GQ3hxWVpNTDZNa3ozbDdtNVF6bVF6MDc2RStCMHpYTjRSOEJpYjVaWmRi?=
 =?utf-8?B?WlhJWmlmd0RtNHdDaitRVDg2cW95Nk5tZVBmcEFUbEd1Uk1jcTZPV0NLRWg2?=
 =?utf-8?B?eEVvUjRTN2xuQU9uV2xTb09ZOUpvUDFYdUVmdWZob1A4RDdjQWhwTkIxNXZn?=
 =?utf-8?B?TUpIOXFyQ2lSTHFUMlNEdE51Mzc0Mk9Db204M3RjQTdrRUxPZUpCeS93dXhY?=
 =?utf-8?B?Mkd5ajc4NnlNT1h5VUJYZ2RndS9sYzVBbk0rME9ZQ3dJZW1aYzNnQVpyRUtS?=
 =?utf-8?B?NHJkTDlGSU93RFlnbHNkR1l2ZTVuaDg1NkpSTS8zNmx0U1pIVXZzblRBck9C?=
 =?utf-8?B?YmNRNDRYNDFwZmlEVms2WmJOa3JoWFRTbm1JOVpkYWhXNUJJUW1CTTFNeUoy?=
 =?utf-8?B?RVR1T1k3SVpuM1V6ZHVzYUpzcXlBWEFkV2hrQ0owVjFoTU4rNkprUmJ0SVVi?=
 =?utf-8?B?cHpDR2duQnc1TUtDelhDS25TaWM5SDhVU1BoRnZCVzNieWNxTzJHb1psMW5q?=
 =?utf-8?B?dysrQUQwZm8zZHJZNjI1WUc3TE1WZTBVTTczaFN0SGdkZlQwWndFbjFYS3p0?=
 =?utf-8?B?WWVrdTViamZycVo4MHdZSis4SVRSekhlcFZscGxzaXVYOFFLdS9zaEZWbFNz?=
 =?utf-8?B?RnZMQ3p6K2YzM2xrUHhPZmk3eTZvNTFOdDZBa282NHU3ZEFFbWw3Q3dtY3pu?=
 =?utf-8?B?cVlZZmxSeCsxTVlkREFselZBaUUrRGIzR05NdW5YUXBJQm5qZDFvWlUzYjlN?=
 =?utf-8?B?dEVtNk1uTWE5NnRubld6ZXgwK3ZlMTdrM091Q2lUUzFBVlJLeXZZV2N4OVkw?=
 =?utf-8?B?anhUc1B1LzF3QTRLQkhRTFl1eHNDY0ZXNlBLQ25QNzhpWGVoRmJsbDZqcDhj?=
 =?utf-8?B?OWdXeWpFdmRmV2t3Ui9EMnF6WFlCek53Z3VFVUNVcmNLUnVDd2g4SGZJemVK?=
 =?utf-8?B?c3N3RzExS2xBbk5rc2V6YXpaRDdVOEtXU2FtV01kVFlnd0h6RlJGRWtKMXRm?=
 =?utf-8?B?eTN4RUVXODlmS3AyQXVRcFN3WUhKbkFVM2NoQmVKdXFuUHZkVkg4TmpqOVEv?=
 =?utf-8?B?RjVuSjdXVWdRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5001e310-9fdf-4dcd-7cc8-08de93ebe4c6
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB12666.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 14:50:50.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15568
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-275622-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xavierhsinyuan@outlook.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,ietf.org:url,TYRPR01MB12666.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: BD38F3A4677
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ralf,

>+    $ ./tools/net/ynl/pyynl/cli.py --family ipxlat --json '{"ifindex": $IID, \
>+        "config": {"xlat-prefix6": "'$HEX_ADDR'", "prefix-len": 96} }'
Should this be like:
$ python3 /extends/pyynl/cli.py --spec ipxlat.yaml --do dev-set --json \
'{"ifindex": "'$IID'", "config": {"xlat-prefix6": \
{"prefix":"'$ADDR_HEX'", "prefix-len": 96}}}'

>+Address Translation
>+-------------------
>+
>+The ipxlat address translation algorithm is stateless, per RFC-ADDR_, all
>+possible IPv4 addressess are mapped one-to-one into the translation prefix,
>+optionally including a non-standard "suffix". See `RFC-ADDR Section 2.2
>+<https://datatracker.ietf.org/doc/html/rfc6052#section-2.2>`_.
>+
>+.. _RFC-ADDR: https://datatracker.ietf.org/doc/html/rfc6052
>+
>+IPv6 addressess outside this prefix are rejected with ICMPv6 errors with
>+the notable exception of ICMPv6 errors originating from untranslatable
>+source addressess. These are translated to be sourced from the IPv4 Dummy
>+Address ``192.0.0.8`` (per I-D-dummy_) instead to maintain IPv4 traceroute
>+visibility.
Would it help to add a few example? For instance,
 - Interface ipxlat0 with prefix6=64:ff9b::/96.
 - A IPv6 packet with src=64:ff9b::192.0.2.1 dst=64:ff9b::198.51.100.1,
   was send to ipxlat0.
 - Then a IPv4 packet with src=192.0.2.1 dst=198.51.100.1 was received from
   ipxlat0.

Best regards,
Xavier

