Return-Path: <netdev+bounces-189612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C387AB2D14
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD5F189D738
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695A3213220;
	Mon, 12 May 2025 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="RsqX43q1";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="ObSGY39Z"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAC420E323;
	Mon, 12 May 2025 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013307; cv=fail; b=cfkzDY06grHtmlnYbtMb6LNpOCWiVIAXbDJIZ0wPP7YMRvCg0zO0ca0iOnmsoGfuhZZqoEYx+TuNuMk/E2VwdfQtZCUefglbbKuuwa0fwAVr7nKIpcwWjfhqNUw4n1TmLSn7AK0BNinaVGuVf0NQwIAZJILuhbjq43iTMVAVsyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013307; c=relaxed/simple;
	bh=dAcJSUaGdxRYNzLemz09uwt37Rt3VQNTmqaA/bpJ/eg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A9+7V245MjZVR4zA7ND9j0r81HOA0H6fKeQ31NCz/Zj2Z3aXyXkUasVBpA4RJ/634g5CXmIy/Uvjkzhx6lOp2aBednymml0kNF2kAye+/7qek1qCUBP9vUuiLrWPBYee3QRqQUQl6Mqc5DG4PXUH2/UBrixMo3XYkjsCL4E6HPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=RsqX43q1; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=ObSGY39Z; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BMe1Rv027700;
	Sun, 11 May 2025 20:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=LTvOyFFoYHjTt4R2ws8k8T62c37WSdYxkVhSLGcjEqM=; b=RsqX43q116JF
	K7bztHNioxSgvb64czQan6Qq2q2YvbVdkFvPeGJz9AjPFS67IdEiO3e9p+IWhuTO
	zwSjcAArLs7Es6eEryW9Jf1T6GxEBEJbpH7zzClsJZmiOqm/J1cZCeTee0CEEozM
	ultsFUNJcSaR3tRLAuRpcomYYUMSEEAsDZ/eKds139qO+c6HhH7ua80kHTAElCdd
	CZslBKXfWHOWgEfrl2PCSl8syCDKiYPsgduZSs21ZhAr8CdCTkVxHhmJOrUgTpc7
	PF1ChBZ98LtpeLNaN0c+HOLutiHo2tWECtN7n9FByoFpCslgXhRR/AxEQ2VxEVAL
	FdGZrBjeeg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j34csvw9-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EW9wCsqzYR6oibYCaRMqxYWQl2Fpxz4m3bmxqmeWy+2lts6PdMfALLNmypaG1vPuHjuiql06keC/shHwiGmIh48d2cRCSVpzOTzKpMo1ozrhzAhvSpJMHGxwzoZx0K1i0O7WmTWQNdTvnPSYJyg8XLfC6aEjHSw4NDJHHRZE6ZJLqve50UKz9CTUHBv1txPWTA+/BwNuWg+9GlmgWqB/A4GF5GFSo3LK9STnLwv9rBA5OPlsz4AvdGUEOPvUlFbDHJ5t9QkFIZDxFuEOs4sdYI4K9bfy1UKcIdfyhvo5D+ZUzeE0wMwEMK6uLxzpSB9NsdqMCUDyAXEakrxvyHxooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTvOyFFoYHjTt4R2ws8k8T62c37WSdYxkVhSLGcjEqM=;
 b=H/sp0NDheMI0fpYhyPzssTEMpJzbIxy5Ey9UUk+zOY8d9SCzZ1LtVtRYeP/NjDegf4UzK6ZvB5n5Nexf9k2TXusQ2yrwqTaekH1Y6PlyygOnW0tA5M5DADmb5OjAuhXaeCMn/bP9I5ID5tFdC9avKGIbWI3S8AH6/P6VPpVJKlGP1/w9ECtndb7sbhYSPVIQA8uP9g6Z4624ItqUGrCnkx7gkyC+X6w68XD0eVRqLQpeDZvapV+GGKTwc2FlIitGe8eFdk1X/J3ruWB0fzM1dJZRgJd6LTDLkJ1ia4wesr9O7pdmij9P2EIUEOvhxI0dE6xELKRq8UNYNRGbeP3pcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTvOyFFoYHjTt4R2ws8k8T62c37WSdYxkVhSLGcjEqM=;
 b=ObSGY39ZxLkJx5dgCzHzfVs7gT1IvoZBdlqY6Rn6LaEanDnhUApPtL0WEINYijEBYKNzACbmTvGFr0IkAeKF/DGxL1mmw4DJcc9BUIMs0VAF5RmG8qjA0o+hh8FvwqJI+wGqiP3JWWJVuA4hRXEqotl1FjrjdTYmmJHWp2Kujf4=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Mon, 12 May
 2025 01:28:08 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:28:08 +0000
