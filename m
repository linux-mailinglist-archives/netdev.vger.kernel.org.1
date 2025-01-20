Return-Path: <netdev+bounces-159849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAFCA1729A
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 19:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BA5162270
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5320C7DA82;
	Mon, 20 Jan 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="44BAiVph"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1961EE7C2;
	Mon, 20 Jan 2025 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737396986; cv=fail; b=pe6SAEiX1aCSpSlxHnRUbeiHTWJOkuio79bpkodJY8liaHsSnFeuWTSvdgeLizdf00klckD0+N79apaFlhEdmvQwDjXalr/ZulOE2x/65sJFY+cdPt6S4nTDf7lTEm1WYn8EVdvfy2CPL9HKL3v/kx9VuJJntWHWF/ThLG6GS0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737396986; c=relaxed/simple;
	bh=Vh/FBx+c4vgpM/S42BJkwAjO4tkxMvGusUZIeKql1X0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WYugJDyhiW1womc/wr6cOL0OcLrLG2/OEq4MwXOQeMxeDmJg+gsi4Cb4vZvQaLSczobakSluXrNdTeinr/McnvOWokwmKwq28vSb4RT7ss4hjkn7jzTRZXBXVY7tbIp9f4lsszLM6p/If0dmBGtFOJgSOHsMtajSSmQ4ZjpkqhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=44BAiVph; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naSzEMaX8HY0VFL/51JUYnjkkiTb1vga478rhvP/OhriEuXAfHWtGH/UWEC7rHpq8imrevsCm3GSFMCWmiJmPFuGz8DmMgpESINHQoTtUdz1GW8xiAx5NovFmbVUz+nbwFAC570p1AxzDNMQqI9cIUMg0jZwb5e04S4PMgKe+Sn6pNcyU1Y6GXzao8u2Xc+H8XMvnlUPloAXPMx6FrdyzI5wHhgcQ2Z6LUyIoothS6SyO7JVAAkp1BI9GkyTWF798qcRAP5abXVPzpM8NiAF96BKdc4h3GjHsmQy7sMH8V4TtXksakJhczgYj1KEDy1TuJ04vUUHsj2pFSpRqQcw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJhAJQtkRi4fzVd+Sw4vDTnx/K/dk+4579dO1IMjZRo=;
 b=bOAInlq8G4Pt78KBfHGP7NItvYkF7yhX1Bd5KvhzPyYyaaa8j+Vn9ERH3bfWgLN7gKuaKQe1LX8rWLKRkAawQHNJx3DWS3w9+rM8Q/r/t0KUmtcQlf2OXlk0gTxBr9DyOA0qPeCeKYVMzd+o7p/mkWpkCX7UUXJLtTWcn1r6Mm0aY7wla1C5I5PDAA0C5wjUg4KlWCuKkeU4zoB9Zdv4tLgzNHuO3RopYWPS4tg+T0pz8oupQsYXlmzWzxaLdM6OYkfq3VnRifxLhWI0xGyy4dXF+cfDWiwD9NjQpnoFY5oL3GP0ZYm6YCktlRsydJbCXhSH/E6PdSgDHhzbmnEiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJhAJQtkRi4fzVd+Sw4vDTnx/K/dk+4579dO1IMjZRo=;
 b=44BAiVphMNus+hyPn+qnfDc8P4GKRHhIPtPZPvFt6qjcv2xWMOzeYi4tPeSucGwy/KAU5cS8xI7Wx2LmdVvb1e+clABSjmzbv4uwyUs6NWixrag92heF7ZIlVMgC1rbt9RtppDPFA9i8j3NyOBg5O3qaQtdhgzUdUVdo4vNPeIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 18:16:21 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 18:16:21 +0000
