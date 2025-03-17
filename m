Return-Path: <netdev+bounces-175200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B5AA6446A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C6E7A56CB
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 07:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFF918C33B;
	Mon, 17 Mar 2025 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zc4bpSoJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4235789D;
	Mon, 17 Mar 2025 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198204; cv=fail; b=l0bLcTq2tmO4W2Kc1n/qh2nOK9i4MW/rpBuldm19c1o8FbLXnBI6uC1K5tRlM3nvXQPj/gzwcYbe6EX2EiFZS2wBWe5KFBZtwZnoCf86vQOvLBJV3i9KOYvz1DRZ00mn6GnERQmja244hO5dFfmD/SR+yc4dBxs71leLa92JZd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198204; c=relaxed/simple;
	bh=YRQ/0TaMb55NfbFd3IhvS1lQGe3fK6p9e7IBgiRaRh8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rb41UyUIG5ikRqcRiyagEufU3hCI4G7Sw5A1WzNMEWjl+s+iVHvNY/U+3hSV44oaU3HyOQvIES9Uq5O539KueE7mo8zH8iTQYxA0gm6lUxa90XOZdK7+S05BmCSVIsva6EfOzFVp/scrMI5JlGiX3kp2H5xgUrmUe1LsX1BAd04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zc4bpSoJ; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SG2vi8RkNhurhHzqkkRJB3cuUG5gl+aUako8AHTguKoGFXCDCyAO4sjvlxYUisTRdYmmSOeChiT0LU+iPqayWFZDzloWxDWySIFgWK6QdFQ4KmeQWJUZR53AiGSz1p6fiV0RRX+kpbDY+r5c2bn6q4bRx08AqkuxxHnOX7Zno+agdNU3QsAFJWEKSscdsn4LX3qaKvqjZThRWbWvDny+GQV1T2ByqWIK8c1uPhWyxV91Hn0rKFvBnMF3QhdYjGzzCPSSQIAMuCOAMk4t8lhhKfNx/6MPY3q2YP6ydh7l1AU31jZG6zEVZoYHjGriDIrx5HDkAd6fhhToL1wAhfFF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yyboo/1M/p/Fdq/a0Xh+Bv02AW+/5aK4pTNNxKiRrTw=;
 b=bsZnRQ/M6tA5quBFwvwHNFfmUUFjnHlLVJgDbxjPXIXja1ivlOue/Y4jFP9azrA41pvUIJQtKlXfllva/zGzcA17dB1FfCRYwusNY3C2LIgpcTEYsbVrNQyw4PVzoH1ZggQ5LKqYBESWSuooOFuvulpbncyXjZIsV9rZDOC+EWdovUVkh4y0J/d2ou5VZa0cW8+inqtAqOO2n4QN1T7wBMBWUJYb17tK/yHyCEZWMe8ByaOHdgiAOyjx75guBOThPbLhD48nKhIbOXm+RLYOaqW1WGs0UUna9EumNgpbNIWJO7vFZKw8Vx+sOwp8j9h5qoZZu0DcrFvtAMdjMA3lIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yyboo/1M/p/Fdq/a0Xh+Bv02AW+/5aK4pTNNxKiRrTw=;
 b=Zc4bpSoJTVZCSKCyhdczbu+q6CFtsygGh5g3dTDjUQ6svmet5V4R8pmmvEZx6onAfRAGH65v4VObDiCXSz443cVDoTPOvx+ErbJ2Txg5VpR61iNUivXmU7+yXUyxZDrDK/cubNU+l2WpwGExJS9GYec1qxTiD3uRgJck/x4A8uc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 07:56:41 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 07:56:41 +0000
