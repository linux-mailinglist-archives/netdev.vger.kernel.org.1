Return-Path: <netdev+bounces-195800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1C4AD2475
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E95189174A
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ACA21D3CC;
	Mon,  9 Jun 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Wk2lKHAk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089921C161;
	Mon,  9 Jun 2025 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488000; cv=fail; b=PRR6eSdjt9RnWnm99AOB0q7F1AZB3FQ2qa7SeNkFN1j6tWbhqkwjNSC/tk5lKgc9jMvdXrRv0yAcArzGLa4lu4puFL89G6W/UcDghbUnazprv9Kerz1EQ5Zmm4iuwghyNVQt/5XwmlRHSBnKqo59qD41cu5S1qtWvUbqFYa38+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488000; c=relaxed/simple;
	bh=BPQu47ge2jZW9CkX97AuLAi+sQYUK2hZuPZVsJ37CUc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ueVUqAbKP27by+/r3oRFvvfL0ieAonW4XJhkGIxdCfFS/0ScU1MbJLIvmMco+P8mXuVOIoMHF9LtTE3Iqso6OeYMQwp61o/2vxadoRTO2dPWtlZa7QRJDucRHbMWLPwOmCTbtQsN4l1WTerWItyRbZw1bcubO8tGInGcDZsX7F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Wk2lKHAk; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auuRtDXugFj0x7Ob3gyL7l+vi0mn1vjCorVCaIf7A2P1NgT7S7eVfDl7ehrnGNGtlJwnHBsT7Sx73uRXgNF96xPoD1eQIorgpGXeKOQcTorBff/1i1epPvKtHEocCo44FEQc6qs2jTQ/kQuqEbQsFSVvqH8IQi6Tepwl1i8/f5Qiur3Esn+1lkEr6dxD4PdONz8VVCXUya//pUsL9Tb5kOH8Z5lDgqlkiMa/27x2pDzGncZBo10SNkDTIuMBurhaJTG0uMXHYBunu6LYD+hMQA0JQT3tgmlYipWvN7CTGft3RmHcRATTABEX4vdKVOWaQbMSrgYSHcWzBs0w63IK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwGlQqbWfDW0Ooaa804R0BiYkAZOhpGCf7azpYDKN3A=;
 b=lAfaTRq0xqVKqBoOIs/MNrBpNJCBjYWiIaeDlW65YQGUzU6ST+QK5/bSIVmcCxLbbqQrgzBc6pXWncaCBnE2nggEjwt1Gh8h9YzzL9JtLJ9Ez2A658b2FRdEdGEx/S8Q7+ki/ZBkALTMpOFwP1F5DHptg7PJOoiKfK1EDc9c1/+8xhcpbRVzQpXFTCWKlBLCq13TCt5EbaknVgqWTfYE2hxh9YHPQq0cFNUmf0q3TGegF4p6iL8apR4O3kWPaiUfdHRacwZcUdDtEGr8NGuzI+mChSJzloDvxmtXMsUav0Ytc/1W+T4PPuahFDwJJmpuiOBSylQhb3XBJLig+b7qWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwGlQqbWfDW0Ooaa804R0BiYkAZOhpGCf7azpYDKN3A=;
 b=Wk2lKHAkp5TnKy5xugSS++cHIB2IDu8LRskhdOIZKO8lusF2ETE7e38YDgDbbUTF7ygPMv/3UTwbi4JIX9V2Q8yzs1ihUgIkqGGlvDbEzfIOlcThf4tiZpQRuLkNSrHECMkHHYjK9FH2vYO9K5qmnZXatKU22mNa9ujJ4Jve5AW1rCR+IbM7vzYueOpAPSQFBxvOL6qeVgA96S1eNTRXfFO7HBFHIsNhGpCqvKy8qUAER1xWs8AXZb6y7D5XSs7z9+DQc0l5cU2477P7q/d6yV2j8PwtIs6/WQ78IjAliLLbc1UVfFEq9INtsSLGeXmhHAqlBfNIwjnpoFp/Ia57rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by CH2PR03MB5270.namprd03.prod.outlook.com (2603:10b6:610:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Mon, 9 Jun
 2025 16:53:15 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%5]) with mapi id 15.20.8792.040; Mon, 9 Jun 2025
 16:53:15 +0000
Message-ID: <21b13081-b54b-4499-bf39-99ee0546369a@altera.com>
Date: Mon, 9 Jun 2025 09:53:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] clk: socfpga: agilex: add support for the Intel
 Agilex5
To: dinguyen@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 richardcochran@gmail.com, linux-clk@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
 Teh Wen Ping <wen.ping.teh@intel.com>