Message-ID: <80dca432-6308-26f5-99c3-47dd15858259@amd.com>
Date: Mon, 20 Jan 2025 18:16:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 15/27] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-16-alejandro.lucero-palau@amd.com>
 <678b19bdc3d8d_20fa2944e@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <678b19bdc3d8d_20fa2944e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0038.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: b31e5646-520c-4c58-c3c4-08dd397e8ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVU3Y2gwd1YvU3h5RHlaNXlDSDZERmxmUCtrY3NXWVRBMURJU2VYSllxaXpY?=
 =?utf-8?B?SVVaYVRhT2ROZi9aaXl6eVpxZzdWdEl5RzRQbEdLRk9vdUUyWlJaS3BvbEc2?=
 =?utf-8?B?T0MzRXV1N2pXWTEyblZHRVhrTTkxekpBd2tDdEhBSnYwQmdBNzRJYnlXcUVm?=
 =?utf-8?B?RStCeDJSUkJiMFRlRS9mRGZrVnFPaW5GZjFtN2lFWUhzNk5OVUNDU3VUdXI0?=
 =?utf-8?B?NGFnb3c5RG4wVDIrRlFQQ2toL09GSHIybUkzejJKbWlDSUpEa3hiMjczZXBt?=
 =?utf-8?B?d3J1cWRscDY1RjFDWFNhdzhmbmpDMmRMUzNoOURZZG51QTBYQ3QzM1pINVll?=
 =?utf-8?B?U01Zem1xL2JKOWh6V2dzM25JKzhqK2tTZWE2b2VWRElHUXlwYkJyMVdOeFFr?=
 =?utf-8?B?bkRBS2hqdldXcnZNSXA2am1TY0NlVHpUVW5lbW0rbjBlRXRPN2RBSm5mWU5J?=
 =?utf-8?B?VmdpZWx6VTkxaithU2FoYnVtcUp4SGpkakJidHNwcEEwQWpqeWVIVVI0Ynhj?=
 =?utf-8?B?VjdsWDBzZ2NkNVRXRVBoSk1FT09MQTc5MHhaS3h0TU90NnZzRFloM0RxVmJk?=
 =?utf-8?B?VTNQa2IyMnBUeXQ2SHk5VVNwbnY3aGRVbWlqVVJ1bi9RdlZKZkE1bk14bHdX?=
 =?utf-8?B?N2NMN21QS3p1K005bGpreVpXVGZPSi8zalVwTnAxRG51VFZUTmFaemV3RTBS?=
 =?utf-8?B?eTgzNjY4THRTaFVMaGtWMEh2TmhZemQ4UUJOZ2ZxV2JlSktReGcrbCtMSjFq?=
 =?utf-8?B?b0tISDBTOURHR0lja2s3cStablhTYzdNcVl4UjFNVHNyendzRVJGYi9sTy9z?=
 =?utf-8?B?cW9RNHJ5VFNGa3g1clNwV3U2ZDhQRHJNOE5sTXZoOVp2UHhkVjRCY2NnSHpC?=
 =?utf-8?B?b2Z2Yy80TTFBQi9FUkxNUUhYWHdMdmd6Mlpzc0RFTGZYbGlaK0tYQ2xMZzB2?=
 =?utf-8?B?Z250YURBNVNYQ1l6SEE3T0NMYnF2VVFCa1pPQVB5eFBCem5wRWdEM1lkQjR0?=
 =?utf-8?B?SEx4UlFlcGpFaUd0QXYwMkRzRWxMQmx5ckNhK283azFqU1RVMDJXVjNqUnBY?=
 =?utf-8?B?TWhBSnd4Si9YbXoyYUJtcWROcGRiUzZZS1hhUjVYaUFDV0lJZTZlSjhRQXl0?=
 =?utf-8?B?WDAvYUhjbWgzMXRENTFadFBPM0hrdWVWUE1kRGJYUVR2Z29ITTZEUkdsdno0?=
 =?utf-8?B?WmxSVzllM3VRYVhsdG1mdnlwbGhkblZMN0N4SjMvL2hORUcrb1d1OUxaYVhy?=
 =?utf-8?B?YVMwaWkwMDN5M1NSa0pwOGlacXVLZ3I5WHVyRFMrNzNHbUtNYllPUG1QaWhO?=
 =?utf-8?B?aEFoZUF0UTU2Z0pxWHhTdlpod1FyTlRENml1Z1lBekFwbEMrNkpJcisvejZm?=
 =?utf-8?B?SVhsc3k2dWk0VE5YU0tiSW5TYWlYcjFQQXpCb1gxQlh6RmxIKzNWYnFGZzJW?=
 =?utf-8?B?WXpqLzVENEpYYStiOXB3LzFvS0E2NXgxUGlsaUUyeFlpMlB0aVlVZXAzTGdW?=
 =?utf-8?B?T1lHa2tPeC9mZSsrZHI0akJvWFNjVEY0L3VyTlVCMkxEeE4xU3lHWWxORUd1?=
 =?utf-8?B?K085ZjVqbFNrUTNxS2JIckJkRTd5OXkxSjJhMEFBZzkxK1kyQklvcVFJMGt0?=
 =?utf-8?B?TWk4WUdwWXRMaS8wZXh6N25KSk0yNWllREFPMXFkdThxaGhRd29OcEsxMXBO?=
 =?utf-8?B?K2ZYM2RyajVhVmtPMjJxTmFoTjlvbUdyaFlpcDFpVCt1MjJjLzk3d3FJWThm?=
 =?utf-8?B?dGw0cEJ2RzY5TldaWnFYV1d3eGNPWkdwYmJWT2ozSm9KcDRDNDhDYS8xLzNo?=
 =?utf-8?B?SUFPYjVUL3V3eWRvTUU3ZzJXNjZpMkVjc0FWR2hWYmtGNCtOQjJjTlVpMUM1?=
 =?utf-8?Q?fZq/G7AElERnU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czlzeERua0l3WTBpRkFNR2ZRZDY1dkU3cnNyWHRwaGY3TFFZblVwVDBYakQv?=
 =?utf-8?B?S2dnL0w2TFphZlY1aVNsR1F0Mm1XTi9za2I5OWxOc0p4Ni9IaWZvT0FxNXph?=
 =?utf-8?B?bG5RQ3MySmMxTDE2YWMxTnZBRm42bzViNVhGZXZSelNXVC9xSTZzMEhyZGpW?=
 =?utf-8?B?akRhalZmSXBKeVdoTDlkRmNYT3pUeW15U2ptemVyWXphWW1TSHB6dGFXeUVv?=
 =?utf-8?B?RXo3NzdzU0JjUElWYnRUOU9ZZmNIajlrLzkwYWhGSFlOamRRbS95VWdwbVBq?=
 =?utf-8?B?Zlk1NHNGQzVXa2VHelFhVmdlZmNGd2xiQ290ckNEWGloSHhmKy9TRG5CVDJa?=
 =?utf-8?B?WmtrZ2w5WEgvVnZFZjZZNW5WQ2R2MWc1TExYNzFuY3NPWTV0VGdkVkE0S1dk?=
 =?utf-8?B?cll2Sll6cVFhQkhLVVhzbUt6Y2FZbERhMUVWcTlHaktjMDNvU2ZRZ2czMnBa?=
 =?utf-8?B?Z3RPenlaTWNieTd6YXVNQzZKSEg3U2hmdzFla1ZiQnFhRURjc0tqVHlDVzFL?=
 =?utf-8?B?anJjVkhtU05PVkRkVEY2VTc3QUZIaWdnZHo4QzNUaEQrbFpqdEhGeEF1aDdM?=
 =?utf-8?B?Ui9QUFJ1bFFaSDZRUnhKSmM1UEdubHpEc0Z3Q3Bod2hRZTRDTGoyRXRncGc5?=
 =?utf-8?B?U1B3QXdwMWdEcDc4RFJFa2cxNy90UHd1bnRMUzlTL2swRlgyRHBIZE1DUWpj?=
 =?utf-8?B?WGNqNGl4Wm9INHlQMlNJWVFCMURRK2lhcnpqSkF3MDFzbHp2bCtaTEY2ck45?=
 =?utf-8?B?c0E1MkVmdkpOQXV1MVE4Q2FFMjN2UHdVZ3djM1hVQUdqMUNvNmhSWUpuMzM3?=
 =?utf-8?B?dVJjc3g0ZXJtVDJIU3FNa0VWMW1iMDMycFhaQjBCM01jdXVRMDcrSkM2MVdi?=
 =?utf-8?B?THppYXVKKzluWDZLeVVHZ0JFTjA3c3dKSjdNZHBjMUszZHZjdXBabm1VOVVr?=
 =?utf-8?B?WVRndVFsV1dGY25YLzRSWVNVbFRWNXNwRG9ObGdPbmpwc0R0VDkxUE8xVXdQ?=
 =?utf-8?B?Qm5mKzhIOVF1KzN0MzNpNndMenRCcVNPemZxZTNvUXdRMHR0Qkd3UUNScW01?=
 =?utf-8?B?S0pqQUFEQ0h0YjRWdnBoZi9CaTdmcTh6V2FWZENnRmZxWmlRK1d0b25SeFkw?=
 =?utf-8?B?TlFDQW9nQ3pZSlVzekpmbTAvZHY0NTZxYjBrMjFFd1ZUN2JQeDk0RlZKZW8y?=
 =?utf-8?B?bGlzR0o1cFpTaUxoMHdaNHJIZ3lhekJFb2ZHdEpZTFgyVnZBWVkvNGVLYmNB?=
 =?utf-8?B?NkVZbWdBNUFKVEVVTFp1OGV2OEVCbXhEbGVNNHk3QVZOZy9QbW5EODZFUTdi?=
 =?utf-8?B?MzcxeEpEZE9PQ1NTSzE0L0YvMDRVQ1VPMHRPOTYrVXNUN2dxeit4YytQQzBj?=
 =?utf-8?B?b2JEQ2lERFJVdzlIcThvTUh6MEtBSUk0azFvTzltUSt3NDhZNTZSUXdaWVZ2?=
 =?utf-8?B?cTdBbFNYb0V1c1hZWDhnalFCUlIxQ1NZWTcvaXkyQVZqOEt1RWdIK2MrSmsv?=
 =?utf-8?B?SG0rYVZRN1E4NzBEMXJYUDUxWTdLUm9lajlNcnZ5a1dkRGgvU1ZqNlhWZ0tq?=
 =?utf-8?B?K1FNY3ZCaHJBUUFlVks0QkhJemx4SjhIR3lYcE5qWFJ6bkFMNmJ6UTFidFc2?=
 =?utf-8?B?WmZYYlFPNkZTb2JiZ1ordjZkWVFLckovR01XSkpVTjJaRFcxUEdKd1h1dmlP?=
 =?utf-8?B?bkl3NkZmKzg0YWVXWnY2blpBNm1LRjFXVlZ3dDhVUXRxMzVMU1J1SVljRU9q?=
 =?utf-8?B?ZmFnTWdwZVpxdXNjN0hrd1BmZ29TNG1vbnRvTnNiRXNEYW1GUnA2YkIyNFd6?=
 =?utf-8?B?NGZhdnMwQkIwME5rUFFCdVBMMVEwcE9VbWJTV3FSbUZVaEY3d2NPeTRVZU9P?=
 =?utf-8?B?NndWcGlLUnRpbjA5alZsTlJ5aU5ZWWpxYm45ZkdqZndld3J3YmF6NkR2L0V6?=
 =?utf-8?B?U0FhRHRPODJ5VEVRTWlkSERBR2I5QjJUcGZaK2E1KzI1V0MzTHRTUjdGamdF?=
 =?utf-8?B?R0l0Y3ZBS1pORVovVXZHS0dBR2thQUllZVhyaEsvTVRrU1N5SmpndjF1MUdV?=
 =?utf-8?B?a2U2emhzZ0NqbWFVcENaV3ZsY2dhK1RnOUx4RndIcjBxUkhEK2NMVm5TN3Jy?=
 =?utf-8?Q?R5cMm4YnNLC9TDxSEwEzexK2n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31e5646-520c-4c58-c3c4-08dd397e8ad6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 18:16:21.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9/9vk6bpSqramxnBa9bTvSflpbrLE340jDlo0oWAxLaSd+H4s68ynCIzwwdRuOaJSPiHzm1jQQwC5XHD3u8nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709


