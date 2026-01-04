Return-Path: <netdev+bounces-246818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1835CCF14F5
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 22:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89EA0300943B
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 21:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA14D19E96D;
	Sun,  4 Jan 2026 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I/j5pWBE"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F806A33B
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767560839; cv=fail; b=Y9HcqHSpS5j6XXAEu8keZRUUeAktH9Tqm4fnqr41uJJojeLpFA0uESU/XPvG2R9CPqObzmF083Pwz2r4yiOPsPLy1DbIB6pauulBQA1TMdCawYdY+RxciIP6Caa28q8E3Z4UuKwfcJqOUatFnka2T+yVyxOA6h2C/3lwZtK58xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767560839; c=relaxed/simple;
	bh=NY71nvsXImNWqIaMStXGDiiN2rOeuWPQQm6RDzuhN18=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SHxI+wTm2fuiVemncTO4CGk/CVDqsMx346WltWQlzWVlhPqlS7YpYEJJ4getAqPzoPYdAqdYapWyCWZmK9t3u3n4dbZP4dzmkNcLjNKwffQz/R63r8vV6beyIcOkbFoGX4Jl/QtItydtRU13TQ99jen14qauM1FbirXJkeq1rwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I/j5pWBE; arc=fail smtp.client-ip=40.107.209.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvYNwSlHoVlDIFKKDML+qcvJq/E/O5EAu599TB5IcxNtx6o4w2t9+JDpfgjchxeKKcAtEjRABnYmGjcKFOFtfO66g/as7E5VrxlCl/1oniuZxr5bMuS+2+bNN2MsQto79IsPQwnk6lv/v9EPu9oy7JApLeOhFoNG1RcuiuYOuyVboWI/zbe52Jez3tbZYTU0FYPFdUXP73qTdiZl7DSBHe8nzQrbPh79IL5GrOnpBoYxJuF6E+tSXyeKliI2sQBPYQDUTYI0ECMqIu5IxK3Std25OMPy4G3CJUKVUl51kcc1l2mkLZdln4sYEOVnVL5oy6HojnDev4asS9p+ZkjNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lan4aOoAV+7nbQooi5fdLiGUN3MQbrAL/XPB0AI/VWo=;
 b=gFPxpX2rTwZTKyf83q4dIZLw9ESRcPObeF9a2pcv38xIg1Vus2hPVfqvvSY1bx2OMIFStgTSbDlzXFgB8xOjDc9vsuoqEXi1SANpjftc7TpetKQRr14EGeMocsu3vpm7pSDbXemM7gs7rXM511OARAogZ5fHHgN4uZvaM9D8qS9G/rXHsdlj1lRTRAnvoV/pYFfcdzlvDhKUd+AYkfLMbJIbLAvbPKlpVkSDXv5uB+rE1lTnoiQSURGdcAVMJLUybxKmiOCu1wQEVhf2WWCvlK53DXdg7aQTy6JLZREOgqWuDUph1YSdcoES2M9QTxHofoJxBGeGtyzvBraQ/4TGrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lan4aOoAV+7nbQooi5fdLiGUN3MQbrAL/XPB0AI/VWo=;
 b=I/j5pWBE0Mn87wMu/Uc3s8m+GFwIAtXE6sK1bt6PSHd/BAVBYp1nJIMoZJtJJiELbW2iwt8TRGXKhOgyEnQ4WyOhjsZkInSuZOLZrUsHDNgf3UQd2a5mEOzT4c5ITp5vaSxop19aMj/XESIj+/c7juX6uDJgsC2QUneSxC59ss9VcDlXPV8LgM5cyt5AgcLjasZMxhuRy+TCK9js4zrIVE2/AK0sWDaK3yrCVYoRAmeRsTKsUlUh42oDShluOQaifhyPH/7Hq1140WUwpi+f6/4G+VPNf2/LHHZjZIIjdYTVvuIy2Py2e+CihRMmPF8dKCpP5++CrsIRYehcYvHNgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 21:07:13 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9478.004; Sun, 4 Jan 2026
 21:07:12 +0000
Message-ID: <1affa813-f977-4815-8eef-b4701785fb11@nvidia.com>
Date: Sun, 4 Jan 2026 23:07:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mlx5: TLS 1.3 hardware offload support
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, borisp@nvidia.com,
 john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net
