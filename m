Return-Path: <netdev+bounces-208699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 145A7B0CC7F
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 23:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528923B999F
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 21:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E48523E342;
	Mon, 21 Jul 2025 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fX1EbzAM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D1715530C;
	Mon, 21 Jul 2025 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132987; cv=fail; b=o2PfmS/B/vjP9jVsQWviAbi7eBUmufUa3CudK/XLMr9D5SmqmIha0o8tH9fA6J/rOxayGkLXwOmR7jJM1iFCxho67FcPO50QakAuWbCLXQqsex/cR6hCdwsyXF1pRudbyMSUJOiYbE19VZVx7H/7hMK3Npmhk4QvghnwuHPhtYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132987; c=relaxed/simple;
	bh=V/eXFODDFtiLCYV2x+dyrvFabYKMxWesTKIP19RL96M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TDkFZksB+QITW13SjwlLyef6di8Me7jUfYszGGFyAD9jZskW69RYQHHb3dH5iCRrL0lmF68h1SUP4zrqAXGx6aZK1/+iU+0kPpzmh+F7k5fB7FtE8tQukZ5Dl2p1GUwtNQZYnyVd+T+eVOrhwMfmfD2eK++ijSLpCmvowBe63Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fX1EbzAM; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiuqHZ2/J2vN5J2quYQVAC6/FU6X4vd2K9z91A1a2vyeCy2bG/OeR9rqL2Ra3O3NbJTwOJ2oXPhlmgwateuu74wx9MR88Hi7OAn86FhFx970NHc9M/uWU/FYwBkmORr8mfmUWUCfgQOIGspicv0qNOxsNJtUjQ7FY9NqZlkL6PuMDdvFFnDVhZfxookGsDwmTITY4u28v+kPsrs2iBnilCXkJtG6m/ZJAgE3wjL7KkUPKmQTwAC9isyiZRvUe2FpKtVykdh2pfGRkEWt9UinhIG3v/+1DByPd5CuusFr+AfFZPrfD7yVviS8YLZSOPydZWBLUHYCf+BAAU1TBHnmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaaMCSFw5kC/e8wY8sm7XVh6oBz6urXxJiu7MONoMh0=;
 b=IGVrvoJY7ijSfGRwhVFFk61kOF9oZ53divOmMZbhxCrmnJF8Nax3fjew4yf1tUdePVcgE3oOcWePS9vwCePMmEVMejbUZC3FdMFjdbfVo/swwx9ZG+5KCPJA43Nhcdc8UZ+VUhYoz6BOzQHrjq1JHEfCV/jS/borzXKm1sW/VKzgeaXG7rLVDVlUUHyC2MBO8hxv0WSUZfulj1ojFfpkSC/glDKP8om4PKZLlslWel9o0FPFBAZ5QCaBSZDkzVRLTF/tA5xlAwmbLbR+6BP6spHRA/cgLzmonFGUCgc1vTWqSKbXcijt+nTOW5eNBDs0yy+eMFi0+0exZ6UsrMv4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaaMCSFw5kC/e8wY8sm7XVh6oBz6urXxJiu7MONoMh0=;
 b=fX1EbzAMg3Wn1ad/C317bfj8Q9QAQcgMHi6nn05HQJvF3od7lmoVg0KWUUZrHeF/Ni4LhdVf24fHurSIGhyjkxsqRhlQ+O6/OaWX8brtQccGUX+6wjg7I7rCfgJQtf82IFPUrhj4Hte64GI4Y38ewNM3znkI0HUNb67khlyvPsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 21:23:02 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 21:23:02 +0000