On 1/18/25 03:02, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is created equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> Wrap all of those concerns into an API that retrieves a root decoder
>> (platform CXL window) that fits the specified constraints and the
>> capacity available for a new region.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> What needed changing such that you could not use the patch verbatim?
> Then I can focus on that, although I am also critical of code I wrote
> (like the DPA layout mess).


One thing modified is related to that ugly double lock you found out below.

I do not remember what was the problem but the original code using 
sequential locks did not work for me.

More about this later.


>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Include Signed-off-by: whenever including Co-developed-by


I'll do but it is weird. I think, at least in this case where the 
co-development means different times and not close cooperation, you 
should add it explicitly.


>
>> ---
>>   drivers/cxl/core/region.c | 155 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |   8 ++
>>   3 files changed, 166 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 967132b49832..239fe49bf6a6 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -687,6 +687,161 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +struct cxlrd_max_context {
>> +	struct device *host_bridge;
>> +	unsigned long flags;
>> +	resource_size_t max_hpa;
>> +	struct cxl_root_decoder *cxlrd;
>> +};
>> +
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t max;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +	cxld = &cxlsd->cxld;
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
>> +		dev_dbg(dev, "%s, flags not matching: %08lx vs %08lx\n",
>> +			__func__, cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * The CXL specs do not forbid an accelerator being part of an
>> +	 * interleaved HPA range, but it is unlikely and because it simplifies
>> +	 * the code, don´t allow it.
>> +	 */
>> +	if (cxld->interleave_ways != 1) {
>> +		dev_dbg(dev, "interleave_ways not matching\n");
>> +		return 0;
>> +	}
> Why does the core need to carry this quirk? If an accelerator does not
> want to support interleaving then just don't ask for interleaved
> capacity?
>

I think it was suggested as a simplification for initial Type2 support.


>> +
>> +	guard(rwsem_read)(&cxl_region_rwsem);
> See below...
>
>> +	if (ctx->host_bridge != cxlsd->target[0]->dport_dev) {
>> +		dev_dbg(dev, "host bridge does not match\n");
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_region_rwsem);
> The lock was just acquired a few lines up, no need for extra lockdep
> assertion paranoia. However, I think the lock belongs outside of this
> function otherwise the iterator of region is racing region creation.
> However2, cxl_get_hpa_freespace() is already holding the lock!


You are right and  this is so obviously wrong ...

I think the problem is the adaptation of that initial patch with the 
seqlocks, and I ended up mixing things here.

I'll try to figure out why I had to adapt it and if I mistook the lock 
to use.


>
> So, I am not sure this code path has ever been tested as lockdep should
> complain about the double acquisition.


Oddly enough, it has been tested with two different drivers and with the 
kernel configuring lockdep.

It is worth to investigate ...


>
>> +	max = 0;
>> +	res = cxlrd->res->child;
>> +
>> +	/* With no resource child the whole parent resource is available */
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
>> +		resource_size_t free = 0;
>> +
>> +		/*
>> +		 * Sanity check for preventing arithmetic problems below as a
>> +		 * resource with size 0 could imply using the end field below
>> +		 * when set to unsigned zero - 1 or all f in hex.
>> +		 */
>> +		if (prev && !resource_size(prev))
>> +			continue;
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;
>> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (next && res->end + 1 < next->start) {
>> +			free = next->start - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
>> +			free = cxlrd->res->end + 1 - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +	}
>> +
>> +	dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(CXLRD_DEV(ctx->cxlrd));
> What drove capitalizing "cxlrd_dev"?
>
>> +		get_device(CXLRD_DEV(cxlrd));
>> +		ctx->cxlrd = cxlrd;
>> +		ctx->max_hpa = max;
>> +		dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n",
>> +			&max);
>> +	}
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
>> + *	    decoder
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
>> + * @max_avail_contig: output parameter of max contiguous bytes available in the
>> + *		      returned decoder
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
>> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
>> + * caller goes to use this root decoder's capacity the capacity is reduced then
>> + * caller needs to loop and retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
>> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
>> + * does not race.
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       unsigned long flags,
>> +					       resource_size_t *max_avail_contig)
> I don't understand the rationale throwing away the ability to search
> root decoders by additional constraints.


