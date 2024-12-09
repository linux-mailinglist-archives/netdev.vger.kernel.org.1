Return-Path: <netdev+bounces-150105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA6E9E8EA3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8A7162DFB
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C35215F44;
	Mon,  9 Dec 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AeX6kQXB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88821506B;
	Mon,  9 Dec 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736282; cv=fail; b=aaPaqVJByt10/14mi2h9N2Atx9iMati4VFmwoP+1KRbYWB0uMM3yMznwqGD2sajIJB2Pi7Kd4ygHg00Sd8p5uHQnvwV/8JbiGRWPZecGD1wQ0jgkihvXdBVI9PyZ9Ugzh15q+N4fN8/Mz/81iQHeE4kCWYKgXpwwpz+jMGEJc8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736282; c=relaxed/simple;
	bh=rW+WGruiCt5MnS8V3+9phTk6l2Btlb9QPpjphgqbAAs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JhNEZBCz8jaLyBQTITUHZCR92/4j+ooGrBerIiHGs1RJa5/QhtGfaaTLx8qyDF25cFNQurjFTnsb41FzGtIWvtxAoDDaBYpAH2e5XqaWJS7urtuKtgPkIxxESvAOLHl7ADHhPKthJ6yfRI9y9s8nlvOGLqiN9H5Y5u6fDG9J+Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AeX6kQXB; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xV0KiJFQewqCt91pCGakKPpYKHOBr1kyabpueUSZ9QnCbrENj3hQ7ont7Dz3dUgZMlbDJcKMl3GrjYmaipUkAHlfXsybY24ElP3Cuvd3UJtLpXx3FfDg1bQVgtMMjkIJI6rTkeKNm5wP1bchjbxIrEB+FckTTNyXTkCFU1ZZlaFKYKlvJlam2LOVEIeg9uq8EvopS8ZWt4CxU8MAUE3gXdh8FuvhRVklRMghHV/FgmNiFVR22/bmvpVtI3xw5jGY1FJ79uN3NoQHDh2Cx5NAukWROxSldvM9Y1OTpjhOvVvH1ICU7gzhfgqTqyObDkUFWJUZEFTZuWlLiMROajTumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhwVKgjTeSsCZZ0p0fp2XSaRhYGC+l5ZtH2VNeVEUho=;
 b=eHAcTsWZIuLiD8yzJ/s3Rsrnsw1a9itt90YwoNQuzrIGSolsj6h0vUOyee9Wtnuxir/StRJGNg9swFkIxrCUCVtQt/uVM+7D6h/7d5yOx5oIUSW/n8iaLxw9AOvKDG5gJwZlcwwEvyzQUh9QERNvbTfphcEqSOw1SIbB0ofQ0Tf+61DCQpWGaU3p0lDhs9hfgwuPgLcLl80f1v8Me7qtxOTi1fo1qQk8c16ZaQ9DRtKhB6ZgHHmzkL80PGIAazSSthP8pzZkxLb8pO5ISTQRaA0jhLycdm5hqG9KQR3+WAunOm31j3dS9sJYhVQ3LMchVtKyg3+KPVIkesPs9YNdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhwVKgjTeSsCZZ0p0fp2XSaRhYGC+l5ZtH2VNeVEUho=;
 b=AeX6kQXBUpEIMHn2l+p4PziIIbPAWwO/ks83nnp/tmX1aKenDvdTDsWrDW0DRp7lcmm9SrPAUEcTk0Fe9kDf2YijgDKKY+9Oqs6dDUY/ee2GDMqx5GVMhTEQbO/V4qg9NFa0/7G3ayOvjH1XIdL/J1FOC/57It7WzsqjRCRNS5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:24:37 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 09:24:37 +0000
Message-ID: <bb5320a7-8cc0-fc62-1796-543a400ae3aa@amd.com>
Date: Mon, 9 Dec 2024 09:24:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 16/28] sfc: obtain root decoder with enough HPA free
 space