Message-ID: <aa667a0c-d1ed-48d7-9e05-1cbed77643b9@amd.com>
Date: Mon, 21 Jul 2025 14:23:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] net: rnpgbe: Add build support for rnpgbe
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-2-dong100@mucse.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20250721113238.18615-2-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::28) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 57384c9e-6909-494d-efdd-08ddc89cc647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzNONWdITGhOdnRVWFFFZFFHQWpEY3dJRTl1K3F2WUUrY1lGU2FoTXFOVHVD?=
 =?utf-8?B?SWFrdHNpeXB0UG1kem02TDFTNGQ0MUFKMW1waENWT0ttSHFsUzF4ZkxLaDIv?=
 =?utf-8?B?blIzZWsxQkxLYm1CVFMrakxtaGdhYzRRM0FKM3B2N2daMTlVQnBlT0QzS1VC?=
 =?utf-8?B?Tjl2Vy9ybU9zcEhiMy9NRi9id0lYNFlYbTdkaXRkME5EQllBVEJYWnBQaTFC?=
 =?utf-8?B?NFpoOC84UVdLTDk3cnJoUTkwMVQrN3NNYklCYXNzUzk2OXo1MjRRT3g0VER2?=
 =?utf-8?B?MGNyeG1tTzNvNStOWkUzNDJPcWNnZ3dIQjhJeit2U0h4bU5pWStGanhxZ1BM?=
 =?utf-8?B?NEFJWHBnRWVpVDMzMVMxL1RXU0xWVXR3MGZ2cXc2aS94NjNKTmJLNndUdkcy?=
 =?utf-8?B?Y1FUZWh4cWxYZmRyV1BqdnNVRmNRZElrWXd5RjByaW5NaFNRWmFNQ1h1dFFr?=
 =?utf-8?B?RDE3OWE4R1UzWitXeUhPSERTd2dINjJkZktrY0FJS3lDUmc5ODNyNGUrNkNo?=
 =?utf-8?B?Q0piQ0I3ZUlmazh3ZXFhWlM4VzMzR1FiUzcwVXRVVXJWSEk0RkFHRWhaM1RT?=
 =?utf-8?B?enRCRmMzZ3RsNDR5TkdGb00vbTF0VzJERUhIMVU3Z1U2Z3F4bDFSVCtDZ3JK?=
 =?utf-8?B?OEF4U29nRmkybkJ0REI3SW1LUGt1dGRtTDFMbzFHQ3NUUVY1d3RqTHJSVEY4?=
 =?utf-8?B?Q3U0d3pPTGJPNnh4eU9oMG15SVhvZVAxckV6d1NIU2lJTmgxT1pYMW1IKytu?=
 =?utf-8?B?Vm1KdXMzeDVlZktNdHJRSE0rSndyajcrTHA5TFFJM1dXcVJoMDJuUy9DcHBD?=
 =?utf-8?B?ckVseWRqWUJkRkZXNDBIRlhPbEsvQ0lTRDE3NHlQWnZoNXVsYm81KzFHdThT?=
 =?utf-8?B?TkF0WDNSLzd1QjVwNWYxRUhGQ0xTREpsM2taZFdLT2lyZm5DS2p5ZVkzSFVV?=
 =?utf-8?B?RzZTa3JNOHd6Nm9ucjNkUHRWb0hHL3hkVzFjYytrdzJSMTRhbzZQNWFnSnlW?=
 =?utf-8?B?Wk1MclM0UFROdlBtYTdNWDUzcVV4bGVVRFdXMndtVk5yV0lUbWdSc2E2Yjlv?=
 =?utf-8?B?RThPdkpEY3lpYUphMkczM2dqNWRPUjdVOXhpNmVPY0JncEdkSzZzSnd0ZTRn?=
 =?utf-8?B?OWdkTW1QSStmZkFiOEtuT0hqQkJZdjBOUHI5ajhTbUFIQk1XS2pkQWthZFZi?=
 =?utf-8?B?NXArWGlUdW9aVHRqNWh6TVVyQy9MVFluQUpmOFRvbHZQNFhrMWZ5QjFSNlpF?=
 =?utf-8?B?dmZjR3ZLQ0svWmFOQW02TE5nOHc3eWE3T243WEh0K2xnQ2xDdjlUQk5KbUoy?=
 =?utf-8?B?NW05Z1JscC9VdTlrTWEzQyt1clZxTE4yMGR0WnA5VzJxSi9qdmpmZlE5YUtE?=
 =?utf-8?B?Rm0rMHg2aDBjcXpVRjFtbmZORWlBYjJiZHkzTUFzL2VkYm5tUDhGREs3N0lB?=
 =?utf-8?B?L1VBd2FpWHhFckJCeXN1SnREOEUvNkU1M3BPOHkvSHo0UjRZWHY2ZXZEeVFy?=
 =?utf-8?B?VkVybjUzVGFjQ3k4cUdnYzdDMHYyTWNjZk0xMERJTlBUTSt5b0tMdjFNRERa?=
 =?utf-8?B?NExTTllPVW9nRG5reFVCeSszMENCT25qaVNQaHZ3MXpyaWhGY1Q3WGtpdGh2?=
 =?utf-8?B?c2FJSFg4RUlJQzUxOTBGVWtLODFSTmxUb2FNa1BkZHA1cHJQSWNPQ09pcjMx?=
 =?utf-8?B?eHFQZDd4QzlCalMrZ2dlTzMxU0NwREt6OFBxRjV5aDI5R0JpK3lJWjJYMCtl?=
 =?utf-8?B?UmYyMFVFazl4a0ZhZTkvc1BEMHpocnp1d0hBNmxLcVduc0FLSXNMcENrSUdu?=
 =?utf-8?B?dE0zV3dmMVpNWlBwcnBWbTgxSGVGMCs2UXQ1UlBkUnFtVzI4UmZjdU1wKzNo?=
 =?utf-8?B?Ty9Jdk1FeEQ0OGo3eDhmMzBYVWtsRmtsNGxIb3czcEx0NlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDQvRUlldHo2NWU5eDJ1UE5qQ3J6c3FydkYrdTMxR1NHMmYwbUxHYm8weTEx?=
 =?utf-8?B?YmlmR0RPWWlCbVJmc3FHckR1VW5HRitlcnAycGd6TmFmRE81QWwxOXpiMDZ3?=
 =?utf-8?B?ai95dGhjeDZHNS9YaUdvempZcXlXY2w0WW95aEEyazlPMSs1QkFHSXRteWVG?=
 =?utf-8?B?bE11UkJKVjY5MDhQM3FDbWNBc05rcmFLOWVHQ1ZKUGlXa09OL0FmdG83SXFl?=
 =?utf-8?B?U3Z1T1FTWkprbC9ZT0M4dzlab3pldC9ydzhiWGtJWDF0NFhaOHI5Qkp3Uzc2?=
 =?utf-8?B?YkhhU3ViRzhZM3RUL29QdVdxdGR6WnBQNGFyLzBxUzdlSjFlMW9ueDZjSVBk?=
 =?utf-8?B?SjhjTzEyMGthS2kzMHFYUEZzQjA0ZU03SU5NNlNRb1RScm84cEhZY1cxUXkr?=
 =?utf-8?B?QzkzQ0lsVEovQVpETHA5azJUZmQzVVNvZkhidlBNMEorcjQxVW5TYU14M1pj?=
 =?utf-8?B?VFVqNEJUL0V1MjZ4a2NuaXhKZGsxcTViWDUyTWQ0dVlZZ3ZLMXZUdGNKaFMv?=
 =?utf-8?B?UHE2RU9YdUFoUlk1M25OaE1HZEpLbGJuWnpCM1lBOUZaUHVWRnZXMU9Ud21D?=
 =?utf-8?B?QTIvYkNqcTRKeitPanI5WVB2TW9ydVMvS3hQTWttV1M3OTlSaEZpRVNtSXBI?=
 =?utf-8?B?VHg0N0UrWmhLOHRiem1PcWVtRERmZmZVZFpaM2xpTU1nM2wvcnY0NmRUaHkv?=
 =?utf-8?B?MGNnT2ZzaUFGSStDUEt3NzdpWFl2YnJiQmcxWFNlT0o0WlRNUVdxenI0a2Yw?=
 =?utf-8?B?OWJoYyt6RlNhZGlnVEhKYzBPVFB6VXZHZ3pHeDdSaTZZTHY5T0k0QU1CYThM?=
 =?utf-8?B?Mlc4bVdLVWhqV1BZNDNuRXkrbHpZcXd1d1JkbkVWK2FmREduQXpuRU96U2hw?=
 =?utf-8?B?Zk85T3BRakorR080TFVBK1NEWnoyUWJLZEx6TlJvbG9YSjlEQzc1K0tQU2RU?=
 =?utf-8?B?bVlhdnl5S0dIam5ubk5uNkEwU0dPNTJ2WmM2REpJSDlrbytrWnV2dEVHcTVp?=
 =?utf-8?B?cEVzTVRJMHZNNm05Wi84WjVpQUtsNVZOS3FtazNyb2l0dHhtNUM2VmZHSTZQ?=
 =?utf-8?B?TE1xZ2xNK1RNdlVxRU5VREpyUlJIc28rdTVUTzQ5WlVIaTg4WjJzUHp2NGhP?=
 =?utf-8?B?eUUwRklzM1gyMW0xcjZUVG5VblhIdVIxYkZoTnFDeG9GUVorZDYwSi8zYWs4?=
 =?utf-8?B?eVRPY0NUWk0vWVl1N29HUUtpUHJ4Y3VLLytIeFE4V2RvSzhxRTZvMC85YThP?=
 =?utf-8?B?TGhxSVBwM0VCTEcxQkoxTzFIK1ZPTlhHNVY2ZmYrZEdrTXVrdTU1bkFNOTRm?=
 =?utf-8?B?czd4OW5uYVJ4MkdaeDM0RmJlUmZyM1o5aFBjR3BWWW8xVjhFVTQ2Tnd3Y2d5?=
 =?utf-8?B?dEY2enJaZ3NDMytEekRjZkd3VXZmRVBJa0RHRU5jdzB1endhd2R3NFhyN1Jy?=
 =?utf-8?B?MThlZmlWN3EyMEpFUzBBM003Z3RTMUJFd0loSTcvT3Y0M1JSZXFlQ1FVeXJS?=
 =?utf-8?B?S1RMaTAvc1U4ZUpVQXlOZFJyalUwZkIrYXZ1NFNkajhrdkloNVFzcENtdy94?=
 =?utf-8?B?d3RGSkJUcGJ6MitnTytjSGJKb3FGU1diNWtlN3QyR2x1OXlQU2RJUmhJY1JG?=
 =?utf-8?B?WFpDL0RsbnNpWE9qeFZ2aE9IWExPdk5xZUZ5bWpIYkg2RTJPR05JTEJnRU5O?=
 =?utf-8?B?eklWczJLc3F5M0RIbWdSendlRHRzTnlsMlp4d080Q1RnbU9tWmcvbmZWTkdK?=
 =?utf-8?B?N2k3TGtDTGJOK1BMeXQ2NFo4NU5FNFRrNGorNnhVc0FIQ0NlbGNTZFVkOE90?=
 =?utf-8?B?S0p6OVlLWjFpOExlTVBuSll2NHp4alRxYXdzcGUvenB2NHFnLzBqM0lGa09q?=
 =?utf-8?B?MU1pZUIva1Jpd3kycFlQU1ZQZ2xRdE1TeEFZZmhnUDRERGkwcGhpQkpVWnJL?=
 =?utf-8?B?dmpOVFNzek1WYUtUeUx4UnlwSHJxdnlLcTRGT05TeFNPbVN3M2hVZ1ZDR1hJ?=
 =?utf-8?B?SHNsNDNibTZ5a0VhdXU4WDNtM2YybWxiOWxJQXpoVnFpV21Hcndod0Rnd3Fp?=
 =?utf-8?B?cDRvUjNlSjhzOGxNKzcrQ2sxTTRWRHhlZWFCS0l1Sld2Y2lSZGF0WDg1SU1Q?=
 =?utf-8?Q?4pxb2RXmjdzcRBLu9p7wfNyow?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57384c9e-6909-494d-efdd-08ddc89cc647
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 21:23:02.5214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qni97VCJqSiuTRCNTtxc/XJAiEw7ncgWwP+iwzQ/uHbFclJDv2wszhjPr/LVNpGzx1jRltCMTxj/syE32x2EJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483