References: <20250513234837.2859-1-matthew.gerlach@altera.com>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250513234837.2859-1-matthew.gerlach@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::13) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|CH2PR03MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a521edf-8ede-420b-2b79-08dda7761fd0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGdLMDFLUVJ0WkxqSjdSaFErWWo2UVJsWkFNTGFCdlhUSk1QSUQzZzl1S2tz?=
 =?utf-8?B?QkxxbHhTNGhDRGhCVGNMRG54MTY2czdzWThIeVIwWDJ2VXAzaUs4R094dXI3?=
 =?utf-8?B?WWMyRlFnNnZVODlhMGtlTy9weEQ2cTVzYTJGOUc4R01rSXMvTWovVXBmL1V3?=
 =?utf-8?B?V3hraXh0QytteTd3dld3NENBeFllcjNvRmpPUVVpdlZzVVdVRnN0ZHZQeTBY?=
 =?utf-8?B?cU1KZjlTZS9QbDBxMlJoN3VWWHZPSzBhbzZ0bWNFWmxQMnlxa2xRNCttS0xD?=
 =?utf-8?B?UlpIVlY0T1FXSms2eGpPL1hCS29TQ05na0JmRUNYZ1pVbWZJeXZxUlZERlhJ?=
 =?utf-8?B?Rk0xaGRpTFR6bzBDeGFhbkt0NmJPYllsUnlZT01VSXhNL1A1bS8rMlVaUFdo?=
 =?utf-8?B?RWNvQ25LTDBUUzJMRTJieWxTZHhpR2pIQ0VHaWhnaXpRa3ZtTExWdU9QeEhr?=
 =?utf-8?B?TjdtSEpCQnpRNFU0ODQ4QWFRckVTdHNoMmZJUE1SemtWQW91Y2ZrOFlwaitE?=
 =?utf-8?B?ODFHVGIrTzIxN0luUDBVOTA4MWs3a0VjYXZrNklGekU1NkZvOGF0UDUxK1g2?=
 =?utf-8?B?cnB2bHJ6Nm1CSUd6QTFBalRwcVFWSDJ2R2xvWTFWR0RHcDJNQUNQRERWSkNW?=
 =?utf-8?B?enZrUHE2T3ZXK0cvU2pabEZVZDBSaDdiTzN5RGpoRkZOUXpZUVNhNnNNT3Nz?=
 =?utf-8?B?M1V2a0VSQmRCc0gwOUdBamxhQS9wTUk4UlRkN3pWUXlSWWpoQVFac01GUTdX?=
 =?utf-8?B?T1diNG1mc3JBWlFXT0hhVWV6OWI0Y0dTRmJGcjFjZHJsYXNYS0lNWE1EdzZ6?=
 =?utf-8?B?aXNzNHJ1a2tJcElxTnp3Z2JnbnRRWHlybk9keEk1dEhsc2pveHV3UlBOT00y?=
 =?utf-8?B?RXduU3R5SWVsM29oYlF0aWJGUWZGT0FYSUNhMFBpNlYyRkp5RjhCQnYvaldU?=
 =?utf-8?B?TlFDRUtUOFVNWG9Qa1l3NUl3cnpVVFVUUEMzVFpaeHdndytJamNIV3hLbUJv?=
 =?utf-8?B?NGJ5V2NUMktCaTdoeCtRaTJ4ZnZwTVhJb3pwM1NzUnJQejNuRXpHcjVyVkhP?=
 =?utf-8?B?c1V4MGJORFF1Z1FkMkZjR1NTMlFRME5GWEZnaHJlVDRFQ2R6c0VZUjRZa296?=
 =?utf-8?B?VXFiWUZTcEkyN0oyckJhbHdWcEVwWnowNTJuamsvSkN3eU5keVlzeTJSaXBa?=
 =?utf-8?B?bURoclFmQ3pSSEtHU0pZYnZkbVhlTXZDcjlTZ3QvQmxTN0xJUlZ4QmlHZFFa?=
 =?utf-8?B?aHNuUnZKZEVFK2drTE5jbHdwSEplamFaMmF4aHE2MkVEOFRlTmdYRkxKWUlm?=
 =?utf-8?B?TUY3THZkTXU3SjZ3Sk5zUjAvbXRpUmNHc3cvMitPSE56clBuQnBSYjBwbjE5?=
 =?utf-8?B?UEdCSmxDTXdrTU9iQWx5amkyaGhzdDhPTDhJQ1pna205M2J2ckh2NjE2VFF3?=
 =?utf-8?B?ajBVOWsraXpjZFBlM25RVzdkUE1DZGhYMEdGcVlmVFVLVnpmUm5pMktxUHlw?=
 =?utf-8?B?R3VrWGtjbjM3cjdWNmFKeVdrOCtJQlNsYXhJR3hOMmg0TzNjcGZ0d0loTFN5?=
 =?utf-8?B?QTNNYXc0L1NyQzRCSk9jd1NiSHBWOW04cFdPOW1kOUhrNWJZRm16eUd4ejdz?=
 =?utf-8?B?dmhGbFEvTW93aFRKQlQzdEFXZnRpdm9JOWptNklSdk0wUDlPN0lEcUltSEdD?=
 =?utf-8?B?NEJKYnlua3FLRHNNWUovNjlZQjdVcGJhaThIcC9xUDJQMVZ0MGo2K0VMV290?=
 =?utf-8?B?MlVucWd4aEZBMXEvZFB4UmpGVGtIWW1lNEU1S3VTRWIzZ2lNU3V3R09SZkxL?=
 =?utf-8?Q?i17/ouIB/lmsd2LWZOSPB9DAF/xxqs3MFBj5M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzNSUEpydURMaml1eWZOQTMyL2VxWmdjWEV5T1Q5ZWVOcmVSTm9VOTVzUDhi?=
 =?utf-8?B?djBJMHE2V1B2YnZJZERYRUNxelptT3U0SmM1M2p3UTlpZzBmRGZRcXlPQVIz?=
 =?utf-8?B?WWZKbmlFbExiSHVmSlVySE1IVTllaDNJV2l0TlpkckxMeDkyMXRKT3BDbWoz?=
 =?utf-8?B?dFZyTk1YY2NDMS9seUNSeHMvemxqYXIvT25jVGdFNkVZRzFNS1diTWxhZmhs?=
 =?utf-8?B?NlY0RkRxWWIwNmNKRGxhamM3QzlpbU53TmV3SXV2QUpJRnM4dFZJY2lRSjF4?=
 =?utf-8?B?SDBaM2h5YUt2RXVyMFFDZDd4Zzh5am9CQjlBNzVsZWYxdG5ITzBKcU45N2R0?=
 =?utf-8?B?U25DV1ljdGRXblVoak1pNVNkUGlZWllicnkzaEdWaklwa0o3QzY0L0YxQnZT?=
 =?utf-8?B?MVpqWGZEQmFpT0NGcmJMWWJudjRSNGNxNURPTWQ2VndsNXJCMHovbzZWc05p?=
 =?utf-8?B?aUtvSjJIRStXdDFheTgzQjVEOStlMmd1MkZpVEZKOHYzWUVEL0NubFZ1ZlFq?=
 =?utf-8?B?MDRydzdwZkRxaHhmRzlpTSsxSmpZK0E1QzBIV3RvREw3bmp3T3kyRXVaeVZ0?=
 =?utf-8?B?WUd6WkpaNUZFTzdDM2RZdTk3bTYzMjlLb2dQMUhUalFjZUN5bHJPQnVuU3RT?=
 =?utf-8?B?QW9MVGhtdGJKdXZFcnRYMGQrTjJtTnorWHJhVERheFJ4WVdGL3Q4V2JGTEVl?=
 =?utf-8?B?TmRDWGFhR0JFaTdzbllES1hidFVibnVGNk5DUDVCeU5TeFRWK0Nrc2NTZUNI?=
 =?utf-8?B?Z3hDSTZCVWF1QXNTZlJYbGIvSWFWZDRXRVVHbWIwYzRRSXM5OThuS1g0NTUr?=
 =?utf-8?B?dWY1RmhmRVhSSWdLV2FiV2l1WnlvY1A4UHZzOTRmeCtvdHFzVGM0TG9vVFVG?=
 =?utf-8?B?c095Qk05V3FFUzkxbTBIbnlhU0dQTjVJMklZblJEZmZVc3QxTGFzVHlDUTVR?=
 =?utf-8?B?QS9sZGRKRXB1ZnNsVm9WMk02WVF1SFl6YmY4VkVjRDNXKzY1T3YzNGsxMTJr?=
 =?utf-8?B?aWtrdms1RU10WnRtVzdXZHNUTWpOckp6Y1dJTFZaZkUrdXByd20zbSttRzZ3?=
 =?utf-8?B?b2FRZnhBeEl2Sno3SW1mcnRVMVF3elViZldrNkRrdk9sRnFBYzVqWm5WMkl0?=
 =?utf-8?B?b1hkWlY5NUw3ZkI5MG5oTkdGNXlnVmxNdVo2RDhlYUN4bDRmWklYaS96NWgv?=
 =?utf-8?B?RmQzS2E3cmlYaHBTbTEyb0RENVFrUHgvVzRJS1JKTG84bEtkMjBERW5UYkpk?=
 =?utf-8?B?N0wreWN0dGx1SnJZa1pLMS96QlgyNVRsWG1qTVJRQWo5ZkhBNTh3Rjl6aTJW?=
 =?utf-8?B?Y21obGpYNEpzdjBvbTZHK0oreUdkb3M5Y2VQNUI5TzBTTCtpclFBWWx2OVk5?=
 =?utf-8?B?cUJJTHd2dGwwODQvbEpwL0Z6N1dHV01razdRNGswbGdOQkZTa2k0MXFNekc3?=
 =?utf-8?B?QXRiYkJlM3RWTVczZndwMjIyYmhFRkFOc0JoSWxwNVk2ZVZNMDZQUUdsOTdO?=
 =?utf-8?B?RTJmVXI4M2ZodnNzRkJHK2kxcCsybm5CbG1Ga1BKK3BVM056MW0zTkNhek0w?=
 =?utf-8?B?QVMrN1dtMmdkUTZ1MW4xQkZBWm1QTGdETDlrSTlNZDVNY2pNL05lMFRSZGFV?=
 =?utf-8?B?T2l6YjlLS055NktqVVU1bjEvWHZlbUlGRUt5eGFqS0JvWFY1ZGV0MjVYdGN3?=
 =?utf-8?B?Qm80dm9sLzNHNWxaMUxkRmhTQ3V4NUpUQ0l6RldvTy9JY2xVdHJwalpWbnBt?=
 =?utf-8?B?SmtTSlRtQ0d1OWdaNTNUWE5PTFZpdlQ1blhPREhseEZCNFdrSHJwUjBqcm5B?=
 =?utf-8?B?YUFETzRxR083MU1oUWNyZzV5dm9mWGx2VnpVOUdkZGEwTCtlR0FGaXh4MDli?=
 =?utf-8?B?R0d5OFVkMVZJS1VxWnYvMmR6SWpTZHJDS0Nxa0ovU0xja2NMdGF2ZHFjWDhi?=
 =?utf-8?B?WFhDUkJ5c29CRnVHVlVEY0hHYzk0blNSQWVnSU1JRFNJZ3VWRlg4OGVTd2cv?=
 =?utf-8?B?bzFycWtQRXozM0xmYnh0Qk9IQnpsalhDdUpJaWMrbmdWb05GNHhRbCtSOGV1?=
 =?utf-8?B?YmZzMDlnalp3RWlDVU1tcld6U0NjMGFpQmxkQ0JUeVBpOExLSnVydXBpdk9v?=
 =?utf-8?B?RStlUTZEWjhZMmN2ZjkwSldPNkp2QUZtR3QzWEhIanRwL0UxVGltMjdGTW9a?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a521edf-8ede-420b-2b79-08dda7761fd0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:53:15.1388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrBIvz2No8ejFX2qRtTpQqQG9eetxKfjjaEoMmbwgYi9/YZN2pC20+uZOOcXnFNtDuoXtouEuM4Hob2gOx/csZosp4wX9Wz39qRuyDFzy88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5270