Not sure I follow you here. I think the constraints, set by the caller, 
is something to check for sure.


>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxlrd_max_context ctx = {
>> +		.host_bridge = endpoint->host_bridge,
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
>> +
>> +	if (!is_cxl_endpoint(endpoint)) {
>> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	down_read(&cxl_region_rwsem);
>> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> +	up_read(&cxl_region_rwsem);
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max_avail_contig = ctx.max_hpa;
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
> Lets just do EXPORT_SYMBOL_GPL() for any API that an accelerator would
> use. The symbol namespace was more for warning about potential semantic
> shortcuts and liberties taken by drivers/cxl/ modules talking to each
> other. Anything that is exported for outside of drivers/cxl/ usage
> should not take those liberties.


OK


>
>> +
>>   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>>   			  const char *buf, size_t len)
>>   {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index a662b1b88408..efdd4627b774 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -785,6 +785,9 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>   struct cxl_decoder *to_cxl_decoder(struct device *dev);
>>   struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>> +
>> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
> ...oh, it's a macro now for some reason.
>
>> +
>>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>>   bool is_root_decoder(struct device *dev);
>>   bool is_switch_decoder(struct device *dev);
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index f7ce683465f0..4a8434a2b5da 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -6,6 +6,10 @@
>>   
>>   #include <linux/ioport.h>
>>   
>> +#define CXL_DECODER_F_RAM   BIT(0)
>> +#define CXL_DECODER_F_PMEM  BIT(1)
>> +#define CXL_DECODER_F_TYPE2 BIT(2)
>> +
>>   enum cxl_resource {
>>   	CXL_RES_DPA,
>>   	CXL_RES_RAM,
>> @@ -50,4 +54,8 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   				       struct cxl_dev_state *cxlds);
>> +struct cxl_port;
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       unsigned long flags,
>> +					       resource_size_t *max);
> The name does not track for me, because nothing is acquired in this
> function. It just surveys for a root decoder that meets the constraints.
> It is possible that by the time the caller turns around to use that
> freespace something else already grabbed it.


I'll think in a better name.

Thanks!