On 7/21/2025 4:32 AM, Dong Yibo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Add build options and doc for mucse.
> Initialize pci device access for MUCSE devices.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>   .../device_drivers/ethernet/index.rst         |   1 +
>   .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 ++
>   MAINTAINERS                                   |   8 +
>   drivers/net/ethernet/Kconfig                  |   1 +
>   drivers/net/ethernet/Makefile                 |   1 +
>   drivers/net/ethernet/mucse/Kconfig            |  34 +++
>   drivers/net/ethernet/mucse/Makefile           |   7 +
>   drivers/net/ethernet/mucse/rnpgbe/Makefile    |   9 +
>   drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  33 +++
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 226 ++++++++++++++++++
>   10 files changed, 341 insertions(+)
>   create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
>   create mode 100644 drivers/net/ethernet/mucse/Kconfig
>   create mode 100644 drivers/net/ethernet/mucse/Makefile
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
> index 40ac552641a3..0e03c5c10d30 100644
> --- a/Documentation/networking/device_drivers/ethernet/index.rst
> +++ b/Documentation/networking/device_drivers/ethernet/index.rst
> @@ -61,6 +61,7 @@ Contents:
>      wangxun/txgbevf
>      wangxun/ngbe
>      wangxun/ngbevf
> +   mucse/rnpgbe
> 
>   .. only::  subproject and html
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst b/Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
> new file mode 100644
> index 000000000000..7562fb6b8f61
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
> @@ -0,0 +1,21 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================================================
> +Linux Base Driver for MUCSE(R) Gigabit PCI Express Adapters
> +===========================================================
> +
> +MUCSE Gigabit Linux driver.
> +Copyright (c) 2020 - 2025 MUCSE Co.,Ltd.
> +
> +Identifying Your Adapter
> +========================
> +The driver is compatible with devices based on the following:
> +
> + * MUCSE(R) Ethernet Controller N500 series
> + * MUCSE(R) Ethernet Controller N210 series
> +
> +Support
> +=======
> + If you have problems with the software or hardware, please contact our
> + customer support team via email at techsupport@mucse.com or check our
> + website at https://www.mucse.com/en/
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1bc1698bc5ae..da0d12e77ddc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17033,6 +17033,14 @@ T:     git git://linuxtv.org/media.git
>   F:     Documentation/devicetree/bindings/media/i2c/aptina,mt9v111.yaml
>   F:     drivers/media/i2c/mt9v111.c
> 
> +MUCSE ETHERNET DRIVER
> +M:     Yibo Dong <dong100@mucse.com>
> +L:     netdev@vger.kernel.org
> +S:     Maintained
> +W:     https://www.mucse.com/en/
> +F:     Documentation/networking/device_drivers/ethernet/mucse/*
> +F:     drivers/net/ethernet/mucse/*
> +
>   MULTIFUNCTION DEVICES (MFD)
>   M:     Lee Jones <lee@kernel.org>
>   S:     Maintained
> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index f86d4557d8d7..77c55fa11942 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -202,5 +202,6 @@ source "drivers/net/ethernet/wangxun/Kconfig"
>   source "drivers/net/ethernet/wiznet/Kconfig"
>   source "drivers/net/ethernet/xilinx/Kconfig"
>   source "drivers/net/ethernet/xircom/Kconfig"
> +source "drivers/net/ethernet/mucse/Kconfig"
> 
>   endif # ETHERNET
> diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
> index 67182339469a..696825bd1211 100644
> --- a/drivers/net/ethernet/Makefile
> +++ b/drivers/net/ethernet/Makefile
> @@ -107,3 +107,4 @@ obj-$(CONFIG_NET_VENDOR_XIRCOM) += xircom/
>   obj-$(CONFIG_NET_VENDOR_SYNOPSYS) += synopsys/
>   obj-$(CONFIG_NET_VENDOR_PENSANDO) += pensando/
>   obj-$(CONFIG_OA_TC6) += oa_tc6.o
> +obj-$(CONFIG_NET_VENDOR_MUCSE) += mucse/
> diff --git a/drivers/net/ethernet/mucse/Kconfig b/drivers/net/ethernet/mucse/Kconfig
> new file mode 100644
> index 000000000000..be0fdf268484
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/Kconfig
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Mucse network device configuration
> +#
> +
> +config NET_VENDOR_MUCSE
> +       bool "Mucse devices"
> +       default y
> +       help
> +         If you have a network (Ethernet) card from Mucse(R), say Y.
> +
> +         Note that the answer to this question doesn't directly affect the
> +         kernel: saying N will just cause the configurator to skip all
> +         the questions about Mucse(R) cards. If you say Y, you will
> +         be asked for your specific card in the following questions.
> +
> +if NET_VENDOR_MUCSE
> +
> +config MGBE
> +       tristate "Mucse(R) 1GbE PCI Express adapters support"
> +       depends on PCI
> +       select PAGE_POOL
> +       help
> +         This driver supports Mucse(R) 1GbE PCI Express family of
> +         adapters.
> +
> +         More specific information on configuring the driver is in
> +         <file:Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst>.
> +
> +         To compile this driver as a module, choose M here. The module
> +         will be called rnpgbe.
> +
> +endif # NET_VENDOR_MUCSE
> +
> diff --git a/drivers/net/ethernet/mucse/Makefile b/drivers/net/ethernet/mucse/Makefile
> new file mode 100644
> index 000000000000..f0bd79882488
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the Mucse(R) network device drivers.
> +#
> +
> +obj-$(CONFIG_MGBE) += rnpgbe/
> +
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> new file mode 100644
> index 000000000000..0942e27f5913
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright(c) 2020 - 2025 MUCSE Corporation.
> +#
> +# Makefile for the MUCSE(R) 1GbE PCI Express ethernet driver
> +#
> +
> +obj-$(CONFIG_MGBE) += rnpgbe.o
> +
> +rnpgbe-objs := rnpgbe_main.o
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> new file mode 100644
> index 000000000000..224e395d6be3
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> +
> +#ifndef _RNPGBE_H
> +#define _RNPGBE_H
> +
> +enum rnpgbe_boards {
> +       board_n500,
> +       board_n210,
> +       board_n210L,
> +};
> +
> +struct mucse {
> +       struct net_device *netdev;
> +       struct pci_dev *pdev;
> +       /* board number */
> +       u16 bd_number;
> +
> +       char name[60];
> +};
> +
> +/* Device IDs */
> +#ifndef PCI_VENDOR_ID_MUCSE
> +#define PCI_VENDOR_ID_MUCSE 0x8848
> +#endif /* PCI_VENDOR_ID_MUCSE */
> +
> +#define PCI_DEVICE_ID_N500_QUAD_PORT 0x8308
> +#define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
> +#define PCI_DEVICE_ID_N500_VF 0x8309
> +#define PCI_DEVICE_ID_N210 0x8208
> +#define PCI_DEVICE_ID_N210L 0x820a
> +
> +#endif /* _RNPGBE_H */
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> new file mode 100644
> index 000000000000..13b49875006b
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> +
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/netdevice.h>
> +#include <linux/string.h>
> +#include <linux/etherdevice.h>
> +
> +#include "rnpgbe.h"
> +
> +char rnpgbe_driver_name[] = "rnpgbe";
> +
> +/* rnpgbe_pci_tbl - PCI Device ID Table
> + *
> + * { PCI_DEVICE(Vendor ID, Device ID),
> + *   driver_data (used for different hw chip) }
> + */
> +static struct pci_device_id rnpgbe_pci_tbl[] = {
> +       { PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N500_QUAD_PORT),
> +         .driver_data = board_n500},
> +       { PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N500_DUAL_PORT),
> +         .driver_data = board_n500},
> +       { PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N210),
> +         .driver_data = board_n210},
> +       { PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N210L),
> +         .driver_data = board_n210L},
> +       /* required last entry */
> +       {0, },
> +};
> +
> +/**
> + * rnpgbe_add_adapter - add netdev for this pci_dev
> + * @pdev: PCI device information structure
> + *
> + * rnpgbe_add_adapter initializes a netdev for this pci_dev
> + * structure. Initializes Bar map, private structure, and a
> + * hardware reset occur.
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +static int rnpgbe_add_adapter(struct pci_dev *pdev)
> +{
> +       struct mucse *mucse = NULL;

Nit, this does not need to be initialized as it will either be allocated 
in alloc_etherdev* or unused on failure.

> +       struct net_device *netdev;
> +       static int bd_number;
> +
> +       netdev = alloc_etherdev_mq(sizeof(struct mucse), 1);
> +       if (!netdev)
> +               return -ENOMEM;
> +
> +       mucse = netdev_priv(netdev);
> +       mucse->netdev = netdev;
> +       mucse->pdev = pdev;
> +       mucse->bd_number = bd_number++;
> +       snprintf(mucse->name, sizeof(netdev->name), "%s%d",
> +                rnpgbe_driver_name, mucse->bd_number);
> +       pci_set_drvdata(pdev, mucse);
> +
> +       return 0;
> +}
> +
> +/**
> + * rnpgbe_probe - Device Initialization Routine
> + * @pdev: PCI device information struct
> + * @id: entry in rnpgbe_pci_tbl
> + *
> + * rnpgbe_probe initializes a PF adapter identified by a pci_dev
> + * structure. The OS initialization, then call rnpgbe_add_adapter
> + * to initializes netdev.
> + *
> + * @return: 0 on success, negative on failure
> + **/