On 5/13/25 4:48 PM, Matthew Gerlach wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>
> Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
> driver for the Agilex5 is very similar to the Agilex platform, so
> it is reusing most of the Agilex clock driver code.


Any feedback on this revision?

Thanks,

Matthew Gerlach

>
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> Changes in v5:
> - Remove incorrect usage of .index and continue with the old way
>    of using string names.
> - Add lore links to revision history.
> - Link to v4: https://lore.kernel.org/lkml/20250417145238.31657-1-matthew.gerlach@altera.com/T/#u
>
> Changes in v4:
> - Add .index to clk_parent_data.
> - Link to v3: https://lore.kernel.org/linux-clk/20231003120402.4186270-1-niravkumar.l.rabara@intel.com/
>
> Changes in v3:
> - Used different name for stratix10_clock_data pointer.
> - Used a single function call, devm_platform_ioremap_resource().
> - Used only .name in clk_parent_data.
> - Link to v2: https://lore.kernel.org/linux-clk/20230801010234.792557-1-niravkumar.l.rabara@intel.com/
>
> Stephen suggested to use .fw_name or .index, But since the changes are on top
> of existing driver and current driver code is not using clk_hw and removing
> .name and using .fw_name and/or .index resulting in parent clock_rate &
> recalc_rate to 0.
>
> In order to use .index, I would need to refactor the common code that is shared
> by a few Intel SoCFPGA platforms (S10, Agilex and N5x). So, if using .name for
> this patch is acceptable then I will upgrade clk-agilex.c in future submission.
>
> Changes in v2:
> - Instead of creating separate clock manager driver, re-use agilex clock
>    manager driver and modified it for agilex5 changes to avoid code
>    duplicate.
> - Link to v1: https://lore.kernel.org/linux-clk/20230618132235.728641-4-niravkumar.l.rabara@intel.com/
> ---
>   drivers/clk/socfpga/clk-agilex.c | 413 ++++++++++++++++++++++++++++++-
>   1 file changed, 412 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
> index 8dd94f64756b..43c1e4e26cf0 100644
> --- a/drivers/clk/socfpga/clk-agilex.c
> +++ b/drivers/clk/socfpga/clk-agilex.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (C) 2019, Intel Corporation
> + * Copyright (C) 2019-2024, Intel Corporation
> + * Copyright (C) 2025, Altera Corporation
>    */
>   #include <linux/slab.h>
>   #include <linux/clk-provider.h>
> @@ -8,6 +9,7 @@
>   #include <linux/platform_device.h>
>   
>   #include <dt-bindings/clock/agilex-clock.h>
> +#include <dt-bindings/clock/intel,agilex5-clkmgr.h>
>   
>   #include "stratix10-clk.h"
>   
> @@ -334,6 +336,375 @@ static const struct stratix10_gate_clock agilex_gate_clks[] = {
>   	  10, 0, 0, 0, 0, 0, 4},
>   };
>   
> +static const struct clk_parent_data agilex5_pll_mux[] = {
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_boot_mux[] = {
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_core0_free_mux[] = {
> +	{ .name = "main_pll_c1", },
> +	{ .name = "peri_pll_c0", },
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_core1_free_mux[] = {
> +	{ .name = "main_pll_c1", },
> +	{ .name = "peri_pll_c0", },
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_core2_free_mux[] = {
> +	{ .name = "main_pll_c0", },
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_core3_free_mux[] = {
> +	{ .name = "main_pll_c0", },
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_dsu_free_mux[] = {
> +	{ .name = "main_pll_c2", },
> +	{ .name = "peri_pll_c0", },
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_noc_free_mux[] = {
> +	{ .name = "main_pll_c3", },
> +	{ .name = "peri_pll_c1", },
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_emaca_free_mux[] = {
> +	{ .name = "main_pll_c1", },
> +	{ .name = "peri_pll_c3", },
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_emacb_free_mux[] = {
> +	{ .name = "main_pll_c1", },
> +	{ .name = "peri_pll_c3", },
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_emac_ptp_free_mux[] = {
> +	{ .name = "main_pll_c3", },
> +	{ .name = "peri_pll_c3", },
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_gpio_db_free_mux[] = {
> +	{ .name = "main_pll_c3", },
> +	{ .name = "peri_pll_c1", },
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_psi_ref_free_mux[] = {
> +	{ .name = "main_pll_c1", },
> +	{ .name = "peri_pll_c3", },
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_usb31_free_mux[] = {
> +	{ .name = "main_pll_c3", },
> +	{ .name = "peri_pll_c2", },
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_s2f_usr0_free_mux[] = {
> +	{ .name = "main_pll_c1", },
> +	{ .name = "peri_pll_c3", },
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_s2f_usr1_free_mux[] = {
> +	{ .name = "main_pll_c1", },
> +	{ .name = "peri_pll_c3", },
> +	{ .name = "osc1", },
> +	{ .name = "cb-intosc-hs-div2-clk", },
> +	{ .name = "f2s-free-clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_core0_mux[] = {
> +	{ .name = "core0_free_clk", },
> +	{ .name = "boot_clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_core1_mux[] = {
> +	{ .name = "core1_free_clk", .index = AGILEX5_CORE1_FREE_CLK },
> +	{ .name = "boot_clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_core2_mux[] = {
> +	{ .name = "core2_free_clk", },
> +	{ .name = "boot_clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_core3_mux[] = {
> +	{ .name = "core3_free_clk", },
> +	{ .name = "boot_clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_dsu_mux[] = {
> +	{ .name = "dsu_free_clk", },
> +	{ .name = "boot_clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_emac_mux[] = {
> +	{ .name = "emaca_free_clk", },
> +	{ .name = "emacb_free_clk", },
> +	{ .name = "boot_clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_noc_mux[] = {
> +	{ .name = "noc_free_clk", },
> +	{ .name = "boot_clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_s2f_user0_mux[] = {
> +	{ .name = "s2f_user0_free_clk", },
> +	{ .name = "boot_clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_s2f_user1_mux[] = {
> +	{ .name = "s2f_user1_free_clk", },
> +	{ .name = "boot_clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_psi_mux[] = {
> +	{ .name = "psi_ref_free_clk", },
> +	{ .name = "boot_clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_gpio_db_mux[] = {
> +	{ .name = "gpio_db_free_clk", },
> +	{ .name = "boot_clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_emac_ptp_mux[] = {
> +	{ .name = "emac_ptp_free_clk", },
> +	{ .name = "boot_clk", },
> +};
> +
> +static const struct clk_parent_data agilex5_usb31_mux[] = {
> +	{ .name = "usb31_free_clk", },
> +	{ .name = "boot_clk", },
> +};
> +
> +/*
> + * clocks in AO (always on) controller
> + */
> +static const struct stratix10_pll_clock agilex5_pll_clks[] = {
> +	{ AGILEX5_BOOT_CLK, "boot_clk", agilex5_boot_mux, ARRAY_SIZE(agilex5_boot_mux), 0,
> +	  0x0 },
> +	{ AGILEX5_MAIN_PLL_CLK, "main_pll", agilex5_pll_mux, ARRAY_SIZE(agilex5_pll_mux), 0,
> +	  0x48 },
> +	{ AGILEX5_PERIPH_PLL_CLK, "periph_pll", agilex5_pll_mux, ARRAY_SIZE(agilex5_pll_mux), 0,
> +	  0x9C },
> +};
> +
> +static const struct stratix10_perip_c_clock agilex5_main_perip_c_clks[] = {
> +	{ AGILEX5_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0,
> +	  0x5C },
> +	{ AGILEX5_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0,
> +	  0x60 },
> +	{ AGILEX5_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0,
> +	  0x64 },
> +	{ AGILEX5_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0,
> +	  0x68 },
> +	{ AGILEX5_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1, 0,
> +	  0xB0 },
> +	{ AGILEX5_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0,
> +	  0xB4 },
> +	{ AGILEX5_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1, 0,
> +	  0xB8 },
> +	{ AGILEX5_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1, 0,
> +	  0xBC },
> +};
> +
> +/* Non-SW clock-gated enabled clocks */
> +static const struct stratix10_perip_cnt_clock agilex5_main_perip_cnt_clks[] = {
> +	{ AGILEX5_CORE0_FREE_CLK, "core0_free_clk", NULL, agilex5_core0_free_mux,
> +	ARRAY_SIZE(agilex5_core0_free_mux), 0, 0x0104, 0, 0, 0},
> +	{ AGILEX5_CORE1_FREE_CLK, "core1_free_clk", NULL, agilex5_core1_free_mux,
> +	ARRAY_SIZE(agilex5_core1_free_mux), 0, 0x0104, 0, 0, 0},
> +	{ AGILEX5_CORE2_FREE_CLK, "core2_free_clk", NULL, agilex5_core2_free_mux,
> +	ARRAY_SIZE(agilex5_core2_free_mux), 0, 0x010C, 0, 0, 0},
> +	{ AGILEX5_CORE3_FREE_CLK, "core3_free_clk", NULL, agilex5_core3_free_mux,
> +	ARRAY_SIZE(agilex5_core3_free_mux), 0, 0x0110, 0, 0, 0},
> +	{ AGILEX5_DSU_FREE_CLK, "dsu_free_clk", NULL, agilex5_dsu_free_mux,
> +	ARRAY_SIZE(agilex5_dsu_free_mux), 0, 0x0100, 0, 0, 0},
> +	{ AGILEX5_NOC_FREE_CLK, "noc_free_clk", NULL, agilex5_noc_free_mux,
> +	  ARRAY_SIZE(agilex5_noc_free_mux), 0, 0x40, 0, 0, 0 },
> +	{ AGILEX5_EMAC_A_FREE_CLK, "emaca_free_clk", NULL, agilex5_emaca_free_mux,
> +	  ARRAY_SIZE(agilex5_emaca_free_mux), 0, 0xD4, 0, 0x88, 0 },
> +	{ AGILEX5_EMAC_B_FREE_CLK, "emacb_free_clk", NULL, agilex5_emacb_free_mux,
> +	  ARRAY_SIZE(agilex5_emacb_free_mux), 0, 0xD8, 0, 0x88, 1 },
> +	{ AGILEX5_EMAC_PTP_FREE_CLK, "emac_ptp_free_clk", NULL,
> +	  agilex5_emac_ptp_free_mux, ARRAY_SIZE(agilex5_emac_ptp_free_mux), 0, 0xDC, 0, 0x88,
> +	  2 },
> +	{ AGILEX5_GPIO_DB_FREE_CLK, "gpio_db_free_clk", NULL, agilex5_gpio_db_free_mux,
> +	  ARRAY_SIZE(agilex5_gpio_db_free_mux), 0, 0xE0, 0, 0x88, 3 },
> +	{ AGILEX5_S2F_USER0_FREE_CLK, "s2f_user0_free_clk", NULL,
> +	  agilex5_s2f_usr0_free_mux, ARRAY_SIZE(agilex5_s2f_usr0_free_mux), 0, 0xE8, 0, 0x30,
> +	  2 },
> +	{ AGILEX5_S2F_USER1_FREE_CLK, "s2f_user1_free_clk", NULL,
> +	  agilex5_s2f_usr1_free_mux, ARRAY_SIZE(agilex5_s2f_usr1_free_mux), 0, 0xEC, 0, 0x88,
> +	  5 },
> +	{ AGILEX5_PSI_REF_FREE_CLK, "psi_ref_free_clk", NULL, agilex5_psi_ref_free_mux,
> +	  ARRAY_SIZE(agilex5_psi_ref_free_mux), 0, 0xF0, 0, 0x88, 6 },
> +	{ AGILEX5_USB31_FREE_CLK, "usb31_free_clk", NULL, agilex5_usb31_free_mux,
> +	  ARRAY_SIZE(agilex5_usb31_free_mux), 0, 0xF8, 0, 0x88, 7},
> +};
> +
> +/* SW Clock gate enabled clocks */
> +static const struct stratix10_gate_clock agilex5_gate_clks[] = {
> +	/* Main PLL0 Begin */
> +	/* MPU clocks */
> +	{ AGILEX5_CORE0_CLK, "core0_clk", NULL, agilex5_core0_mux,
> +	  ARRAY_SIZE(agilex5_core0_mux), 0, 0x24, 8, 0, 0, 0, 0x30, 5, 0 },
> +	{ AGILEX5_CORE1_CLK, "core1_clk", NULL, agilex5_core1_mux,
> +	  ARRAY_SIZE(agilex5_core1_mux), 0, 0x24, 9, 0, 0, 0, 0x30, 5, 0 },
> +	{ AGILEX5_CORE2_CLK, "core2_clk", NULL, agilex5_core2_mux,
> +	  ARRAY_SIZE(agilex5_core2_mux), 0, 0x24, 10, 0, 0, 0, 0x30, 6, 0 },
> +	{ AGILEX5_CORE3_CLK, "core3_clk", NULL, agilex5_core3_mux,
> +	  ARRAY_SIZE(agilex5_core3_mux), 0, 0x24, 11, 0, 0, 0, 0x30, 7, 0 },
> +	{ AGILEX5_MPU_CLK, "dsu_clk", NULL, agilex5_dsu_mux, ARRAY_SIZE(agilex5_dsu_mux), 0, 0,
> +	  0, 0, 0, 0, 0x34, 4, 0 },
> +	{ AGILEX5_MPU_PERIPH_CLK, "mpu_periph_clk", NULL, agilex5_dsu_mux,
> +	  ARRAY_SIZE(agilex5_dsu_mux), 0, 0, 0, 0x44, 20, 2, 0x34, 4, 0 },
> +	{ AGILEX5_MPU_CCU_CLK, "mpu_ccu_clk", NULL, agilex5_dsu_mux,
> +	  ARRAY_SIZE(agilex5_dsu_mux), 0, 0, 0, 0x44, 18, 2, 0x34, 4, 0 },
> +	{ AGILEX5_L4_MAIN_CLK, "l4_main_clk", NULL, agilex5_noc_mux,
> +	  ARRAY_SIZE(agilex5_noc_mux), 0, 0x24, 1, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_L4_MP_CLK, "l4_mp_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux), 0,
> +	  0x24, 2, 0x44, 4, 2, 0x30, 1, 0 },
> +	{ AGILEX5_L4_SYS_FREE_CLK, "l4_sys_free_clk", NULL, agilex5_noc_mux,
> +	  ARRAY_SIZE(agilex5_noc_mux), 0, 0, 0, 0x44, 2, 2, 0x30, 1, 0 },
> +	{ AGILEX5_L4_SP_CLK, "l4_sp_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux),
> +	  CLK_IS_CRITICAL, 0x24, 3, 0x44, 6, 2, 0x30, 1, 0 },
> +
> +	/* Core sight clocks*/
> +	{ AGILEX5_CS_AT_CLK, "cs_at_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux), 0,
> +	  0x24, 4, 0x44, 24, 2, 0x30, 1, 0 },
> +	{ AGILEX5_CS_TRACE_CLK, "cs_trace_clk", NULL, agilex5_noc_mux,
> +	  ARRAY_SIZE(agilex5_noc_mux), 0, 0x24, 4, 0x44, 26, 2, 0x30, 1, 0 },
> +	{ AGILEX5_CS_PDBG_CLK, "cs_pdbg_clk", "cs_at_clk", NULL, 1, 0, 0x24, 4,
> +	  0x44, 28, 1, 0, 0, 0 },
> +	/* Main PLL0 End */
> +
> +	/* Main Peripheral PLL1 Begin */
> +	{ AGILEX5_EMAC0_CLK, "emac0_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
> +	  0, 0x7C, 0, 0, 0, 0, 0x94, 26, 0 },
> +	{ AGILEX5_EMAC1_CLK, "emac1_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
> +	  0, 0x7C, 1, 0, 0, 0, 0x94, 27, 0 },
> +	{ AGILEX5_EMAC2_CLK, "emac2_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
> +	  0, 0x7C, 2, 0, 0, 0, 0x94, 28, 0 },
> +	{ AGILEX5_EMAC_PTP_CLK, "emac_ptp_clk", NULL, agilex5_emac_ptp_mux,
> +	  ARRAY_SIZE(agilex5_emac_ptp_mux), 0, 0x7C, 3, 0, 0, 0, 0x88, 2, 0 },
> +	{ AGILEX5_GPIO_DB_CLK, "gpio_db_clk", NULL, agilex5_gpio_db_mux,
> +	  ARRAY_SIZE(agilex5_gpio_db_mux), 0, 0x7C, 4, 0x98, 0, 16, 0x88, 3, 1 },
> +	  /* Main Peripheral PLL1 End */
> +
> +	  /* Peripheral clocks  */
> +	{ AGILEX5_S2F_USER0_CLK, "s2f_user0_clk", NULL, agilex5_s2f_user0_mux,
> +	  ARRAY_SIZE(agilex5_s2f_user0_mux), 0, 0x24, 6, 0, 0, 0, 0x30, 2, 0 },
> +	{ AGILEX5_S2F_USER1_CLK, "s2f_user1_clk", NULL, agilex5_s2f_user1_mux,
> +	  ARRAY_SIZE(agilex5_s2f_user1_mux), 0, 0x7C, 6, 0, 0, 0, 0x88, 5, 0 },
> +	{ AGILEX5_PSI_REF_CLK, "psi_ref_clk", NULL, agilex5_psi_mux,
> +	  ARRAY_SIZE(agilex5_psi_mux), 0, 0x7C, 7, 0, 0, 0, 0x88, 6, 0 },
> +	{ AGILEX5_USB31_SUSPEND_CLK, "usb31_suspend_clk", NULL, agilex5_usb31_mux,
> +	  ARRAY_SIZE(agilex5_usb31_mux), 0, 0x7C, 25, 0, 0, 0, 0x88, 7, 0 },
> +	{ AGILEX5_USB31_BUS_CLK_EARLY, "usb31_bus_clk_early", "l4_main_clk",
> +	  NULL, 1, 0, 0x7C, 25, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_USB2OTG_HCLK, "usb2otg_hclk", "l4_mp_clk", NULL, 1, 0, 0x7C,
> +	  8, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SPIM_0_CLK, "spim_0_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 9,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SPIM_1_CLK, "spim_1_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 11,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SPIS_0_CLK, "spis_0_clk", "l4_sp_clk", NULL, 1, 0, 0x7C, 12,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SPIS_1_CLK, "spis_1_clk", "l4_sp_clk", NULL, 1, 0, 0x7C, 13,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_DMA_CORE_CLK, "dma_core_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
> +	  14, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_DMA_HS_CLK, "dma_hs_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 14,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_I3C_0_CORE_CLK, "i3c_0_core_clk", "l4_mp_clk", NULL, 1, 0,
> +	  0x7C, 18, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_I3C_1_CORE_CLK, "i3c_1_core_clk", "l4_mp_clk", NULL, 1, 0,
> +	  0x7C, 19, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_I2C_0_PCLK, "i2c_0_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 15,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_I2C_1_PCLK, "i2c_1_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 16,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_I2C_EMAC0_PCLK, "i2c_emac0_pclk", "l4_sp_clk", NULL, 1, 0,
> +	  0x7C, 17, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_I2C_EMAC1_PCLK, "i2c_emac1_pclk", "l4_sp_clk", NULL, 1, 0,
> +	  0x7C, 22, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_I2C_EMAC2_PCLK, "i2c_emac2_pclk", "l4_sp_clk", NULL, 1, 0,
> +	  0x7C, 27, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_UART_0_PCLK, "uart_0_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 20,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_UART_1_PCLK, "uart_1_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 21,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SPTIMER_0_PCLK, "sptimer_0_pclk", "l4_sp_clk", NULL, 1, 0,
> +	  0x7C, 23, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SPTIMER_1_PCLK, "sptimer_1_pclk", "l4_sp_clk", NULL, 1, 0,
> +	  0x7C, 24, 0, 0, 0, 0, 0, 0 },
> +
> +	/*NAND, SD/MMC and SoftPHY overall clocking*/
> +	{ AGILEX5_DFI_CLK, "dfi_clk", "l4_mp_clk", NULL, 1, 0, 0, 0, 0x44, 16,
> +	  2, 0, 0, 0 },
> +	{ AGILEX5_NAND_NF_CLK, "nand_nf_clk", "dfi_clk", NULL, 1, 0, 0x7C, 10,
> +	  0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_NAND_BCH_CLK, "nand_bch_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
> +	  10, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SDMMC_SDPHY_REG_CLK, "sdmmc_sdphy_reg_clk", "l4_mp_clk", NULL,
> +	  1, 0, 0x7C, 5, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SDMCLK, "sdmclk", "dfi_clk", NULL, 1, 0, 0x7C, 5, 0, 0, 0, 0,
> +	  0, 0 },
> +	{ AGILEX5_SOFTPHY_REG_PCLK, "softphy_reg_pclk", "l4_mp_clk", NULL, 1, 0,
> +	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
> +	{ AGILEX5_SOFTPHY_PHY_CLK, "softphy_phy_clk", "l4_mp_clk", NULL, 1, 0,
> +	  0x7C, 26, 0x44, 16, 2, 0, 0, 0 },
> +	{ AGILEX5_SOFTPHY_CTRL_CLK, "softphy_ctrl_clk", "dfi_clk", NULL, 1, 0,
> +	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
> +};
> +
>   static int n5x_clk_register_c_perip(const struct n5x_perip_c_clock *clks,
>   				       int nums, struct stratix10_clock_data *data)
>   {
> @@ -542,11 +913,51 @@ static int agilex_clkmgr_probe(struct platform_device *pdev)
>   	return	probe_func(pdev);
>   }
>   
> +static int agilex5_clkmgr_init(struct platform_device *pdev)
> +{
> +	struct stratix10_clock_data *stratix_data;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *base;
> +	int i, num_clks;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	num_clks = AGILEX5_NUM_CLKS;
> +
> +	stratix_data = devm_kzalloc(dev,
> +				    struct_size(stratix_data, clk_data.hws, num_clks), GFP_KERNEL);
> +	if (!stratix_data)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_clks; i++)
> +		stratix_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
> +
> +	stratix_data->base = base;
> +	stratix_data->clk_data.num = num_clks;
> +
> +	agilex_clk_register_pll(agilex5_pll_clks, ARRAY_SIZE(agilex5_pll_clks),
> +				stratix_data);
> +
> +	agilex_clk_register_c_perip(agilex5_main_perip_c_clks,
> +				    ARRAY_SIZE(agilex5_main_perip_c_clks), stratix_data);
> +
> +	agilex_clk_register_cnt_perip(agilex5_main_perip_cnt_clks,
> +				      ARRAY_SIZE(agilex5_main_perip_cnt_clks), stratix_data);
> +
> +	agilex_clk_register_gate(agilex5_gate_clks,
> +				 ARRAY_SIZE(agilex5_gate_clks), stratix_data);
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, &stratix_data->clk_data);
> +}
> +
>   static const struct of_device_id agilex_clkmgr_match_table[] = {
>   	{ .compatible = "intel,agilex-clkmgr",
>   	  .data = agilex_clkmgr_init },
>   	{ .compatible = "intel,easic-n5x-clkmgr",
>   	  .data = n5x_clkmgr_init },
> +	{ .compatible = "intel,agilex5-clkmgr",
> +	  .data = agilex5_clkmgr_init },
>   	{ }
>   };
>   