From: =?UTF-8?q?Damien=20Ri=C3=A9gel?= <damien.riegel@silabs.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Silicon Labs Kernel Team <linux-devel@silabs.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC net-next 14/15] net: cpc: add SPI interface driver
Date: Sun, 11 May 2025 21:27:47 -0400
Message-ID: <20250512012748.79749-15-damien.riegel@silabs.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512012748.79749-1-damien.riegel@silabs.com>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::17) To DS0PR11MB8205.namprd11.prod.outlook.com
 (2603:10b6:8:162::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|PH0PR11MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c5d7a4-c00f-434c-1f5f-08dd90f44033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0hJVFlTZFVJOWtzamJCaTc4MmkrN0hZTVcwaVBGN20vRlpvSVdPeTZYL2R6?=
 =?utf-8?B?YlhyYVRidWc0Y3lvQ1lhZWhlYUFPVU1mUHdTZG1TanJUMzcwaDBYaXpwZGw4?=
 =?utf-8?B?M3o1UG5BcTBzQ3VVUmFZTGt0ZXBqazhFalBxU240emFSSmo4VUpGdDgxeHo3?=
 =?utf-8?B?RUZ1b2c0WWxROXJidUt5NCtrbGxnaSt6WjVUYXBKZjN3NUhHdTVJNU91ZlAy?=
 =?utf-8?B?RlFXRlNjQUdPdzhxT2pPQno3ajQzMTBzdG1MV1BtYUVPQ0xsUTFRMG5JY3hy?=
 =?utf-8?B?cXF1MDMrNDBnemVvY2NpYkdkRGdxNVJsMUt3UVl0UnkwT0tCZ2R2N0trV2cr?=
 =?utf-8?B?dW83QWVYTTZxYm9QcjNEcVlORlRZZ1VPc0o3STY4NWhHZ3ZoOTZZY3ZXS3J2?=
 =?utf-8?B?WFRWaUVpdnE3YjYxZVJKMG0xNllWeTlyd0FmOUVFeFRuREdOUmR6d0RkcTZo?=
 =?utf-8?B?cFo0UzAxUmNPVzFxVDlCbjRnQjh2M283UStCVEFNZmJIL0JxNituR2I2TzRz?=
 =?utf-8?B?RXZNSWlud05RZkZDR2pibWMrVDlWTzNDYjhJRFhMVEZxMSs2OTI0WThRKzZK?=
 =?utf-8?B?aGwzRGRnT3p2eG5tZVo3RVV2YXFhWXp5bFFmazBmdXFzTHlEL1QrTkZLaGd6?=
 =?utf-8?B?Tlkwd0lwVmU5VU0yOFdaLzdLc2ZhL2xGVk5pc2IyVXhMS0RicGVmOTRjRFZU?=
 =?utf-8?B?V0l2bUVsRHlDa29BL1ZzMFFrTUFRa1BNaVdKQ0hnd0dmYlhRTEpCM2s3dTk0?=
 =?utf-8?B?enBUSDdTYXl0V3pLTFdsdHgzYm5zRUtSeFY5SHdVT0RjaDlJWDVRbkg1Q3FD?=
 =?utf-8?B?emlua1cwQmdqc2g4RjFzYjlTMXJMMUFIN2xTME9UWDdYekNWT2RodS9HRkFG?=
 =?utf-8?B?MWFUeGRURUFqVmhGK3kxNmNCVFhWQnRORmhuUWVzS2pza0lOSFJSRUFXWVFB?=
 =?utf-8?B?Tm1XU0trZkl2djZtVzR2Q1ZjV0RFdnVOcHdNQkN6ME9kWTFaMVd4cHI4OVJS?=
 =?utf-8?B?S2dNMzd3Q1pXTFBPYUFySk1YY2RWY0JHRjVhUHBZTjJFbTJ0cFBrdFpxS2xp?=
 =?utf-8?B?bjZ0akorbXA4VnBUYnJGLzhiR3VueFhxSHByM0srSGhpekJlZkkwU1JDZXhT?=
 =?utf-8?B?bVNHZ2JFMGJHbHc0SzRScldwMGJrcHF0NkI0ZUtaa004S3BQZkJqQ29EM2dG?=
 =?utf-8?B?eHcyUXZhaVZOR3hSZXQvNjl6SzNveVhtRXVidDBqbVdyT2FPUjVzY1RnQ2ly?=
 =?utf-8?B?N1NVRWNXT2F3anlUOHNvc0hFMFNqaVVEY0VKRW40cDRreGVxbXFvbkltblJB?=
 =?utf-8?B?a2R6Q2ZKMVJHWmFmM09UZlBjYnVhQVdqTnQvVGNVelRjQ2dYUkxwQ0FnT0lh?=
 =?utf-8?B?VTBjTTloVnRrQ2VsZWdyWDNXS1UwZnJBRGpHbDcrMnBEZFltVVI0S0ZkV1lv?=
 =?utf-8?B?MmpjbmtKcXRGTlRNWGNnVm9pTHhUWjcxYnVSdmNXT21JTUJST2pERVMwTW4r?=
 =?utf-8?B?SHdmTjdYaXlOU0dBb2M4REdYako0TWJLTFBiVE1pZDE3cDJ5ei9vUjlCaWVQ?=
 =?utf-8?B?NTNIeTM3OEZZdU4yRkluUXczV2R5MHdaNDFTTTk5YnQ5NmhQWWpiMjRRb2p6?=
 =?utf-8?B?MmlRSUQ2VmJOMERLcWdWeWdRT1FRMEo5Vis3VnFnbTNVVWNMamsxcXZTbWlJ?=
 =?utf-8?B?TThCc09pZHlmNWZQajZrL0ZnQWhhVkcrdDR5ZGlTRXRiVi94Q08vVDZJQ0FL?=
 =?utf-8?B?VDExMVliakJGYkdWdURPVlBZQ1FvK1RFTDYzMzd1WW02U1E1UUN1NytrV25C?=
 =?utf-8?B?M0VyZkk1VU41Nkl0YkdvbFJCcUkzK0orVGFZRmhVWE0xVjlCWlJYNXFQdmpz?=
 =?utf-8?B?TDZLSVg1blRmNGdlUjREUjVxalBoRGk2ZmVWL1NuVFIyOEh4NG15OU1qWjRw?=
 =?utf-8?B?NkJCRjFrV0puMEh6N2hjV29TWG9yekJXMlpBTHkzNjA3cUdkWE1NNzZPVERX?=
 =?utf-8?Q?QTILZ98YTKTexe3ru6JdQBxWt86zz0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFh6ekczYWl2aGszeDBRMDV1OUdMUWRWWnFBNUQ4VWFpdTgvai9ibFUwd2s1?=
 =?utf-8?B?TnpFdzhtck9uS2F2aC9HemtMVEFPOUdTU05SMVAvSW53QlVkSFBSMCs2S2pM?=
 =?utf-8?B?bjlOell4R2Raa011eWFIdUhlNWxhVG0xME1aWHR4ZTh1Z2pEaUU1T2xoRWlw?=
 =?utf-8?B?NXlERkZVYXhtSUI2am5pVnk2UFgrUWtOU2tYQjhkOThuV0g3STFqcXZHb3ph?=
 =?utf-8?B?Mm1DQ3h0YjJXckZCT2s2MUpFc1gvTDIzamtYRVg0cExxSVlyeGtlRnNTSWxY?=
 =?utf-8?B?eEZZN1luYlNKRjArRXdieWFiWVhFSHZ5WEpFZVFkMnJDOUxjNityRkhsZ2VE?=
 =?utf-8?B?TE5JY2p4NDlxUnVISnpPSkxONDdqblpuU0VuY1U4L05EU0xqcDlwRngxMkIy?=
 =?utf-8?B?S2JyRGw4K1hKTzNtL21DZnBCR1ZJNTVtMktNMjNMLzUzSTlXY3hMNitpYzV2?=
 =?utf-8?B?cXlXT3BLUEwxNlFvNEtBcFN0enlHdmZrdFpkTmFYTUFCMXFsWWFwUEpiL2VB?=
 =?utf-8?B?cEpoZzA2TXo5NHo3UTJPYVlndEdmUldMOGQxdWlhUGZPQ3hidVBIaFU1dzBV?=
 =?utf-8?B?VkRPVzNyVnpSdDRLSWdCWXBEZHM5MWIrMEpXVnp2YVEzcGtZaE96WWo3YWJt?=
 =?utf-8?B?L3o4UEdVVVJUbGthY3NKYVR3MGN0dlhPNkJ5QVA3ZGdYdnZqSDA0TmloMllq?=
 =?utf-8?B?aDljaUU1bkVKUVdPakE2bGlxL0s2dGM1UkV1Uzc3VGJGelAyd2ZPbnZUSXo4?=
 =?utf-8?B?NHFOQmxPT1YzYUYySlpEMFlmdUd6N0ZSVHg5N25GcjU0eGozbkJYQWxneXVV?=
 =?utf-8?B?MnBPVWxTdmdoM3R6REhReWxpMWdPbDVpbWhYN1BXRXBrOTRmZGFiZFRYNCs0?=
 =?utf-8?B?Q2pDNTdsblRhaWpISUxJMkZvNlBnTjNuUlloQ0JieHVmNDE0YjVNQWtTTVRI?=
 =?utf-8?B?aGdSdXJDMU8zTUtYaHk4N3M0Yjhkdk1EVHdWM3JPVlRIOHI4ZXNNd0Jiem5H?=
 =?utf-8?B?MnhzakMyV3dDb2laTDdxc2psdHZiUUx5SlFpWTJQeDFheS9mR0s1U1FTajVS?=
 =?utf-8?B?c0Q0VFl6VG9MZkhhOVBtS3BDVTNGbEdVd3l5VjJYUXVCQUdWQlFQdllUb2JK?=
 =?utf-8?B?Y2djSkVCcnZQOGVYQnovQXMzSTlzNE81VTlwVnhrdGx5ZWtxenoxem5HRGRK?=
 =?utf-8?B?UWhFd0h3NTluOTVBYzhwOFh6YUZXa28vc2pOZTk3RDBWOC9EYTB2ZW9kM1FJ?=
 =?utf-8?B?ZVFTZElYN2VOM0thZktDMzNyN3ZjSFhkbWVjd2V1dFYraDBvT0lVSWJjZXVQ?=
 =?utf-8?B?Z3hMbGxXQ095M2lNSGlxQW80T2hweTNNWGxLRFZXRzNZN1JZT1JlYXExN0dC?=
 =?utf-8?B?c0R2VVAzUVdqVmo2aS85REdpdkcxZHU1NzhxT3ZLYjNiZFFQVFBOZ21XT2py?=
 =?utf-8?B?dWQrUnUzdVB6eVo4SGM0MCtKL0lyMmJnL0xmQ3JiOEtmdTNyVmJwZHBVMThk?=
 =?utf-8?B?ajBwT3Z2T0VxNlhkZWZ0NHc1NXRTQXhKZTFCY2o0QUp0VjhuZU5PK20ySzhE?=
 =?utf-8?B?YzloVXhYT2hvc0tLS1lybjlxSFB2ZURuY25DNnJDZU5CYVRrUElWaDRweXJj?=
 =?utf-8?B?THVRRVRyTjFjaXZITURoZ2wvRzdKSWV2MSs0VkpTcEhmNVl6UHJOZk00M29D?=
 =?utf-8?B?Tzgya2NNMk52aVNXUEFKQzZRcytTYitsd1Nta08xd0lOWTI2cFVYclUyT295?=
 =?utf-8?B?VGFIcWRLeUxjWEFTanlrVW9DQXdCajdxZTZYMm0rY1FQOW15eHora1BBa2tr?=
 =?utf-8?B?ZFJmNkpwMXRPVEsveGV1Y2NkWkxMOEpxSUFxaUt5NFg0VmpnVmRnVVlzWDVU?=
 =?utf-8?B?LzhTL2t4WWdqaXYzZTBnT2k0cklKQk5PenBJSXkvdDBZQzh6OXJBUFhqTEhD?=
 =?utf-8?B?dGtVYnBJZjhKOHJBcDFKNk0xeEE5UjQxZ0RRSlBMMTk1eUtON1VrMkJub3RZ?=
 =?utf-8?B?c1pLVVR4NXRKUnJpU09EREc1eXNqUGJQdzBwWHJtYXk2RVZ5bzhjMkZzZ2U2?=
 =?utf-8?B?MkhZU1VnS2NoT1VLbS9OV2wvUmxBRWZjMWowZC9MbythQmFxc0JIdnZ3eEFN?=
 =?utf-8?Q?gJM9dekY2VVRc1O5/R0/9Ik9z?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c5d7a4-c00f-434c-1f5f-08dd90f44033
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:28:08.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hypHCdGPE6KJ5ipVIGpdSNkH9tb0l0V7dOyT1AWQswnq+qdsDq87R0/o6Zb3BzjK+7r7Mondx4kbGd76IR1Q7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
X-Proofpoint-GUID: FB9XpQk501Pia991ia4JGv9uUuIu98Ur
X-Proofpoint-ORIG-GUID: FB9XpQk501Pia991ia4JGv9uUuIu98Ur
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfX4Q6AqC5r/sX9 ANB9BoyNSPCCGUNaWcc8pDxTnFaFJUzr6FxAR9r7dgbdhhEqregmBzF4C/mRJ/Idh2hIBAlMhgI 9x1UTlJTYZO7noJ83Yqfd8tmkiyyfutlSwu43DahThko6iahDE0+Sul9PSfzNbQzyyp3izUf8Ql
 nHMxolzwZV8v+9yaOAtV4d1TZXXWRDPnjdXaz2+LZHgEqBDsB8UTeCgoUdKWso91aMVCdePWW1B owpxRAmw4wWZ82D8dLg3As7gvBJRYWG1Rk6uYeITyK6bBWmf/+kvPDN38f8eE1NVPsxAEvT3qor /bzj7tyt5ZTBDpMPFzzxraNvQcymY/T7x3QVG8fSPSxaEkkwC/rbiHYicMvpw4DSRig4g5B+gc2
 RZuTOGCoLW2GUBhJ+GdfvLBVPcDMEu5H/lzsmZ1dtkVSJh5qX7ZHK6U4HA58aNQd5EKMDdGg
X-Authority-Analysis: v=2.4 cv=L/gdQ/T8 c=1 sm=1 tr=0 ts=68214eab cx=c_pps a=coA4Samo6CBVwaisclppwQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=TGmY4fB2UfIvIpc1UaMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

This adds support for CPC over SPI. CPC uses a full-duplex protocol.
Each frame transmission/reception is split into two parts:
  - read and/or write header + header checksum
  - read and/or write payload + payload checksum

Header frames are always 10 bytes (8 bytes of header and 2 bytes of
checksum). The header contains the size of the payload to receive (size
to transmit is already known). As the SPI device also has some
processing to do when it receives a header, the SPI driver must wait for
the interrupt line to be asserted before clocking the payload.

The SPI device always expects the chip select to be asserted and
deasserted after a header, even if there are no payloads to transmit.
This is used to keep headers transmission synchronized between host and
device. As some controllers don't support doing that if there is nothing
to transmit, a null byte is transmitted in that case and it will be
ignored by the device.

If there are payloads, the driver will clock the maximum length of the
two payloads.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 drivers/net/cpc/Kconfig  |   3 +-
 drivers/net/cpc/Makefile |   2 +-
 drivers/net/cpc/main.c   |   8 +
 drivers/net/cpc/spi.c    | 550 +++++++++++++++++++++++++++++++++++++++
 drivers/net/cpc/spi.h    |  12 +
 5 files changed, 573 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/cpc/spi.c
 create mode 100644 drivers/net/cpc/spi.h

diff --git a/drivers/net/cpc/Kconfig b/drivers/net/cpc/Kconfig
index f31b6837b49..f5159390a82 100644
--- a/drivers/net/cpc/Kconfig
+++ b/drivers/net/cpc/Kconfig
@@ -2,7 +2,8 @@
 
 menuconfig CPC
 	tristate "Silicon Labs Co-Processor Communication (CPC) Protocol"
-	depends on NET
+	depends on NET && SPI
+	select CRC_ITU_T
 	help
 	  Provide support for the CPC protocol to Silicon Labs EFR32 devices.
 
diff --git a/drivers/net/cpc/Makefile b/drivers/net/cpc/Makefile
index a61af84df90..195cdf4ad62 100644
--- a/drivers/net/cpc/Makefile
+++ b/drivers/net/cpc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-cpc-y := endpoint.o header.o interface.o main.o protocol.o system.o
+cpc-y := endpoint.o header.o interface.o main.o protocol.o spi.o system.o
 
 obj-$(CONFIG_CPC)	+= cpc.o
diff --git a/drivers/net/cpc/main.c b/drivers/net/cpc/main.c
index fc46a25f5dc..b4e73145ac2 100644
--- a/drivers/net/cpc/main.c
+++ b/drivers/net/cpc/main.c
@@ -8,6 +8,7 @@
 
 #include "cpc.h"
 #include "header.h"
+#include "spi.h"
 #include "system.h"
 
 /**
@@ -126,12 +127,19 @@ static int __init cpc_init(void)
 	if (err)
 		bus_unregister(&cpc_bus);
 
+	err = cpc_spi_register_driver();
+	if (err) {
+		cpc_system_drv_unregister();
+		bus_unregister(&cpc_bus);
+	}
+
 	return err;
 }
 module_init(cpc_init);
 
 static void __exit cpc_exit(void)
 {
+	cpc_spi_unregister_driver();
 	cpc_system_drv_unregister();
 	bus_unregister(&cpc_bus);
 }
diff --git a/drivers/net/cpc/spi.c b/drivers/net/cpc/spi.c
new file mode 100644
index 00000000000..2b068eeb5d4
--- /dev/null
+++ b/drivers/net/cpc/spi.c
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#include <linux/atomic.h>
+#include <linux/crc-itu-t.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/kthread.h>
+#include <linux/minmax.h>
+#include <linux/of.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/unaligned.h>
+#include <linux/wait.h>
+
+#include "cpc.h"
+#include "header.h"
+#include "interface.h"
+#include "spi.h"
+
+#define CPC_SPI_CSUM_SIZE		2
+#define CPC_SPI_INTERRUPT_MAX_WAIT_MS	1000
+#define CPC_SPI_MAX_PAYLOAD_SIZE	4096
+
+struct cpc_spi {
+	struct spi_device *spi;
+	struct cpc_interface *intf;
+
+	struct task_struct *task;
+	wait_queue_head_t event_queue;
+
+	struct sk_buff *tx_skb;
+	u8 tx_csum[CPC_SPI_CSUM_SIZE];
+
+	atomic_t event_cond;
+	struct sk_buff *rx_skb;
+	unsigned int rx_len;
+	u8 rx_header[CPC_HEADER_SIZE + CPC_SPI_CSUM_SIZE];
+};
+
+static bool buffer_is_zeroes(const u8 *buffer, size_t length)
+{
+	for (size_t i = 0; i < length; i++) {
+		if (buffer[i] != 0)
+			return false;
+	}
+
+	return true;
+}
+
+static u16 cpc_spi_csum(const u8 *buffer, size_t length)
+{
+	return crc_itu_t(0, buffer, length);
+}
+
+static int cpc_spi_do_xfer_header(struct cpc_spi *ctx)
+{
+	struct spi_transfer xfer_header = {
+		.rx_buf = ctx->rx_header,
+		.len = CPC_HEADER_SIZE,
+		.speed_hz = ctx->spi->max_speed_hz,
+	};
+	struct spi_transfer xfer_csum = {
+		.rx_buf = &ctx->rx_header[CPC_HEADER_SIZE],
+		.len = sizeof(ctx->tx_csum),
+		.speed_hz = ctx->spi->max_speed_hz,
+	};
+	enum cpc_frame_type type;
+	struct spi_message msg;
+	size_t payload_len = 0;
+	struct sk_buff *skb;
+	u16 rx_csum;
+	u16 csum;
+	int ret;
+
+	if (ctx->tx_skb) {
+		u16 tx_hdr_csum = cpc_spi_csum(ctx->tx_skb->data, CPC_HEADER_SIZE);
+
+		put_unaligned_le16(tx_hdr_csum, ctx->tx_csum);
+
+		xfer_header.tx_buf = ctx->tx_skb->data;
+		xfer_csum.tx_buf = ctx->tx_csum;
+	}
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer_header, &msg);
+	spi_message_add_tail(&xfer_csum, &msg);
+
+	ret = spi_sync(ctx->spi, &msg);
+	if (ret)
+		return ret;
+
+	if (ctx->tx_skb) {
+		if (skb_headlen(ctx->tx_skb) == CPC_HEADER_SIZE) {
+			kfree_skb(ctx->tx_skb);
+			ctx->tx_skb = NULL;
+		} else {
+			skb_pull(ctx->tx_skb, CPC_HEADER_SIZE);
+		}
+	}
+
+	if (buffer_is_zeroes(ctx->rx_header, CPC_HEADER_SIZE))
+		return 0;
+
+	rx_csum = get_unaligned_le16(&ctx->rx_header[CPC_HEADER_SIZE]);
+	csum = cpc_spi_csum(ctx->rx_header, CPC_HEADER_SIZE);
+
+	if (rx_csum != csum || !cpc_header_get_type(ctx->rx_header, &type)) {
+		/*
+		 * If the header checksum is invalid, its length can't be trusted, receive
+		 * the maximum payload length to recover from that situation. If the frame
+		 * type cannot be extracted from the header, use same recovery mechanism.
+		 */
+		ctx->rx_len = CPC_SPI_MAX_PAYLOAD_SIZE;
+
+		return 0;
+	}
+
+	if (type == CPC_FRAME_TYPE_DATA)
+		payload_len = cpc_header_get_payload_len(ctx->rx_header) +
+			      sizeof(ctx->tx_csum);
+
+	skb = cpc_skb_alloc(payload_len, GFP_KERNEL);
+	if (!skb) {
+		/*
+		 * Failed to allocate memory to receive the payload. Driver must clock in
+		 * these bytes even if there is no room, to keep the sender in sync.
+		 */
+		ctx->rx_len = payload_len;
+
+		return 0;
+	}
+
+	memcpy(skb_push(skb, CPC_HEADER_SIZE), ctx->rx_header, CPC_HEADER_SIZE);
+
+	if (payload_len) {
+		ctx->rx_skb = skb;
+		ctx->rx_len = payload_len;
+	} else {
+		cpc_interface_receive_frame(ctx->intf, skb);
+	}
+
+	return 0;
+}
+
+static int cpc_spi_do_xfer_notch(struct cpc_spi *ctx)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = ctx->tx_csum,
+		.len = 1,
+		.speed_hz = ctx->spi->max_speed_hz,
+	};
+	struct spi_message msg;
+
+	ctx->tx_csum[0] = 0;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+
+	return spi_sync(ctx->spi, &msg);
+}
+
+static int cpc_spi_do_xfer_payload(struct cpc_spi *ctx)
+{
+	struct spi_transfer shared_xfer = {
+		.speed_hz = ctx->spi->max_speed_hz,
+		.rx_buf = NULL,
+		.tx_buf = NULL,
+	};
+	struct spi_transfer pad_xfer1 = {
+		.speed_hz = ctx->spi->max_speed_hz,
+		.rx_buf = NULL,
+		.tx_buf = NULL,
+	};
+	struct spi_transfer pad_xfer2 = {
+		.speed_hz = ctx->spi->max_speed_hz,
+		.rx_buf = NULL,
+		.tx_buf = NULL,
+	};
+	unsigned int rx_len = ctx->rx_len;
+	unsigned int tx_data_len;
+	struct spi_message msg;
+	int ret;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&shared_xfer, &msg);
+
+	/*
+	 * This can happen if header checksum was invalid. In that case, protocol
+	 * mandates to be ready to receive the maximum number of bytes that the
+	 * device is capable to send, in order to be sure its TX queue is flushed.
+	 */
+	if (!ctx->rx_skb && rx_len) {
+		shared_xfer.rx_buf = kmalloc(rx_len, GFP_KERNEL);
+		if (!shared_xfer.rx_buf)
+			return -ENOMEM;
+
+		shared_xfer.len = rx_len;
+	}
+
+	if (ctx->rx_skb && !ctx->tx_skb) {
+		shared_xfer.rx_buf = skb_put(ctx->rx_skb, rx_len);
+		shared_xfer.len = rx_len;
+	}
+
+	if (ctx->tx_skb) {
+		u16 csum = ctx->tx_skb->csum;
+
+		put_unaligned_le16(csum, ctx->tx_csum);
+
+		tx_data_len = ctx->tx_skb->len;
+
+		shared_xfer.tx_buf = ctx->tx_skb->data;
+		shared_xfer.len = tx_data_len;
+
+		if (!ctx->rx_skb) {
+			pad_xfer1.tx_buf = ctx->tx_csum;
+			pad_xfer1.len = sizeof(ctx->tx_csum);
+
+			spi_message_add_tail(&pad_xfer1, &msg);
+		}
+	}
+
+	if (ctx->rx_skb && ctx->tx_skb) {
+		unsigned int shared_len;
+		unsigned int pad_len;
+
+		shared_len = min(rx_len, tx_data_len);
+		pad_len = max(rx_len, tx_data_len) - shared_len;
+
+		shared_xfer.rx_buf = skb_put(ctx->rx_skb, shared_len);
+		shared_xfer.len = shared_len;
+
+		if (rx_len < tx_data_len) {
+			/*
+			 * |------- RX BUFFER + RX CSUM ------|
+			 * |------------------- TX BUFFER ------------|---- TX CSUM ----|
+			 *
+			 * |             SHARED               |
+			 *                                    | PAD 1 |
+			 *                                            |      PAD 2      |
+			 */
+			pad_xfer1.rx_buf = NULL;
+			pad_xfer1.tx_buf = ctx->tx_skb->data + shared_len;
+			pad_xfer1.len = pad_len;
+
+			pad_xfer2.rx_buf = NULL;
+			pad_xfer2.tx_buf = ctx->tx_csum;
+			pad_xfer2.len = sizeof(ctx->tx_csum);
+
+			spi_message_add_tail(&pad_xfer1, &msg);
+			spi_message_add_tail(&pad_xfer2, &msg);
+		} else if (rx_len == tx_data_len) {
+			/*
+			 * |------------- RX BUFFER + RX CSUM ---------|
+			 * |------------------- TX BUFFER -------------|---- TX CSUM ---|
+			 *
+			 * |             SHARED                        |
+			 *                                             |      PAD 1     |
+			 */
+			pad_xfer1.rx_buf = NULL;
+			pad_xfer1.tx_buf = ctx->tx_csum;
+			pad_xfer1.len = sizeof(ctx->tx_csum);
+
+			spi_message_add_tail(&pad_xfer1, &msg);
+		} else if (rx_len == tx_data_len + 1) {
+			/*
+			 * |----------------- RX BUFFER + RX CSUM ----------------|
+			 * |------------------- TX BUFFER -------------|---- TX CSUM ---|
+			 *
+			 * |             SHARED                        |
+			 *                                             |  PAD 1 |
+			 *                                                      | PAD 2 |
+			 */
+			pad_xfer1.tx_buf = ctx->tx_csum;
+			pad_xfer1.rx_buf = skb_put(ctx->rx_skb, 1);
+			pad_xfer1.len = 1;
+
+			pad_xfer2.tx_buf = &ctx->tx_csum[1];
+			pad_xfer2.rx_buf = NULL;
+			pad_xfer2.len = 1;
+
+			spi_message_add_tail(&pad_xfer1, &msg);
+			spi_message_add_tail(&pad_xfer2, &msg);
+		} else {
+			/*
+			 * |----------------------------- RX BUFFER + RX CSUM -------------------|
+			 * |------------------- TX BUFFER -------------|---- TX CSUM ---|
+			 *
+			 * |             SHARED                        |
+			 *                                             |       PAD 1    |
+			 *                                                              |  PAD 2 |
+			 */
+			pad_xfer1.tx_buf = ctx->tx_csum;
+			pad_xfer1.rx_buf = skb_put(ctx->rx_skb, sizeof(ctx->tx_csum));
+			pad_xfer1.len = sizeof(ctx->tx_csum);
+
+			pad_xfer2.tx_buf = NULL;
+			pad_xfer2.rx_buf = skb_put(ctx->rx_skb, pad_len - sizeof(ctx->tx_csum));
+			pad_xfer2.len = pad_len - sizeof(ctx->tx_csum);
+
+			spi_message_add_tail(&pad_xfer1, &msg);
+			spi_message_add_tail(&pad_xfer2, &msg);
+		}
+	}
+
+	ret = spi_sync(ctx->spi, &msg);
+
+	if (ctx->tx_skb) {
+		kfree_skb(ctx->tx_skb);
+		ctx->tx_skb = NULL;
+	}
+
+	if (ctx->rx_skb) {
+		unsigned char *csum_ptr;
+		u16 expected_csum;
+		u16 csum;
+
+		if (ret) {
+			kfree_skb(ctx->rx_skb);
+			goto exit;
+		}
+
+		csum_ptr = skb_tail_pointer(ctx->rx_skb) - sizeof(csum);
+		csum = get_unaligned_le16(csum_ptr);
+
+		expected_csum = cpc_spi_csum(ctx->rx_skb->data + CPC_HEADER_SIZE,
+					     ctx->rx_len - sizeof(csum));
+
+		if (csum == expected_csum) {
+			skb_trim(ctx->rx_skb, ctx->rx_skb->len - sizeof(csum));
+
+			cpc_interface_receive_frame(ctx->intf, ctx->rx_skb);
+		} else {
+			kfree_skb(ctx->rx_skb);
+		}
+	}
+
+exit:
+	ctx->rx_skb = NULL;
+	ctx->rx_len = 0;
+
+	return ret;
+}
+
+static int cpc_spi_do_xfer_thread(void *data)
+{
+	struct cpc_spi *ctx = data;
+	bool xfer_idle = true;
+	int ret;
+
+	while (!kthread_should_stop()) {
+		if (xfer_idle) {
+			ret = wait_event_interruptible(ctx->event_queue,
+						       (!cpc_interface_tx_queue_empty(ctx->intf) ||
+							atomic_read(&ctx->event_cond) == 1 ||
+							kthread_should_stop()));
+
+			if (ret)
+				continue;
+
+			if (kthread_should_stop())
+				return 0;
+
+			if (!ctx->tx_skb)
+				ctx->tx_skb = cpc_interface_dequeue(ctx->intf);
+
+			/*
+			 * Reset thread event right before transmission to prevent interrupts that
+			 * happened while the thread was already awake to wake up the thread again,
+			 * as the event is going to be handled by this iteration.
+			 */
+			atomic_set(&ctx->event_cond, 0);
+
+			ret = cpc_spi_do_xfer_header(ctx);
+			if (!ret)
+				xfer_idle = false;
+		} else {
+			ret = wait_event_timeout(ctx->event_queue,
+						 (atomic_read(&ctx->event_cond) == 1 ||
+						  kthread_should_stop()),
+						 msecs_to_jiffies(CPC_SPI_INTERRUPT_MAX_WAIT_MS));
+			if (ret == 0) {
+				dev_err_once(&ctx->spi->dev, "device didn't assert interrupt in a timely manner\n");
+				continue;
+			}
+
+			atomic_set(&ctx->event_cond, 0);
+
+			if (!ctx->tx_skb && !ctx->rx_skb)
+				ret = cpc_spi_do_xfer_notch(ctx);
+			else
+				ret = cpc_spi_do_xfer_payload(ctx);
+
+			if (!ret)
+				xfer_idle = true;
+		}
+	}
+
+	return 0;
+}
+
+static irqreturn_t cpc_spi_irq_handler(int irq, void *data)
+{
+	struct cpc_spi *ctx = data;
+
+	atomic_set(&ctx->event_cond, 1);
+	wake_up(&ctx->event_queue);
+
+	return IRQ_HANDLED;
+}
+
+static int cpc_spi_ops_wake_tx(struct cpc_interface *intf)
+{
+	struct cpc_spi *ctx = cpc_interface_get_priv(intf);
+
+	wake_up_interruptible(&ctx->event_queue);
+
+	return 0;
+}
+
+static void cpc_spi_ops_csum(struct sk_buff *skb)
+{
+	skb->csum = cpc_spi_csum(skb->data, skb->len);
+}
+
+static const struct cpc_interface_ops spi_intf_cpc_ops = {
+	.wake_tx = cpc_spi_ops_wake_tx,
+	.csum = cpc_spi_ops_csum,
+};
+
+static int cpc_spi_probe(struct spi_device *spi)
+{
+	struct cpc_interface *intf;
+	struct cpc_spi *ctx;
+	int err;
+
+	if (!spi->irq) {
+		dev_err(&spi->dev, "cannot function without IRQ, please provide one\n");
+		return -EINVAL;
+	}
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	intf = cpc_interface_alloc(&spi->dev, &spi_intf_cpc_ops, ctx);
+	if (IS_ERR(intf)) {
+		kfree(ctx);
+
+		return PTR_ERR(intf);
+	}
+
+	spi_set_drvdata(spi, ctx);
+
+	ctx->spi = spi;
+	ctx->intf = intf;
+
+	ctx->tx_skb = NULL;
+
+	atomic_set(&ctx->event_cond, 0);
+	ctx->rx_skb = NULL;
+
+	init_waitqueue_head(&ctx->event_queue);
+
+	err = cpc_interface_register(intf);
+	if (err)
+		goto put_interface;
+
+	err = request_irq(spi->irq, cpc_spi_irq_handler, IRQF_TRIGGER_FALLING,
+			  dev_name(&spi->dev), ctx);
+	if (err)
+		goto unregister_interface;
+
+	ctx->task = kthread_run(cpc_spi_do_xfer_thread, ctx, "%s",
+				dev_name(&spi->dev));
+	if (IS_ERR(ctx->task)) {
+		err = PTR_ERR(ctx->task);
+		goto free_irq;
+	}
+
+	return 0;
+
+free_irq:
+	free_irq(spi->irq, ctx);
+
+unregister_interface:
+	cpc_interface_unregister(intf);
+
+put_interface:
+	cpc_interface_put(intf);
+
+	kfree(ctx);
+
+	return err;
+}
+
+static void cpc_spi_remove(struct spi_device *spi)
+{
+	struct cpc_spi *ctx = spi_get_drvdata(spi);
+	struct cpc_interface *intf = ctx->intf;
+
+	kthread_stop(ctx->task);
+	free_irq(spi->irq, ctx);
+	cpc_interface_unregister(intf);
+	kfree(ctx);
+}
+
+static const struct of_device_id cpc_dt_ids[] = {
+	{ .compatible = "silabs,cpc-spi" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cpc_dt_ids);
+
+static const struct spi_device_id cpc_spi_ids[] = {
+	{ .name = "cpc-spi" },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, cpc_spi_ids);
+
+static struct spi_driver cpc_spi_driver = {
+	.driver = {
+		.name = "cpc-spi",
+		.of_match_table = cpc_dt_ids,
+	},
+	.probe = cpc_spi_probe,
+	.remove = cpc_spi_remove,
+};
+
+/**
+ * cpc_spi_register_driver - Register driver to the SPI subsytem.
+ *
+ * @return: 0 on success, otherwise a negative error code.
+ */
+int cpc_spi_register_driver(void)
+{
+	return spi_register_driver(&cpc_spi_driver);
+}
+
+/**
+ * cpc_spi_unregister_driver - Unregister driver from the SPI subsytem.
+ */
+void cpc_spi_unregister_driver(void)
+{
+	spi_unregister_driver(&cpc_spi_driver);
+}
diff --git a/drivers/net/cpc/spi.h b/drivers/net/cpc/spi.h
new file mode 100644
index 00000000000..211133c4758
--- /dev/null
+++ b/drivers/net/cpc/spi.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#ifndef __CPC_SPI_H
+#define __CPC_SPI_H
+
+int cpc_spi_register_driver(void);
+void cpc_spi_unregister_driver(void);
+
+#endif
-- 
2.49.0


