Return-Path: <netdev+bounces-258869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GmKCQkPk2k71QEAu9opvQ
	(envelope-from <netdev+bounces-258869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:35:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F781435E3
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D68E30177B4
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 12:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5052582899;
	Mon, 16 Feb 2026 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qwCCW0mm"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BE18C2C;
	Mon, 16 Feb 2026 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771245293; cv=fail; b=u63QlhNC+Vsj+xY4eyzOMA9KqEDexdzMakNpbX5dO9tI+nxHgRQc7HHLZkPFQv4xl3JtnBbvb0Oi0mL4zqQp49Bgz6MwmC8gBdo+clOeFc5CnIpC4s6GHmahTHHNVGzTo4vCYa7TE4Ms4iBsZ2nPyh4L3Dm8iLHFJn7hvoEE5fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771245293; c=relaxed/simple;
	bh=EOPI7xkVHydLzu5eFgWM2xDGF+EpKU5ADFx13j8xABQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TXoOdwhRHWUlpicMLUWqsyzpOdNI+V3xi+hvfmPJxlC5Hl83+zTELPUBKp+CEzAzU43QCKLD7ZkZC2qE13GgiC3+LJb9I1jWv0Q3vvtWmoRnJy/qXk9vawYrDnr6JG1/qG6N6uVVrMCmD+zY4z80eLaA/ILOfdxUH0TOCUx0u0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qwCCW0mm; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRHboyhYMg/GI96QekSK4grFWTXpWToqNCe9LCbMMifQl4PUUNmNlg+S4oMiQYR53APS5iyMYzbIZq8wcS1LfdfThtRFfLhrLHgRps6UjGVEWEzQqaRm0L+kDhgrmEcI+2IdWFDl6CtrP+N3Jpw9h/m+4gN74WVYwIpGjJOO5mInsuvkp/KVgothqJ4pOGgcW+qT9jOiR0fDUG6liu0S3FaECUkdydNJZqdlwhjciUMl4VBO+G3/Bg6z+ms0en1MHmoqjlApL93PugsjhP7LgM3L+Z9htjbTEhKbABdSDIO55hhfSMBv9PYCxkxCPBOVU+LmVaZqbMh7NX75yslntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a0+YR8M91RCRO6W9VEi23lflTeVYkrdOwaaTRn9wMY=;
 b=BpA75Nid4txmLm/dp/hA3gLuVCkjnIj4biECqPZlIngDRmvmTZThIozgzWM5tdPlq5tTbxoPP3gBOendFTkkuScQ5aQqQ4kE41m1tq6WKLiGNeHG7dspW0B0BEFxzECxAzQsReIf//3EsO8/qNs4BSmAK5GRcLM7ykk6gITY5R6wb5U56WC31vmd2M+OK0vk67mMajC3TwSzLNQwIiHMpYKqt9lNJ4HLy7boZr3YkqjZVYGaMI7r3gVIkTN3XKuYOILc/8VLnRigx1XVBDLbdMhvfKo5cYrZGo1vF7+7xa7oLj1OBQQ5qfGvareeQVdP7TNtu69Pz1uBsMwEZ6v3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a0+YR8M91RCRO6W9VEi23lflTeVYkrdOwaaTRn9wMY=;
 b=qwCCW0mmHdCAO5qmeQamF8NoLtUObWJKencWj1Pkm7ywiYXhgBG5D9NORK43xeDh6UNPwX/hKpNq/3qU7zTAqTSnd+5T0EZzJ9mWJbtSdpEAd+Umn7Dd3v7Nn50TrQJ0BDOk+JI9rp2A7rxMSmyohpYt3G+8dfMrcvVOYRu1vmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 12:34:48 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 12:34:48 +0000
Message-ID: <9db98c19-101c-4a34-8e51-8f90dee2ba0d@amd.com>
Date: Mon, 16 Feb 2026 12:34:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] cxl: Define a driver interface for DPA allocation
Content-Language: en-US
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-15-alejandro.lucero-palau@amd.com>
 <20260213161410.2945294-1-gourry@gourry.net>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260213161410.2945294-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU6P191CA0047.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0bfbc4-5d92-4dfc-9c2d-08de6d57c58c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWRYOXhsdUROSk1tNm51V0FEN2ViMUhQQXZzVkRKN3RUWStCM2xZZ2x6WmQ3?=
 =?utf-8?B?aCtDYnZSWCtLWkdhV1JHaWtyK2VRV1VIZ0JmMjM1dkJta2dheU1YYWUvdTNU?=
 =?utf-8?B?K0l3Nm92WlFjQllCWkpJbytlS05kcEwzVjJwdlFHNmExaHRPYi9KQU1xNlFx?=
 =?utf-8?B?NlZJNjBYZFRKdXlqbmc2enljWG50L1Q2aWw3UlRFMTlyWkVWb2xIS2pNQ0x3?=
 =?utf-8?B?OFIvK28zdTRyTGk2SmFyWTBNSTA5UFgrenNocHdYR2tnRW5TU054YVpZVURq?=
 =?utf-8?B?VFJPK2ZCV1dLa2VIcGRTbGl0WlFYNnZ2dFp3bC8xR3NsSFNjR2YwR0tjbCtF?=
 =?utf-8?B?elBPSEdJM3dqazlDS1czL0Ivdy8vM0oxMXBQZXFmMTVIb2kyMjdXYjZvSW1i?=
 =?utf-8?B?ZCtBeHBnUElMTGtGNU5EbGFHMG1PMS9COHprKzQxcWlmRXJVenJ4L1hheWVS?=
 =?utf-8?B?RmF2OTVPOG5LeUFteUMvNVpNVGI5MVdwZ0ZNWHhpWEhDZnBFT2hxcXlqTFJ6?=
 =?utf-8?B?Q1pCOFBmRFBOMHpzNm1Jb0gvU3dmbmYwZ1VvUEI0eHZRV0JUTUIzcDRGOGN2?=
 =?utf-8?B?QUZ0VkZCUzNZWWpwLzJocjZsMStjTEkvcmJnZW9vT2x0Qk9iTGZhb1NidXMx?=
 =?utf-8?B?dG9ReUF2cDIrTGNzb1FWVXFMRi9NRnE4b2NDdHdDT2J4c3Y2RnBIdHp1cmNQ?=
 =?utf-8?B?N0x6VkdpSk5QTGU2blZnTGJ6NFBiTnhFL2x5VWg1czVpNzZTd2ZQbW5qT1Jp?=
 =?utf-8?B?N3VRemlRMzNEbVlBMEhmOVoyYzBXNEtvY2RJbmh0WTdWNGRPcFRvOFFzT0VQ?=
 =?utf-8?B?Y1JlNmxlVDA5WGRtU3MraHdlL3VvSUVXbHhhRkh3SDRySjU3S3ZvTEJSMjVs?=
 =?utf-8?B?L1NZWUk1NFVheFRtYytKVnpuN1FUQzRuMGFzWE5VeUxuN2hFTGdpbEkxeTk0?=
 =?utf-8?B?ejArWWc3MWt4a1dld1I0MnUwZVNxUG5pV1k4bm1SUytHVEZsWGlrSEZvRFU2?=
 =?utf-8?B?cXc0SGtmNlFtc0pHdnRUWnhGK0dPcGZId2dEY2xoYllrbS9iQ201OEcyNUd2?=
 =?utf-8?B?QXBlRlVtOEhLZjBxNUlQM21aRWpRNGxqdE9xcEdHN2NBcHk4djBFU3ZXcUdo?=
 =?utf-8?B?SkMwS0Y3UUpqQWo1S1hTYWMwSTF3VVdNbmJZa1FRMm5nakxmTmZjYmErdEl5?=
 =?utf-8?B?NldUSm9hZThkSlRnSnVXamswRXE4WUhJMjlBOEk4cmhvMnVlNW45ZTJmbENC?=
 =?utf-8?B?WENObmdPZjA4bTc1Y202RTRpWTNiZUxNLzRzRFgyMmNQUXcvL1NxSXlHUUFn?=
 =?utf-8?B?MWFFSzh4NExvUStLYWJ4cWZGVmRYU01GZDdsQUd2QzBDQ2E5ekV5YkhHVkYr?=
 =?utf-8?B?UlY2V0hJcmNRNE1JYzcyOHdHbE93NHhWU09XenVyTXBObDBWZnZPL2l3MXRa?=
 =?utf-8?B?ejZodjRwUDlFVlNNRklQdmFOMzhiU0hKYjJ3TmF4bnpPRG0zd2F2SzEwcjUr?=
 =?utf-8?B?ZjUrUUp1aThqQ1Z4SnJ0dXhxVUYyT09qaG1rYWRsK1hPbnUrZUdMM0RvditG?=
 =?utf-8?B?bk0yTUR5Vzhsc3JSd0MwcVpHdTRNTGtzUjVBaEd2d1hDcGJTdEg2N29ZSHor?=
 =?utf-8?B?dXFLNWdwVVh6b2x5V2grQnRnU09kcWRBcTR4L21YT0lma1MyTndZTk5RZVFS?=
 =?utf-8?B?QnViMDJpcDVpMU96NlpYSVAzb2lGZXBWNUFEQ2k0WFRSMzByVDF3RzhrcHJY?=
 =?utf-8?B?dEhJZ2N0UmpHZHFnVGt4T3VBQithSkxweEdGdklQMFIvV3Y2SUtab01HemV1?=
 =?utf-8?B?b0l5UHpYRTVhS2NkTnppU1N6VldYU1BOSTlaWkljN2IveERoTGdsa3c3ZVN1?=
 =?utf-8?B?SFhGK2R3cFhwQXRaaGU0dDZtZTlIZUFUWGI0SXQzV2hrVytJeVNiUi9uc0t6?=
 =?utf-8?B?Z2d3RFNJNHZoVTlxUkJiYm5nSEQybElzMHJFWFpSNXBDRUR4cWxDN2kzYkph?=
 =?utf-8?B?VTlVTXdOTFlaWnUzVVg2cGVibEJKd1NWbVFsTGV5N3RlajZOTGtvZlJEcEVY?=
 =?utf-8?B?QzFzbXcyamQ1NVpCY0Yrb2tDSE1lL2NraE54Y2NkVkY0WGRscU9HN3FkYmV2?=
 =?utf-8?Q?z6BI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnFkV3AxVFo5NHVrdUtQL0d3VXFoMW9EQXlwR2FlS3BOOUQ3blNLNmp0Q3Zr?=
 =?utf-8?B?TjhIVnZ0UnhET25mZ3NzeDVrM3lrVk5QVmtucWRUTEdSWTFtU01XR1grY1RL?=
 =?utf-8?B?UHByNXJTSm0rN3RPNWtHVnRtUXgxMHEyVzUwbW8weExzdGlvNHNBUEZkU3RN?=
 =?utf-8?B?a2VpQTYyU2txR0t6QmlUclUzN3RLQjcwSHJnd0wxY1VKcW03dWJiZWh5amlH?=
 =?utf-8?B?V0Z0OTc3RTN4c1B0WTdhNVo0UkN6UGpYVnhzOFNYQjVTNjJXOW8rQitSNWgw?=
 =?utf-8?B?NGN5ZytXNW13THUwTmtVbXdpZWRtcnAySkdhclRUT2FKWjJ5c3UrRVovSUJ2?=
 =?utf-8?B?WXJ6b2JOejl4RE1ldU8zbHNHekpCTjRhOU1rYzNDZUdoTzRVTU9OMEUxRm5q?=
 =?utf-8?B?OFNNRCtmZ3A4T3VucjNEOWFYYXpRS203NHQydjR3OEJsdVVHTFJWbkNMdTdV?=
 =?utf-8?B?U251amR4enk1a3hSVFVZcWdrUnpTZ3F0b1pKclQ0TnVZdXc5aXZ3eTZ2akdn?=
 =?utf-8?B?RHk0VkZoc3BONENMSmRiSitoTENDdTV2MFRxSWRrYlQ0MUhlQjN5UThwWTRI?=
 =?utf-8?B?R0NONDRrdWZXQmpHcDVhSFluZzBmeXZ1OTR0RWtZZWNCaFRGL1ZjQjBQWXRX?=
 =?utf-8?B?M0lKWVNqbXlHOFpMQ2Qxc1RBTWF2M2ZiSEFwZzNLMisrSW9oTEFtWlo3MGx1?=
 =?utf-8?B?MjlaQmQrVzNPSGZSVnQyOWIzTXhiNStZc0NLQXh6SURTUXREcXlXZFpVd2Z3?=
 =?utf-8?B?ejFyMHVMNVR4NU80UjJHRmVCcWQyaUcvU2h6c012N0IrUEFaSkU1WTV5Q1E2?=
 =?utf-8?B?QWhta3ArUE9nWmgyY3ZLbnE4K1dQcURCZi9QcmpDN2JhYnlJNGN1Q1FpZTZO?=
 =?utf-8?B?T2t1NXhoOXQ1ZmhISU1wWTBQN29aeGZjM0ljT1F6RDA4bExhQWZlY3QzYmdn?=
 =?utf-8?B?aktJUEVJMXVpUSsxK05oMDRyelBRdERoVjdrblV2Uk9VWHlMT0ROQUpmRVEw?=
 =?utf-8?B?aFdzSTk3Y1ZScyszMWIySGVxQnozUkkwM1hHMU93OGdYOUZqSkl3eHRwQ1NB?=
 =?utf-8?B?c2ROczZnZWZzWEE1azlaK1d2dVpFWVU2bVFmSy9WaEc3M2hqSWYxVnoyNSsy?=
 =?utf-8?B?UC9USEUweUtVRWpyK0d4VjgvenJrYm5aSXhMOG5PVmdUelRSUUJMdEVxU3lK?=
 =?utf-8?B?SXduNzdVaHJ0OEJIUzM3QUZmSUF6d3pkVVMzdWhlbWQ2YjJRN2o3Sy9VVThK?=
 =?utf-8?B?WUZXUFZHTTF3dXdpTTkrMXFDK2JUeHpDZ1l1M2hud2xWVEhTYStZUHhVeGlH?=
 =?utf-8?B?djlEdXNjSjFCK2RBQjhEakpvRkYvUU9JVDZWSG11MDlmR1VsYjREZExDRWZO?=
 =?utf-8?B?d2s1QUh3eStBb2ZRZ1ZGMjZ6d2dwd1VEZUQ0VDRzL3JSck9DNklDSnBlbDVX?=
 =?utf-8?B?THZUV053UmFqOGx5UC82MmJLMFhrNEhJZi84ZkdJT21STXdPY2F3eGt1dzJJ?=
 =?utf-8?B?MkRJTVRGWXFsV2EzTHNIMTFmU09ueHpYTFJNT0pPUzd1T05QdTZ6OTNQaDVD?=
 =?utf-8?B?SmdKQXFZN1BINXlCakkyWHZFNllsdkl2c2pLT0dxRTNmUE16OWR5OGNCN0xr?=
 =?utf-8?B?elY4Z1ZmTmhJNWorTTRYV1hTa0RSai9pMEp0N1BJN0NqRlMyelRHUzU3QUVU?=
 =?utf-8?B?U2FCeHlqVVdYeU5rV1JMWi9aNUY0Mkdka3ZxYzVTVjNtb3pqdDlFWkVpV29T?=
 =?utf-8?B?MGpQdFZhaHVsMnJ0S21aNE5aWHEwdW0rNkU5NTZpQ3gvMWtrT2F0eVhKb04y?=
 =?utf-8?B?WXB0OGltTDcycnpwV3FkQ1RqT2JZaHpZRDRpQkM0Zk9idzIySDJmSE9Pd2ZD?=
 =?utf-8?B?V01sdTlXbnR4UEkrVUhIVWxOcWcvUEZSZGxmZmdNc2JIWHBjbUJNeU11TGFZ?=
 =?utf-8?B?ZnNYRlZGNkJjTnhYbytaU2NFSzUyTXkvSHZvK21DOUFoSGYwLzkxZENuQVln?=
 =?utf-8?B?NGRKZDlhSS9HMjZtOE9SYWpPOWt6ZnhTalBuVkRRYnl4TTBtYythcHFEQ3c5?=
 =?utf-8?B?Yy9kdzMvNW03TGxyWEdVaVpWbnNVU1ZTVHlmRVJDVTJIa3NJOWQyTGpvU3px?=
 =?utf-8?B?UXc1UHV1Sjl2QlFvN1oxMHZrczdXRVJuaytPSjVCM1VCLzBYUXdLZ0FoQjdk?=
 =?utf-8?B?QlMwSFFkNXE3aTRtaW9zdXJZR3ZsV3hYcGRYcTRHeDVFeE8rWW9pMEtvYmJC?=
 =?utf-8?B?dXRTNFZjaGEvbFBudm5sbnFuNlRVZXM5TEUrRnVVdzVSTDV2SnVqV01ISGli?=
 =?utf-8?B?SXJ4UjdXUElmMWthaDJqaUFzVDFEVHJTc2xNREpnYUR3YXBaNWUxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0bfbc4-5d92-4dfc-9c2d-08de6d57c58c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 12:34:48.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAJ97t6zxVsNa7dx6i3sDE6acUoTGb1gydRrw6NQ3itFEZ4yyyeQ+92H9a+9RUs4Hbo9CI4wtCd2mvxpXIZf/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258869-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 54F781435E3