Nit, but think probe() is a pretty well known thing and doesn't 
typically have a function comment. Same comment applies for all of the 
pci_driver function implementations in this patch.

> +static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +       int err;
> +
> +       err = pci_enable_device_mem(pdev);
> +       if (err)
> +               return err;
> +
> +       /* hw only support 56-bits dma mask */

I don't think this comment is necessary as DMA_BIT_MASK(56).

> +       err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
> +       if (err) {
> +               dev_err(&pdev->dev,
> +                       "No usable DMA configuration, aborting\n");
> +               goto err_dma;
> +       }
> +
> +       err = pci_request_mem_regions(pdev, rnpgbe_driver_name);
> +       if (err) {
> +               dev_err(&pdev->dev,
> +                       "pci_request_selected_regions failed 0x%x\n", err);
> +               goto err_pci_req;
> +       }
> +
> +       pci_set_master(pdev);
> +       pci_save_state(pdev);
> +       err = rnpgbe_add_adapter(pdev);
> +       if (err)
> +               goto err_regions;
> +
> +       return 0;
> +err_regions:
> +       pci_release_mem_regions(pdev);
> +err_dma:
> +err_pci_req:
> +       pci_disable_device(pdev);
> +       return err;
> +}
> +
> +/**
> + * rnpgbe_rm_adapter - remove netdev for this mucse structure
> + * @mucse: pointer to private structure
> + *
> + * rnpgbe_rm_adapter remove a netdev for this mucse structure
> + **/
> +static void rnpgbe_rm_adapter(struct mucse *mucse)
> +{
> +       struct net_device *netdev;
> +
> +       netdev = mucse->netdev;
> +       free_netdev(netdev);
> +}
> +
> +/**
> + * rnpgbe_remove - Device Removal Routine
> + * @pdev: PCI device information struct
> + *
> + * rnpgbe_remove is called by the PCI subsystem to alert the driver
> + * that it should release a PCI device.  This could be caused by a
> + * Hot-Plug event, or because the driver is going to be removed from
> + * memory.
> + **/
> +static void rnpgbe_remove(struct pci_dev *pdev)
> +{
> +       struct mucse *mucse = pci_get_drvdata(pdev);
> +
> +       if (!mucse)
> +               return;
> +
> +       rnpgbe_rm_adapter(mucse);
> +       pci_release_mem_regions(pdev);
> +       pci_disable_device(pdev);
> +}
> +
> +/**
> + * rnpgbe_dev_shutdown - Device Shutdown Routine
> + * @pdev: PCI device information struct
> + * @enable_wake: wakeup status
> + **/
> +static void rnpgbe_dev_shutdown(struct pci_dev *pdev,
> +                               bool *enable_wake)
> +{
> +       struct mucse *mucse = pci_get_drvdata(pdev);
> +       struct net_device *netdev = mucse->netdev;
> +
> +       *enable_wake = false;
> +       netif_device_detach(netdev);
> +       pci_disable_device(pdev);
> +}
> +
> +/**
> + * rnpgbe_shutdown - Device Shutdown Routine
> + * @pdev: PCI device information struct
> + *
> + * rnpgbe_shutdown is called by the PCI subsystem to alert the driver
> + * that os shutdown. Device should setup wakeup state here.
> + **/
> +static void rnpgbe_shutdown(struct pci_dev *pdev)
> +{
> +       bool wake = false;

It seems like this will always be set in rnpgbe_dev_shutdown(), so it 
doesn't need to be initialized here.

> +
> +       rnpgbe_dev_shutdown(pdev, &wake);
> +
> +       if (system_state == SYSTEM_POWER_OFF) {
> +               pci_wake_from_d3(pdev, wake);
> +               pci_set_power_state(pdev, PCI_D3hot);
> +       }
> +}
> +
> +static struct pci_driver rnpgbe_driver = {
> +       .name = rnpgbe_driver_name,
> +       .id_table = rnpgbe_pci_tbl,
> +       .probe = rnpgbe_probe,
> +       .remove = rnpgbe_remove,
> +       .shutdown = rnpgbe_shutdown,
> +};
> +
> +/**
> + * rnpgbe_init_module - driver init routine
> + *
> + * rnpgbe_init_module is called when driver insmod
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +static int __init rnpgbe_init_module(void)
> +{
> +       int ret;
> +
> +       ret = pci_register_driver(&rnpgbe_driver);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +module_init(rnpgbe_init_module);
> +
> +/**
> + * rnpgbe_exit_module - driver remove routine
> + *
> + * rnpgbe_exit_module is called when driver is removed
> + **/
> +static void __exit rnpgbe_exit_module(void)
> +{
> +       pci_unregister_driver(&rnpgbe_driver);
> +}
> +
> +module_exit(rnpgbe_exit_module);
> +
> +MODULE_DEVICE_TABLE(pci, rnpgbe_pci_tbl);
> +MODULE_AUTHOR("Mucse Corporation, <mucse@mucse.com>");
> +MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
> 
> 