References: <20251230224137.3600355-1-rjethwani@purestorage.com>
 <20251230224137.3600355-3-rjethwani@purestorage.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20251230224137.3600355-3-rjethwani@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c903f2-7c54-48ec-8a41-08de4bd53b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGFBOHhnSFBHRmZuamFwbStDRmhIUGZaWGFnbEsxRGxqOW9MRUFScXZ4NTlZ?=
 =?utf-8?B?ckdSUXcwcUZ0RUdiaHFtSDRVTTRteXdEZitBeForeDI4ZlJnTGNNOEtISzhV?=
 =?utf-8?B?VlBSTkhTUTZEcDA3ek5HRmVBTGxaeDFhUWtjOTNmYXplQ2hYUUNBSmVWZFEr?=
 =?utf-8?B?N040N0hTNGg0aklaZUVPSVg3cktSNHRCMmNCYmJLSXVBWTdxUXkrL1YxQ0tT?=
 =?utf-8?B?SmltMEpWRnhWdXU0SnVocFBxbWZBayswMEVDSmE3c0JwcXdMY1lCT2dBZXg4?=
 =?utf-8?B?T3ZvQ0tZNTczYWN4Zkg3TjliV3dGUWxXOVZYZFZuTmZoRUZYdkdWeHB2dUJ0?=
 =?utf-8?B?bDZUVk50SEJyYUJpd0VlR1BTdmxaNTlmMFN6Q1NVT2Q2WU5keDVwYUVGb3E4?=
 =?utf-8?B?M0R2U29WdmV6dXdCaThKdnptSFZlWndTVVc3b1NJQkNkVGw3OHowR1RIdllh?=
 =?utf-8?B?RnJueWE1SnVKOTdPWkxyakRUOXZKNzk5Z3IrTmJWU0ZOUm1JYldBOUNVbTRC?=
 =?utf-8?B?d2xWNG5YaTIrMlNNekF6cFd1NWY1MFVRbHpWMXcxc3ErbHdMRDhTbnJHbVRF?=
 =?utf-8?B?RzJrUFZ0Q0lsTnpZRytWOWtRajdpZW5tVXNGNzdGeDc0U0NUQWpHV005UW9V?=
 =?utf-8?B?dXptVE0ycVpqd0ZwdXNIbnFPT3JlcysrZk9CSHF1LzlhR0pMUjJ0aU1HbnNp?=
 =?utf-8?B?QnhDUTVRcElCTjVMU04xTGcvK1FmZjIyOTV4WmcrSlNVMkU4WjFnM2lGUG5N?=
 =?utf-8?B?ZTdNMnV1dWlaUElFeXMyYlNtL2RJUDNiRjNVOGNEV3YxMCtDdDlicU9hWG9y?=
 =?utf-8?B?UWMraEpyekZUNFNmcUcySS9USFcwOVZXRTNuclg1ditmdU53cUdjYmoyZW13?=
 =?utf-8?B?azBiUUp0OXFsOU4yMEJ6WkNxT3JUd2JzZVVlb1FKZzQwaDJ5dUdGdURCcW9z?=
 =?utf-8?B?akNqeDJHTGV6R0hLMm04d1V2UG16NE85VXUzK3VtY1pQRW1MRTNzNzRnbW5Z?=
 =?utf-8?B?WktsUzdpKzRUOFJGVE1TSzk2TXFyK2MyaGZmb2RMUGlNallUTzA1U3RVbGdh?=
 =?utf-8?B?Z1VpZ2xjSVFyQXJBN3gxL3RLRmRaMC95ZXJtL1RhTm9tSjZxanlIT1NJOHV1?=
 =?utf-8?B?THNNZDZGRWUydlpXNFdXQS9FRnZUbm9jdkZnRnJGNEFJem9QTkkwTmRNSUtM?=
 =?utf-8?B?RGdoU1BHTC9wYzZGMkZaRnFqekw2RVB4WTFzUm02amJSeHBpVEc3TmJBNW9m?=
 =?utf-8?B?VVhaa050U1JQcGptaTVBTFBWN2cxbEJ0NHEzU2pQVTBHaFpFQTlGZGJYV1BB?=
 =?utf-8?B?MG5neGIxQXFld0FVeVpnL3JGYVFPZWkraThzNUt1N1l0YnJhbmJ3TDMvNjM3?=
 =?utf-8?B?RFhuTWNETWhsWmZ2OWZselNscGQvT1RqME0wN1NydEg3dHlLRHZFeHFSK21L?=
 =?utf-8?B?dkRENjhYb1lqUXZnOURTbVNqRHNXSG1qZ3dTWTZ0QUNnYXRKN2tGQXhQU0Zw?=
 =?utf-8?B?QU9STFBrSVEzaUIwZHRIdVdkSWFRVjJZQmFhWnJnNHFVa2xwbzZKRG5ia1JS?=
 =?utf-8?B?bFpkbkJLK2piRS9sVGxnNit3b2ZHelNGZmJTc051WHllRzdjdDR6MWZVVE9M?=
 =?utf-8?B?RnZOS25Qc0R3Wk45SEhPQ3ZzeWpWc25HUlBKaGI1L0J1U0JQckZGMHpTMklO?=
 =?utf-8?B?Tm9rc2Znbm5Ob3lKaGxmOFp6aFdHMDYrVFZSZUlxNWI5N2JReDdUb0E3T0xS?=
 =?utf-8?B?K3R6bVUyVmNQWmxNMEJ0VnpvbjZRZGJiMGR4N3hYQmpiUzRTZnlEWGo0RVow?=
 =?utf-8?B?ZVhRZ3BGWHhEYW1nSXRITlFpZlRWZ2lMYVZHbUtOMUl1YllhT0RKY09paGp3?=
 =?utf-8?B?MjU0bkgyRjBqRUk1RW8vczlFQUM0OSs4OTgvbmZtU3NSYm41U2JsNk5tWEQr?=
 =?utf-8?Q?C96ZXq5zsJy1YDaC/Dro6aKgP5X8XGj8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmNHcDd1QkFpakR0cVVJSWQrVHFlNEM3RGtrWGVDMjhxZE1GV1R6elRWelJN?=
 =?utf-8?B?UVZBdHhGdUx6eGZBS2w1WWw3QmQ1MENobmgzOFNnT1JMZlNLMUZaUEEwKzRk?=
 =?utf-8?B?WlZZd01IdlRXN3ViSWY0VGkyUG1LZEhvN3VSKzQvak1SZzZUbCt3aHVhT0la?=
 =?utf-8?B?NU5JTlhvK0o3c0FCZk1xSGZGcmhHVUNxdnJJZUEyS0t0UmZMYk1uckQwNG83?=
 =?utf-8?B?UUJkb2VGWVI1OU1EK3VteHdkdjk1TzhpTFM4QllZWEJMUDB3VVkwVDFlczlO?=
 =?utf-8?B?SUxQb2I4YzNrN3B2YXpmTmJObGt6NG5hNktYTTlTQjhiOG45cjNIK2hBZ015?=
 =?utf-8?B?VG5vZ1NDeGM2WGgzVDJvV2JOTjBnTmorNkp0bmVzUnp1RUhDUzFMclVkdWV1?=
 =?utf-8?B?ckY0bFI2azYyeGM2Y1l0bFBMbWZDWndtN3AweGI4c1dTUGRsYlF6MUcxT0Y2?=
 =?utf-8?B?UENGYnRGN05YTmFGeXpvZEY2aTE1TUNadFpZZFFvWEo4cG9HSGpYQ2hrT2hJ?=
 =?utf-8?B?Y2htcWFJb0YrOHd5SENZODZNL3FiWGhYUEswa1pYSStUWlNsVEQ4M2Y0SjZR?=
 =?utf-8?B?N0JGUWd2UW1Eemx6MERmSENmbGczTmxCUHE4ZE9uQ0dnZVNsczJqdURGeDda?=
 =?utf-8?B?OVV5c3VZNzFIa2I1U3dRa2plWnpqcVdYTWJHSDJCL2QxM2IxMnd2RXIrbk1l?=
 =?utf-8?B?T3Z4RmhpYjVHOFdmUEtSUDBid09CUlRxYmcvajFMcnI5cjBvY1NmTnh3YXMr?=
 =?utf-8?B?NmJ3UFdLM0xXVXdQMURpNEswUDF0cE5MS3JXVVdVUm1yQi9WeFFYT3cyRHVG?=
 =?utf-8?B?Tk9tOWxTTUZIZnhwSVBaMWtRQ3RUWGxnL1FLNmVKbWNBTGdad3U4VHdsVWMr?=
 =?utf-8?B?bUZ3RW5PY2ZETUM1a2VEcjFWdTR1MGdXQTJaNEtjTFg3MWtUZksvQ0JwSFRD?=
 =?utf-8?B?NE1sTnZDNjJLalZwekhnZm5jazhkdUZpZEhwdUtRMUg0SG9oN01vMzhnL1hr?=
 =?utf-8?B?Zy96aHZNb2g1TUhGR09ya0FiYy9TVjdTRTNTVEhFYjY1R0swV2NCZDg0bGlr?=
 =?utf-8?B?NWcxRVJHbXJHaThCL3hZMG14dUJWMW12Y2lrV05hRkduWllOYXdFMzN0dDVU?=
 =?utf-8?B?ak1uOXhjRSs0WnB4bDJZSXJQbmlrQkxHWVpNL0xTNmJ2VVpFczk3cTZwMUdp?=
 =?utf-8?B?c1FlTTZqZ3VMVGc2VmI2VUt1OE9qRnpRZlpkOVA5a0JVOVRNU3FSemsrNUFx?=
 =?utf-8?B?V2EzMWs4RmVCem5XMUU1c2h0SDRDT1MxVktGOE5VaFBRb2o4d01ub0x5K3Az?=
 =?utf-8?B?VmFLcTFyVTJ3N3B2QWs1bnZieVFMMFdRM0IzTC9nbkcybWVxQ0xyMmJLTm1T?=
 =?utf-8?B?amFENDI1RWFyUzRwZnlhRklFN1BPZ05COUtDeWFGRmlXeHdvL2pSTlhHV2s2?=
 =?utf-8?B?OWo3akhtRnVzU3ZYdlVKTUk5dXpSWkhDVENuWnc3aHhka1d1WTN0bXBRTHFa?=
 =?utf-8?B?VGRyNW1FQUdCM1hyMnF2blgzcTN1bTNuRlRSSGkxK0cvaENuRmxLNm0zeVZF?=
 =?utf-8?B?cXYvVmg3VkRVK05IWFJmdWRFcmRLUUYwTHZ2cU12Z0ZQRDk0RGFYRSt1Njd5?=
 =?utf-8?B?Z2VuUnVWU2lEUUw4SFFmQXhia1FtaXBvSCtpU2V6Um9FVkxuMGZ3ZnM2UkFE?=
 =?utf-8?B?bDM4cFFaZlc1MlprUmh1MHpkYklZMnBTUHFEK2dPOEszdlFEcG1aQm81dHhI?=
 =?utf-8?B?ZU8zMkFZQ1VoZktRaTdxMEl1WUlEUVY1aFdQNGp4dVcvVC81V21sZ3Jjdk1W?=
 =?utf-8?B?ZVpHd29CbFl2cHJOS0d5bTRpcXlNUlJHYUVLT1R0alRwVFhieWZXeFhKVEV6?=
 =?utf-8?B?S0VyZCtxckUweW54QXJFUm11bThHZGlMQjdmazVjRlBLRjhhQXYyYkxiZWk0?=
 =?utf-8?B?UWZDdWpXemE1TkRRanIrQmNWYll3RmYvay9zK1ZxQXdIZ0hqU1M3RkVLOC9U?=
 =?utf-8?B?S1JmbmJneE1lZnpMSzFqdWVVUUcrdEJ6enlpV1FZaUtDVjBSRE16NTVLS0ZU?=
 =?utf-8?B?TjQxMlR6cTlSYlB0c1pQTUNDMEgxWXZIbUNYUGQzYm9SdG5zTHhtcTFxZ0R1?=
 =?utf-8?B?VU9qZUxJZUZiV2hpQWw3SnRwRUJhWi9nRkNOOEpTVWl1Vzg4YjhiT2ttd2Vn?=
 =?utf-8?B?ZE9SSkJuTmk1RGQwaUdQWFZuQjRWeUYvL1V5ZGYrY3FDN0JRS0FNb0NVWE16?=
 =?utf-8?B?WUZhd2s3MzlDS3Y0SFFSZWJKU015RDNQajk4QTd0R2ZCdnB0VGhzN2I0WDhH?=
 =?utf-8?B?OFFkUURZaFFCVTJXSjBjbElQeHVGM3VVTkRsekRkUlQ2UzNvc1JZZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c903f2-7c54-48ec-8a41-08de4bd53b11
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 21:07:12.7378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CPfYuC9ehWzD0UHaHg27r4X2dTzRY1Lxm+V1mjaKFIbbm5HeKpHEqv8FQyfXa+d66p/QxhiBiatNez/LHlbFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481