Message-ID: <643d8d83-aff9-4a2d-a2de-82f19161587d@amd.com>
Date: Mon, 17 Mar 2025 07:56:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/23] cxl: add type2 device basic support
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-2-alejandro.lucero-palau@amd.com>
 <Z9HnyctYzFkVBW5u@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z9HnyctYzFkVBW5u@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB7PR05CA0047.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::24) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 41664905-4cdf-4668-851e-08dd652940af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1NZOU5kbjVZVlVWMGFXRlBacnN4Z1liZlBoSnZsVmp2OHdDb3hmK2JWbzgr?=
 =?utf-8?B?QStCVlBPc1Y3Rk5OWkNOZWtTNjlFUXNRZ2QyK0NqQlJHVWE0Tzg2YWx6YW12?=
 =?utf-8?B?V25JbUlVTFdmS2lsRGNldnRMUlN0WCtDZmdGdkxZeG5lNFEzQktDNFVkNGU4?=
 =?utf-8?B?KzlBbXRmUUZQZWFjTkt6eFFLR3RQTFBKUC9naW1jQzExaDlybDhaRktvQ2Zw?=
 =?utf-8?B?UkdoZWRQbUlZR2o2d3RXYmY0L3RpelBjeVI1UWZXaXBFQTNOdHlFYWZwSXBr?=
 =?utf-8?B?OW41N0cvWFoxL2doclJNT242YXRqaXpoL3FYb3Jad0NsU1EydXRjL2w0WmJw?=
 =?utf-8?B?eWRDQ1RxcUNpZ3RwUWRUWTh0NU0yVmR6WFlSMWRQcS9BeVVKVGZhSjVOUDZi?=
 =?utf-8?B?bG40VWtHS3NlWlJKcEFIbU5UT0Y3SXpIU0VzRE1mK0NpQkNPTXhCWlpyakhn?=
 =?utf-8?B?cjdTdU5uUlBBTVRHRXJTTkh6Z0prU2FPMEwvV1djTGR2TXVrNFR2WTcwYVpn?=
 =?utf-8?B?V0JyM0J6S0pQTGJQVXBFUUxJSnJhN0wrZWQvT2xEUWZIdGFhSTNRQ25RVHpP?=
 =?utf-8?B?WS9ia1JsYnVmeE94UXZPVlNzUS9wV1V0ckY2V1UwMmptMDE5aXloTXJ2bnRa?=
 =?utf-8?B?c1hSS3BGbjRVYzNpT3BWcXdsWkdTUkVRMHo3ZlpHaHc5UWtuN1lZU3ZsS3FP?=
 =?utf-8?B?ZXd6TDRhbXNSV1BKNzYwN2RpQ1JYQ2d3UUZIbTdLRmsxS0VZdlRQbyt0ZG9Q?=
 =?utf-8?B?SXFqaFF6Q3FDNXNiUjN1SmhmdG15ME9OQnprM1dpaTd2TldKVHNYdzN4ZUty?=
 =?utf-8?B?YmhGNkphczRRSUZLWkFIMTgzb2dQODRscldqMXRzZE9WU2hwdjdpU0J0Y2dy?=
 =?utf-8?B?dkdmd0tiS1E3UVFXV3hsN2IzaEppNm5tajlCK2d2V3A3d3cvVFdoalVUNEh4?=
 =?utf-8?B?dDU3VWJESFlDSEJVVmFzRjMyNEJVaFRJTWxoWkV2VWkwRzNLb1BwVTVLNy9a?=
 =?utf-8?B?YVYwa0YyYzlMQnFiMUpzc3JSU0ltb1ZDa2Y3bS92TmVYY3pkeXFNU2ZoK0F0?=
 =?utf-8?B?aTBpM3p6Ym1LYmpoMFQ0SlNpY0VnOGV5ZnorM0YxUldvQzdNYzRPQXVQRVJw?=
 =?utf-8?B?ZS90YmVKejE3bEtZUTVIRUtDNjFDMDUvc1RjQThzb2ZhZzlMU1YzQysxODR3?=
 =?utf-8?B?M2ZHeEkzT0g4L2xTWmZrL3EvRDNHQ0lWNVlRQzRTbnZIbmlaTzRKRlBuV0ZG?=
 =?utf-8?B?RWxzaXIwWTVTMktJNlZYeWI4dVZQVndaU0RCN1lsbDgxNEUvaEp6WEY3SFY0?=
 =?utf-8?B?VUYzOW1UUFFJZGd6bUQvM1V2S28zcWFUc1VHUS81U2tqTDFSeWZnMzlkdGRI?=
 =?utf-8?B?M1hJeVNKaHNuNy9IN1c3Y2tha3QwR2xmL2ttMU9qL0RScUxJQXFhb2h3bG9n?=
 =?utf-8?B?eGl3NEZPcG5XU2dNSDNkU05ZMVdEKzVsTDVUV0h6SUoveVZNT05HQXVtSStI?=
 =?utf-8?B?ZWtKV0lyWnJVU21QRmJrNFovdkJyZ3FwZXVNMXFtUlBZTUVML1JsM1A2MWo2?=
 =?utf-8?B?MU8vZy9rTWw0OTc1M0lsT0FXZlE4QjVzQzlsdXZOWVNldno3R2JrWmpIUC9D?=
 =?utf-8?B?dDloLzc2T2pIM0ZiWnFuSndOM3pkZHdhMmdRejhIbCtYVU1iUzNYQm5Oc3Jy?=
 =?utf-8?B?eHhmbHY4SjQ1VXdXc3J2YWVSdDdUcjVXNEtKKzA2UHJhcVpTRm1UWGdGcDE1?=
 =?utf-8?B?dFdIa0U3M0Z6WWdPYWFtU2czc05iQXowRWEwTW9qQnVvTHY5Mkt2NkJraE5u?=
 =?utf-8?B?cGZBNmppbUdOTklNOWNKOWpJTlo0RkF0TkVnRHpqcFNlYnZGbEx4TjJLWTZ1?=
 =?utf-8?Q?OIhRNRSkOPHbc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTlpNmwwaXMrOStqdVp6Uk1rbEZ5VS9yTDNvS0pBZk5raTFoT0UxaVBnckI5?=
 =?utf-8?B?dVNrdU9EVmJOZENhTEJQa1N4OVRNcStlQkEzekRuSERNYTlPQWFPZ3RaaFN1?=
 =?utf-8?B?SmRHemxvcm9ZS24zb25zY2IwTkhPbDFnc1ZlQksrTXhzYkg2bXRxTFRxK2hu?=
 =?utf-8?B?QUw2Tk1OMjJPSkpjYW5ORDhSZThlM1gyVDlJdklUMit1Zll2b3MzOCtXN0Fn?=
 =?utf-8?B?U3pBeSt4SE13WEQ5SnpYbG1YREVGOUl1Y29TZmwyQitXT3kwOTVFRWFJeGNr?=
 =?utf-8?B?SlZxVVdJS3AvUHdyOUJnNXh4VlVEOGZNQU5qSmhnd0dMeFpDY09lNkc5eDlM?=
 =?utf-8?B?K3JVdW9HTGZnMHZkTGFLZHhpU0FUS0thQkFaMWNvMVh5dlk4b3pWOTc0dHpa?=
 =?utf-8?B?MVdUeVVCVnE3ZE9UNm5wdG03RnZHR2p2TC96Wkd2K2Q1WTQ0RmY2aW1wdG1D?=
 =?utf-8?B?OEp4U2MrK055YVBKL2dCa1lNVFcyZ0dhL21HOWx2VUFRQ2hDSE1vY0J6R2F6?=
 =?utf-8?B?dnFNcXlXblpqZi80NTN1OGpYcitPZ09acmJsZWZ0OG5OWjNYNFJBL1ZWMWNh?=
 =?utf-8?B?NlhuY0NGRVB3d3RMZml4eEZ5OFgzRHMzaGJhYWducm9MUzlxNG1BUXM1SGhE?=
 =?utf-8?B?djdUVjZWK2xmZFQ5dWRTZ2cwb0YyWXhqeFdxUFJPRk1hSDkvNFRUU0tWUU8v?=
 =?utf-8?B?RVA4YndtQlY5cjV0Q1pLWHl0eWZMUk1nZ0JGTFd6TFVIenovSHRBSTFtMldw?=
 =?utf-8?B?NW44RUJmcnRmY3hvbWRBMGRIODRlUGlqV2ljTlhzVlZmWlp6TmUzOEVLU0tS?=
 =?utf-8?B?MGI0UWd5SDRrS3NDR01hQjZvQVY3RHJsL2FrcThwcjdzbjNFZzFJaFBucjMr?=
 =?utf-8?B?MkVkdzJEU2pXU3dWeFdBWmxlMkhxRkZYTm5KSXJVSnA5RWtPNWNrLzZES0JG?=
 =?utf-8?B?OGtNMkJsbEd1Qm9IOFA3cVc5R0ZFeVJBUEQ2WVFUQmtiR1pVcCtXM1NvWFFC?=
 =?utf-8?B?dktmTWhmYVF2dS8xNC9UMFhtUzJrT1ViWEFQS1hxR29VZmh2VWZEd3pOVThx?=
 =?utf-8?B?Z2ZZVk5kenBlVXVGVlNsRHNXQitlejNRaEVhNjh5MFduU0VZOGNaUGFEV2g4?=
 =?utf-8?B?LzYrcGtEU3pqSlRjVkl6bGZrOU1TdlhXaE43R04xeDh5NHRaYlJBTzFlaFZV?=
 =?utf-8?B?ODRnUUV4NmVqVzVqcDc5a1ppcWx2S2RlVGNybHV1NHQvVitaSGRyODFQWUR3?=
 =?utf-8?B?ZFhEa3p5VHBSRTVJTkFoRUhVWFYyazltaEh6Z0s1bVg1Q2h4V20rWW9CL1lT?=
 =?utf-8?B?cEtzNnQwUHFsUW9MT1BTN3BxZElhaGZhZlFtWG9keUh2eGJmYmlUYlRDMWZD?=
 =?utf-8?B?TzlubDVxWWJRdyt2RkZjV1FobmZpbTA4dkVKTUt0bC9YVTJvdWdxamd6OWFn?=
 =?utf-8?B?N3graVREYWlnaXY4SlZOSWQ5dmJkd3lBUHBjS0hrUEFFNytBTDZXb2tGc3V4?=
 =?utf-8?B?UllRQ202SzJNL1pqUzJOL2xrTWdqd2Y2UDRFUzI2UFB0a2IwT3FzMENPTkZt?=
 =?utf-8?B?UGZkYTJ6R1A1aXdBUy9uRy9JeTNpK2JkS3drZFdoL3VVRVU0R0RkOWI3RVNq?=
 =?utf-8?B?V2duR2JBcTFxYVVPbkdUUEJqMzd1c24yZmtITC9NWkRYcWQ5enpmenU4bEhO?=
 =?utf-8?B?V2IrY2RqMlJRTDhIaFJoVG1kQTdEdVpUS3VpYVdlT3E2Y3k2SklFWFFadG5E?=
 =?utf-8?B?dXhTc1ZrU2t6TDJVeVc3ZE5kcnhrT3RsZXRqbEtZZlB5bEttRDFRQzZMRTdv?=
 =?utf-8?B?UWNuUEw1ZzhlNHB1cTY1MmlUNDF2d2JYeGY5cUpIeGxYb0g3NlNDQ3FYRGpF?=
 =?utf-8?B?N3lPd1EwODFSRHBEdkdqTGNtTHQ5K3o2UlVPTnBycnZDYSt0RDBiU1FVYTJI?=
 =?utf-8?B?ZXluUk5NRTA0Tk01K1pwR0JpY09WTTBrVFR4K21sem1uNUNHTTNKUjVCMSt6?=
 =?utf-8?B?bXlnbnE3d2FpclVmMzBPL0ZUWUxNMzRvZk0xa1JqZjBmUU9BQ2g0ZTFlNGQ2?=
 =?utf-8?B?WUpjQ0JkTk9IWDZMVU1iZEhKSW9teUR6bVJramgrc2FGREJmZHFEeVRVVGM5?=
 =?utf-8?Q?uVSimHbqXpYU+fHMtuu3mQqcX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41664905-4cdf-4668-851e-08dd652940af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 07:56:41.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZC0WfV+zbhtjIwmHHIh3iz1xaZjFqgYCEOroT08t9HDhnWzbAxg2/FHuHCW/2s2D0GunOr3W70Z+5lxNwsH/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238