Content-Language: en-US
To: Fan Ni <nifan.cxl@gmail.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-17-alejandro.lucero-palau@amd.com>
 <Z1NuXSKPvND9eqA4@mini>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z1NuXSKPvND9eqA4@mini>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0084.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::29) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 5343f6f5-4618-44d6-b05f-08dd18334cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MCtEL2RPd1BoT3JyRWFqVmFXMjd0Z2JkUVRKWkVZaTNJU25pOEx3RGhVQlFn?=
 =?utf-8?B?b0lZalI0U1RGTHh3K3p5dHBxd0F6L0RkVy9hdE9ScjBUSE5xSmxuT2pwaUlP?=
 =?utf-8?B?NE9qY2EyZVV0SGU0amFyUGRDRjdqSlY4cThmS0VtRStWWXNZeXpERUlEYlVS?=
 =?utf-8?B?V0xFaldOOXlIbkFJRWthN0I4dytKU0c5U3FvWkdVdWk0Y0g5eVJDZWhLSUNB?=
 =?utf-8?B?NjJDOWV5d3dzM1V0dGtEL0tSNWo3TXQyVHFZZXBrQTkzYkw0aDI2SWsxQ3Ju?=
 =?utf-8?B?TjRTZmNsY2xRREt3QTdOVXBNSHozdlRaNzI2Q2wxbnBucnVtVXU4L0RaZlVw?=
 =?utf-8?B?eGNMKzZOcUdGSjdPaWJTbW96U2lmem5oWm1zYlNSUmNSaDJkaE1xd0Z1YXg4?=
 =?utf-8?B?a0w5eWY3MWNoU244WGFxcUkyYWV2WVFMUmpWY0hQK0oyUmVxbGlESDg1cTRM?=
 =?utf-8?B?eGRUTXJBYVkwaThQVE55SEM2cWExMzEwZGpjNUpuS0sxeXhiakNJMkpqZGJX?=
 =?utf-8?B?VmZtYkZjSGp0aGNjb09ySTdnZytwRnUwUDhLcHh6UFp2bGtVWjRMM3BjdlpK?=
 =?utf-8?B?a0hCWnA2TEJMZ3ZuWWNSNlF5Z0MrY2pWeW5PNDd5ZW1KOTltOU1yYlZER2N3?=
 =?utf-8?B?WlZqOGJQOUZUdjhYT2RBbXYwOVV1a2hDTnN5WTVrNk0wM2lETTFsbUdYd21Z?=
 =?utf-8?B?TEIxMi8wTGFQTWp3Q0QzTjBTbDdpVE11L29JcERzTXNBNS9qQWZ2MWVJb3pH?=
 =?utf-8?B?d0FaLy9CeEJYelN4akd5Njc1ZWxGU2QrQUFoSzczd2JNeVQ4ZmRDZS9DU1Fr?=
 =?utf-8?B?Z2pBcEQwUTN6b2pPMTZRSXpiSXljRjFqZ09DOWtiZVlSak4yVXliRVlrbW9S?=
 =?utf-8?B?QTF0SFJSVzcxRm9GRVhka0NDWVNlOHZHQ1VLWlhwV1pEQS94cHlKYlpSci94?=
 =?utf-8?B?SHU1RTk0MG9PZlBIeHZGZUFBOXlOUXN4aXBEZkhMckwxYnpZU0dVZDZYeEZt?=
 =?utf-8?B?eHFVdnE5d0ltbDJEVGdPbDlGdnBBZXl2UERvLzl1eEZBRnFSTW5lWFB1VTRJ?=
 =?utf-8?B?bm11UjBGWDMyb1N5ZEwzN1ltR1RPV3J5aHVvNDltVVdNYmQrdzVsR1h4OUYr?=
 =?utf-8?B?bmpRVnM1bXp5d21ERlFFZ1Q3eG1lZWxjVENmdW5McGZ5cGxQek1zUHRValJS?=
 =?utf-8?B?NnBqS0dmekJ5NWhQSGFCZFgwWXlERDQ1aU5CQ28xQzducldQcmd0MENabkNt?=
 =?utf-8?B?TzZvbW1GMkxZVVlpQ3U3UUpYTVNJZnVEL0VMcmhUQzNMbzhURWRnSFRDdGMy?=
 =?utf-8?B?cmRkOExVM1FYUWFTNGhFMGJFeHpZSUhYNVVOcmh5aG5vOFlmQXZLOWpyTHRI?=
 =?utf-8?B?alVLVHdUNkNtWkQ4dTV4NWV6Rk9WbXlub0ZEcGxZeXdrOGQ0Z3dRRjJZUkRN?=
 =?utf-8?B?cW1aS2V5N2VTR2FDYUFDb3ErelB6UTZwaS8wN1JjNlRiUkNycWlTY1Y4Mlc3?=
 =?utf-8?B?aU4wUmRtYzBoSGFRNUJMdlJuWmpYMDdBTXd4bkxzTUVJOXJWTC9MMFdIUklp?=
 =?utf-8?B?M0s2R05LMjdoUmJVQTZNRFljLzVCVm1ya2ZNZnVDUytxZkFwRk0yUTViclhx?=
 =?utf-8?B?YXlrMStub3E0SXBVekdyWVZsNGlDamZPSUhWYm9nanZveGhsZU9PSFpWeGhQ?=
 =?utf-8?B?SzQyMmdLUDFoTmgzQWFjMFYxKzFKaXk3eUtrQkM5eEVRT055YnNsTHVBRHg4?=
 =?utf-8?B?cjh5dVNuYVVvUnZCcEhQSFlNYnNBczFYSUZhbExMWFEyOHZYbG5uOUNmS24z?=
 =?utf-8?B?d05CV3hNSDBJNkxlNkw5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnhyOW9pQ1VxNjRTdE5ra2FYMmdtMExiTUhtMzYvUkplUWQvWHM2YTl0UzdQ?=
 =?utf-8?B?OXBLSlZqZnB0Nk52UW1GQUZuMUZ1Y3FkRVJuN3BRMkVvYml3QXVvV3BOZjVG?=
 =?utf-8?B?dmtBNktJZGdlWHp5ZE1JVzdIMnF1T0hKR0hZUDhxZlJZT09ZRGlwaGwySGRz?=
 =?utf-8?B?ZjZkT0l2aXlaamJwTnB0QUdFcUdWR2Rtd3NzS283S2NJaEJTK1diM3BWWUZq?=
 =?utf-8?B?cHdONUVIdjlKN1dVM1kxMmRNVGNoT1l6c0FvenNYNnYwaVZyMW5mVFhhQzNN?=
 =?utf-8?B?djRZNUpBUTNVdS9aQjJlVnc5WjhqR3Y1QUhoUGxDdUlYNVBkYjV5akVNTEFy?=
 =?utf-8?B?enhOeTVESFFGTVdsVy9PNEZNRmNNQTQ4bjFzYlpic3IxTlgxaklnYVpjQ0hF?=
 =?utf-8?B?cDUvakErUnRnampmdmFBY0ovMTZYZDducGxUZXNISnRmOWNNTDVyaGQ0clly?=
 =?utf-8?B?cnpsSVpEL2NPOWlPcGVpSXNkSFIxcVAvajVZWER2eTRMemZ6b1VzUi80eWZP?=
 =?utf-8?B?RjJMMnUrMTMrSStOUVAzVFYrZ205MEt6aVhoMWhsYkxvTVQ1Y3VnUUc5NFdG?=
 =?utf-8?B?WkZ0Tmw5ZnVaL0FYUGFpekticVZqYTM2TGljU0hXK1EwKyswSERFMFF5NTN6?=
 =?utf-8?B?YmZLZ3kveCtjbkhKYSs5NGZ6amhETDlNSzJVWGMzOUt4YnpHSTgxN2hlN1VD?=
 =?utf-8?B?dW1SOERzSlYrdmJhL1RSbUpTVGJlVHhpNkh5ZC9VWElJdkxVQ0JoNVAzTUlk?=
 =?utf-8?B?d095ZEF1OWphcTRESWtwdnpadWlCUUtxQjJRMXJ1YUUwQVdaQU91YnA0RjJC?=
 =?utf-8?B?MldGWGw3enZWN1UrWGFuSDYrdm03VWhwMHdTVlorZzFiZjlYYTRmdUNubWpr?=
 =?utf-8?B?K0c1NGFjNTVZSVNvS3NYWll3Qmg2RFYrdVVyRFlRYmJJTFBUcTFWRTRKd1Qx?=
 =?utf-8?B?Sm9VNlJ2cUlJYWNrRzBNM0Jtb1FPN1U3blRyeUp3T24zd0NXc0RJUkRGMjlx?=
 =?utf-8?B?K2xWM0ZoVnYzNWlSVUZHQllhZHZyTHR6TXRUd1BzUlQ5TS9qL2xnVnpnNGZK?=
 =?utf-8?B?MTJITnBBWnFvYS93aytFY1BwbjdraTkxUk5CMlVGYXBEd29rYXhGb3dLbGNn?=
 =?utf-8?B?d1V2Q1RXQVVzaDlJYlEvb1V5cmplM3VxYTFDckNuVFBKU3dnOFNwcEdEV0Ix?=
 =?utf-8?B?SlJLODM3Qkp3dTBXSzJjSFBNL3puMnpFdjNLdHFXakhjcFVJOE15S1NhZloz?=
 =?utf-8?B?TTRsZFFpQ0hlZHUyNTdlSjZsVnhmNGtJNjlRMjJwWFJjbzRJS0JaNFVzS3pP?=
 =?utf-8?B?V2pVcTVzVmJkVVpQa1NKRm9EeEtBMEdVYmNZN05IWnkvRzJQY0VVOUtFQThn?=
 =?utf-8?B?TFd4dnV2aEQ1Nktjc1ZBdXV0ekZlUUVmTHcxVFdKOWJiNFVaOGVVT1FDWkF5?=
 =?utf-8?B?QjQ5a2xoZ0traXhySEVnamNrUTd2QVkyNlBlWHBYWUpsZ0pGMGZsRzgweUNJ?=
 =?utf-8?B?WWM0aXNVVVdxbVpaZHRySXZHYzgybk91bjlQRFFYVHA4MjdzVlJpYWd1eVNP?=
 =?utf-8?B?eS9DbzdXeTFXWVdMQ1lNQmUwNDczK2dxb29HZTNqZDYzK0ZFTjc3VTdqYzdV?=
 =?utf-8?B?VlU0MUV3WEQwbHdvdFNSMkkraDBJaEFpQm40N0lsL25NMUhQZ2VKZWpPUnRt?=
 =?utf-8?B?RFdjb1FEUmZzZmxUWnNEcmdwYW01L3VXVmN0djVhUFNYdXhvN2lsOEQveHVL?=
 =?utf-8?B?WjhlZDVQck1FREdZRWtsTjBERW54THFFTmhnOWFENVBXRlg4OTh1bEdsdG1R?=
 =?utf-8?B?WVdYMzNWSjlGcDVRdDhwSmNTWXdQYzBvRmdKUldNcEtSL1UrOEtQSFhRU1BQ?=
 =?utf-8?B?eHNBdlFWSG9ZRlhHWmhtbStPMUJVZmFMOGFPNm5hRXlicE1mdFJrUHEvcVhM?=
 =?utf-8?B?bElFQm1JM3czRmhNaGptQUNwZHk4WVFSNFVTYzVUK1JsQnRNdkREeVluQ0Y2?=
 =?utf-8?B?UmM2L2F6MWhrYnNwcXNueGRFajZkWmcyMVBDSDlMVTJVTXRoclQrVysvZmR2?=
 =?utf-8?B?OCt3K3pWOWhZNmZJM0VxRTFlTzdBaGM3TTZSNEljR0lVbnB5c2x1bTJTL1NE?=
 =?utf-8?Q?RbR34WaWq4Q35NNs04Lr9RXk9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5343f6f5-4618-44d6-b05f-08dd18334cf3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:24:37.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhwWexkzjkmh3Q9u5gWgybq9JEsHYyjsX/lGOgKCTubEnErkEEX9R9995iB5J5NBo85+W9Uwp/J69Xls8J+Dfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397


On 12/6/24 21:36, Fan Ni wrote:
> On Mon, Dec 02, 2024 at 05:12:10PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Asking for availbale HPA space is the previous step to try to obtain
> /availbale/available/
>
> Fan


Good catch.

I'll fix it.

Thanks!


>> an HPA range suitable to accel driver purposes.
>>
>> Add this call to efx cxl initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index d03fa9f9c421..79b93d92f9c2 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -26,6 +26,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct pci_dev *pci_dev;
>>   	struct efx_cxl *cxl;
>>   	struct resource res;
>> +	resource_size_t max;
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -102,6 +103,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err3;
>>   	}
>>   
>> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd,
>> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
>> +					   &max);
>> +
>> +	if (IS_ERR(cxl->cxlrd)) {
>> +		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
>> +		rc = PTR_ERR(cxl->cxlrd);
>> +		goto err3;
>> +	}
>> +
>> +	if (max < EFX_CTPIO_BUFFER_SIZE) {
>> +		pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
>> +			__func__, max, EFX_CTPIO_BUFFER_SIZE);
>> +		rc = -ENOSPC;
>> +		goto err3;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> -- 
>> 2.17.1
>>