X-Rspamd-Action: no action


On 2/13/26 16:14, Gregory Price wrote:
> This review was generated by kreview-0811365ff2.
>
> This is not an automated email, the reviewer though this report
> looked valid enough to consider discussion.
>
> ----
>
> Cursory browse, this does look like a legitimate reference leak.
>
> ~Gregory
>
> ----
>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index a172ce4e9b19..d60a697f12cc 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
> [ ... ]
>
>> +static struct cxl_endpoint_decoder *
>> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct device *dev;
>> +
>> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>> +	dev = device_find_child(&endpoint->dev, NULL,
>> +				find_free_decoder);
>> +	if (!dev)
>> +		return NULL;
>> +
>> +	return to_cxl_endpoint_decoder(dev);
>> +}
> [ ... ]
>
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     enum cxl_partition_mode mode,
>> +					     resource_size_t alloc)
>> +{
>> +	int rc;
>> +
>> +	if (!IS_ALIGNED(alloc, SZ_256M))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
>> +		cxl_find_free_decoder(cxlmd);
>> +
>> +	if (!cxled)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	rc = cxl_dpa_set_part(cxled, mode);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	rc = cxl_dpa_alloc(cxled, alloc);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	return no_free_ptr(cxled);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
> Does this leak the device reference obtained by device_find_child()
> in cxl_find_free_decoder()?
>
> device_find_child() increments the device refcount (reference A).
> Then cxl_dpa_alloc() -> __cxl_dpa_reserve() calls get_device() on
> the same device (reference B).
>
> On the success path, no_free_ptr() inhibits the put_cxled cleanup,
> so reference A is transferred to the caller.  The matching cleanup
> function cxl_dpa_free() calls __cxl_dpa_release(), which drops
> reference B via put_device(), but reference A is never released:
>
>      cxl_dpa_free()
>        -> devm_cxl_dpa_release()
>          -> __cxl_dpa_release()
>            -> put_device()     /* drops reference B only */
>
>      /* reference A from device_find_child() is still held */
>
> The only caller in this series (sfc efx_cxl_init/efx_cxl_exit)
> never calls put_device() on the returned cxled either, so the
> endpoint decoder device refcount remains permanently elevated.


This is right, and it took a good bunch of time to debug it. Was it 
detected by an automatic tool?


Anyways, I had one patch for solving this which I forgot to apply to v23 
since the focus there was to mainly support the auto-discover region 
which does not go through this path:

+       /* removing the reference from cxl_find_free_decoder ...
+        * when alloc succeds another get happened
+        */
+
+       put_device(&cxled->cxld.dev);


I added that comment because it is not trivial to know if it is right to 
do the put while you get a new reference to the device. I will apply it.

Thanks!