On 3/12/25 20:00, Alison Schofield wrote:
> On Mon, Mar 10, 2025 at 09:03:18PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>> (type 2) with a new function for initializing cxl_dev_state and a macro
>> for helping accel drivers to embed cxl_dev_state inside a private
>> struct.
>>
>> Move structs to include/cxl as the size of the accel driver private
>> struct embedding cxl_dev_state needs to know the size of this struct.
>>
>> Use same new initialization with the type3 pci driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/mbox.c   |  12 +--
>>   drivers/cxl/core/memdev.c |  32 ++++++
>>   drivers/cxl/core/pci.c    |   1 +
>>   drivers/cxl/core/regs.c   |   1 +
>>   drivers/cxl/cxl.h         |  97 +-----------------
>>   drivers/cxl/cxlmem.h      |  88 ++--------------
>>   drivers/cxl/cxlpci.h      |  21 ----
>>   drivers/cxl/pci.c         |  17 ++--
>>   include/cxl/cxl.h         | 206 ++++++++++++++++++++++++++++++++++++++
>>   include/cxl/pci.h         |  23 +++++
>>   10 files changed, 285 insertions(+), 213 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>   create mode 100644 include/cxl/pci.h
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index d72764056ce6..20df6f78f148 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1484,23 +1484,21 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>>   
>> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>> +						 u16 dvsec)
> Please fixup cxl-test usage to avoid:
>
> test/mem.c:1614:15: error: too few arguments to function ‘cxl_memdev_state_create’
>   1614 |         mds = cxl_memdev_state_create(dev);
>        |               ^~~~~~~~~~~~~~~~~~~~~~~
>

I'll do.


Thanks