On 31/12/2025 0:41, Rishikesh Jethwani wrote:
> Add TLS 1.3 hardware offload support to mlx5 driver, enabling both
> TX and RX hardware acceleration for TLS 1.3 connections on Mellanox
> ConnectX-6 Dx and newer adapters.
> 
> This patch enables:
> - TLS 1.3 version detection and validation with proper capability
> checking
> - TLS 1.3 crypto context configuration using
> MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3 (0x3)
> - Correct IV handling for TLS 1.3 (12-byte IV vs TLS 1.2's 4-byte salt)
> - Hardware offload for both TLS 1.3 AES-GCM-128 and AES-GCM-256 cipher
> suites
> 
> Key differences from TLS 1.2:
> - TLS 1.2: Only 4-byte salt copied to gcm_iv, explicit IV in each record
> - TLS 1.3: Full 12-byte IV (salt + iv) copied to gcm_iv + implicit_iv
>   * salt (4 bytes) → gcm_iv[0:3]
>   * iv (8 bytes)   → gcm_iv[4:7] + implicit_iv[0:3]
>   * Note: gcm_iv and implicit_iv are contiguous in memory
> 
> The EXTRACT_INFO_FIELDS macro is updated to also extract the 'iv' field
> which is needed for TLS 1.3.
> 
> Testing:
> Verified on Mellanox ConnectX-6 Dx (Crypto Enabled) (MT2892) using
> ktls_test suite. Both TX and RX hardware offload working successfully
> with TLS 1.3 AES-GCM-128 and AES-GCM-256 cipher suites.
> 

Thanks for the patch.

Some of the team is still returning from the holiday break,
so testing may take a little time. That said, we’ll start
testing internally as soon as possible and will update once
we have results.

Thanks for your patience.

Mark

> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> ---
>  .../mellanox/mlx5/core/en_accel/ktls.h        |  8 +++++-
>  .../mellanox/mlx5/core/en_accel/ktls_txrx.c   | 14 ++++++++++++++++---
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
> index f11075e67658..b2d4f887582c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
> @@ -29,7 +29,9 @@ static inline bool mlx5e_is_ktls_device(struct mlx5_core_dev *mdev)
>  		return false;
>  
>  	return (MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_128) ||
> -		MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_256));
> +		MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_256) ||
> +		MLX5_CAP_TLS(mdev, tls_1_3_aes_gcm_128) ||
> +		MLX5_CAP_TLS(mdev, tls_1_3_aes_gcm_256));
>  }
>  
>  static inline bool mlx5e_ktls_type_check(struct mlx5_core_dev *mdev,
> @@ -39,10 +41,14 @@ static inline bool mlx5e_ktls_type_check(struct mlx5_core_dev *mdev,
>  	case TLS_CIPHER_AES_GCM_128:
>  		if (crypto_info->version == TLS_1_2_VERSION)
>  			return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_128);
> +		else if (crypto_info->version == TLS_1_3_VERSION)
> +			return MLX5_CAP_TLS(mdev,  tls_1_3_aes_gcm_128);
>  		break;
>  	case TLS_CIPHER_AES_GCM_256:
>  		if (crypto_info->version == TLS_1_2_VERSION)
>  			return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_256);
> +		else if (crypto_info->version == TLS_1_3_VERSION)
> +			return MLX5_CAP_TLS(mdev,  tls_1_3_aes_gcm_256);
>  		break;
>  	}
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
> index 570a912dd6fa..2e845f88a86c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
> @@ -6,6 +6,7 @@
>  
>  enum {
>  	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2 = 0x2,
> +	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3 = 0x3,
>  };
>  
>  enum {
> @@ -15,8 +16,10 @@ enum {
>  #define EXTRACT_INFO_FIELDS do { \
>  	salt    = info->salt;    \
>  	rec_seq = info->rec_seq; \
> +	iv      = info->iv;      \
>  	salt_sz    = sizeof(info->salt);    \
>  	rec_seq_sz = sizeof(info->rec_seq); \
> +	iv_sz      = sizeof(info->iv);      \
>  } while (0)
>  
>  static void
> @@ -25,8 +28,8 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
>  		   u32 key_id, u32 resync_tcp_sn)
>  {
>  	char *initial_rn, *gcm_iv;
> -	u16 salt_sz, rec_seq_sz;
> -	char *salt, *rec_seq;
> +	u16 salt_sz, rec_seq_sz, iv_sz;
> +	char *salt, *rec_seq, *iv;
>  	u8 tls_version;
>  	u8 *ctx;
>  
> @@ -59,7 +62,12 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
>  	memcpy(gcm_iv,      salt,    salt_sz);
>  	memcpy(initial_rn,  rec_seq, rec_seq_sz);
>  
> -	tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
> +	if (crypto_info->crypto_info.version == TLS_1_3_VERSION) {
> +		memcpy(gcm_iv + salt_sz, iv, iv_sz);
> +		tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3;
> +	} else {
> +		tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
> +	}
>  
>  	MLX5_SET(tls_static_params, ctx, tls_version, tls_version);
>  	MLX5_SET(tls_static_params, ctx, const_1, 1);


