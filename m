Return-Path: <netdev+bounces-203903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F64AF7F58
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C261B1C26325
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974342F1987;
	Thu,  3 Jul 2025 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="IISq3R4/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD82328C03C;
	Thu,  3 Jul 2025 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564689; cv=fail; b=IboTZOJLt5qs3uRs450dmPWwZfGGU6tyV9h/ru7RE5zdYVGK49G6yQGea9JL100fRSqiOElfccMlVwzWAHLk/2Zoq5XiXbulXnshfEzbAK5DG9ktpvU+flGEpN7OsmEF7oFKxm4iOM3I4Nvl41wz/Eg/CDNj5p5d+Q5AaXz2Aug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564689; c=relaxed/simple;
	bh=6gMtmFGM11cXipXUljpNMDE35n+SAj5Z1CYSESUprL4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tZB3ZdOwiGHSBZoKf99hPlnf3QBBIIEztyt2K/Xyj853c8z25/yUpyMIfaM4DeTEusbYmLTfj5fyAtbISIf/YnLX3KwTjGW/cuFc2j6NRFBqsaajtZsVaSdgK/YBTrEo0pmpRn3NcMXVLhN6VAmzFAuqpL7HPsUZlGPG/5/4FxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=IISq3R4/; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGfelLkSWUZIfg391OeOIRwEULkoyyqIV5eXfaR9fJrZ3DMkiMpmioND04CjsmDpD7L/9pbLstRBmBBq7nzOYfTA2RDzRtGsZ6YdYbu8EmzhMgDeh/5g1L18B4z8KSIhmjudAojbe1Z7Mgtj1faCfvpetuCehN7TvO+3PsJuZLFblZlLIVruWdXJBSm7hJajsZOjOri4u4VJvIJx+jpDPmdBRdUw/g0Cc2ngPAP25hFncWRevnjjdeUj2iKa+4+mNg0KGL22LeDImV/3EoGkFJnrF33eiDugHcLM044A2Ks2hxkJ6N0HMDmNDrTeq/15NLcRy3M3sBVzzwCCTIpA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdjwKIVdqtg3YJ6xvUFoEr4kmeXyLtW6l/gIpMJadZo=;
 b=WCmVYwUKegufVRnX55lAh2q+7jP0bhHWpw0oHWyVqpaZ4IhJ0gqpw8oZYv3C8TDPaD6iTYE989cc0YdUh2CYPT7OH12eSiA3VFYUiqGqBpN0vXbHVABjIiexBH/Ef5+KFDss17jW+NsdgEHb7kbFHPlN5WiNPxG7SZ8GS2I5wDc5KK9y2ONS6ULl00eO8sZMHWKUQbaZBXVuyCjxTTj+blyU19pJWyir6dXw6fva+Mg7xZT2S/LKue64t6KMkOnF7AQzWe+hHZmTxM+ErkWEo8dJELNoPpaWWZgEU2QwypniDyKAQGaqerL7NPMMqgTYevY9P3Coqm4jqslqexN7/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdjwKIVdqtg3YJ6xvUFoEr4kmeXyLtW6l/gIpMJadZo=;
 b=IISq3R4/rUHUpAhwW8YjQzkZJe8Grb8qeqoK7+AF2/pCPJ77UUHDoI77PQa+NskYGKNPwcIZqZ1e7mMYY1J3owedmfb/BGjjUqJoJaVOFgJKfeaiiQl4oSxfFUBI85tltUtyaL/cimpBJadW1nnGs7liji38LZX+VkPj29+bWaQtMTIuQpCgGP1kOp1jXFu8Mg+kNGljFvd1eGOQ7O5tiSNdkXd8UVuOgIpQgKpCqJnYyhfTA0KAseYjmuvQQXQDo5dAOG5d9iWuj9iPXZ3O9mZKiMDFHnYE8KmtbDFvdohOoNx4D3yOcVhQm8y56MSyRX71iBZ5EY6Bx8gjTZEKow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by CH2PR03MB8087.namprd03.prod.outlook.com (2603:10b6:610:27e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 3 Jul
 2025 17:44:45 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 17:44:44 +0000
Message-ID: <f599a0c5-8bc6-4081-8095-1e004bcd4394@altera.com>
Date: Thu, 3 Jul 2025 10:44:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
To: Rob Herring <robh@kernel.org>
Cc: dinguyen@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Mun Yew Tham <mun.yew.tham@altera.com>
References: <20250630213748.71919-1-matthew.gerlach@altera.com>
 <CAL_JsqLrLJ6wiqBk31NhronsUqX4_5FN-Lb26r-3SceDD7kkAA@mail.gmail.com>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <CAL_JsqLrLJ6wiqBk31NhronsUqX4_5FN-Lb26r-3SceDD7kkAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49)
 To BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|CH2PR03MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d7bc00-335e-4cce-7a26-08ddba594baf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3hZdDA5SGRnRmFjSHdEL0QzdTJRYk13UElNWEptUlVOK1BhbDhsTXVYUzFU?=
 =?utf-8?B?clN6Z2V3aTNWNjRZcHd0eXBQcHgrekhoM2JrQlNneU5xK0lRZEtUU0M4OE5h?=
 =?utf-8?B?RjZNTTRFaVhLNDFGMVZKTFQ2Z1NQNzIzOEFtcnMxNHY1TVpPeE5Ba3JYZ3F4?=
 =?utf-8?B?Mmg5ZnlIVmt3OHpESnkwUWtmakMvbVNDcThjZ0FmMHlqeVR3SXRTcjFqdDNh?=
 =?utf-8?B?Ym9DWjBxS05raHBMd05YOE9URzdocW5KZ1ZZeExjRTBkWmFDRDVXV0tGdDU4?=
 =?utf-8?B?U01XT3Z5MzlWTTRkNlBLZDlvcUJMWnpocHo3SnoyN0dzR01Ec0pxdkdsTGpX?=
 =?utf-8?B?Z3NzdUZWblN6encvZWhjRXJRcGpuY1FLVmxRaVFtTjM4VFpiM1RGQUFuWjlF?=
 =?utf-8?B?aXRSa29EUXBOdUJLM1pIWTIvQWVIWXZQaFhCYzRVVDBmY2l1ZzRjVlphT1Y2?=
 =?utf-8?B?WGhSMVZuVld3YlorQlJPcHNWVXAwRHdDL1NnOEt0ZXgrelM2NUhBd0poclNF?=
 =?utf-8?B?WkNXcGErOEJuL21Sazh1MDhSR3BrbXJnS1dnems4Vyt4Qm5zRUk0Z0pTOUpx?=
 =?utf-8?B?WFo5ZUdvL1hqRWZ5eGVkcTN4dW5rQ2VIYXZKTWtVMDdsRlJUOG0yV3dwa0py?=
 =?utf-8?B?cE0xTDZUTHROWmxka0NOL2IvRWIwS3dvQ1k4MTNXWGkwTlUxK3hGTzV4Vktl?=
 =?utf-8?B?alA0Zk5IeTdLbUgwZFFkN0VjRzFJYnpLU3pXZ2Y3Z1kwS1ZjOUVldTV2Q25l?=
 =?utf-8?B?RjZWZks5S1JkVlNFT3MyckRRaVJVOVdycDZkaUlsVWlXRGo3dG9wOUVNcVk2?=
 =?utf-8?B?MHhCaVh2VWtETklaUnhkYi94ODY1WHlMM2ttY24ra2xYQkh0ZkxkbCtadjB2?=
 =?utf-8?B?OHA2amdEajdDVmRDclQ2MlZjdnhseVdEb3NTUW5wZEJtV094SThjRmFMR3dv?=
 =?utf-8?B?ZzAvRnRpTFBwMzhyZUFSVmVKMTJpSDQ4cW5Ia0g4Vm9EVnhWK3E3cnQ3bm9O?=
 =?utf-8?B?Y3BucXhkeWFZUVZ4MG5iSE1EbWRTOHRkTGlkSCs1TVBTNVpkaURxaEZiczNa?=
 =?utf-8?B?UTZTOHh4YmVBTGNmRXloR20rS3d0R1VpVmQ2dlhCMURwWitGc2hHTnlpMEJT?=
 =?utf-8?B?M2U1YXFWRUxwUGZhSDJ3SVB1SmNyTGl0WCtwY0E2bnhOQ0t0aDUvbFpsc2tJ?=
 =?utf-8?B?aUlXSXFWUENYRnhaMndaeWtiaHFyQTc4ZnV1OXpKdjlpMjhXT2tONU5Idkda?=
 =?utf-8?B?TXdLcDRkSUR3WEJPWDBmTE4yT2ErNnNUMFZxZHBqTThMc3F3d3ptRTNwanVi?=
 =?utf-8?B?Q2U4SmtyRXlMK2NyN0FHeHJTeE9pZnlxdEJNUndydUxZNjFtekZkQ1ZzeUlt?=
 =?utf-8?B?Nk5abzF3UldOMkgzRHFuMlMrVGhKME4rVEFnSnFHdG1qeFVQT1ZLTndJMld5?=
 =?utf-8?B?V0pXUjdubm53cWF2eFo2aFg1UVJDS2doOXNJK0RlVmdVMVFYc2dGMkxXbEtX?=
 =?utf-8?B?V2N3Qk9Wcng4UVNrajB4Slc1S1d5OTUyQkxlelNuU1hZaDNzWVdsVUdwTVlI?=
 =?utf-8?B?OUQ5NDAvVUhST0NLT0ZiUEFPT3MwS2pTRGxLQWtYTU9FSkJGR2t1ejVxWmll?=
 =?utf-8?B?YW1VSk0zc3JZeGI3TzdWQ2hKMjdEdnlsVnhBSzFHZVpyUFhBTHg3aEtsU2ZQ?=
 =?utf-8?B?RkZsd3cyYytzeUI3VGZVODdrQU1SM0pjVHlWUkxzcUlIOXlNem1WQytmSXZY?=
 =?utf-8?B?bXpIaDlKSDJ0WU51WGRTZHlzV3FNbW9mT1B4elp5ZTh0bEU0NnN5QzhvTERP?=
 =?utf-8?B?UnpBblg3UlJYQXh3OW5FUGNCTUtPdXhWZTFTSHF5cFBCbnp4YmJObkl1ZU5X?=
 =?utf-8?B?aXJNbXZtOXZEbGluZ0dVMmFOT2VpV1N4THZXY2p4cU5rV2NTRVluaUkrTzMw?=
 =?utf-8?Q?0RPkT1TIvAg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmtvVk0zK2l5QzhVUUltOTQrcnp5bC8xWmhWZmNqNnJtUUdFY0NQZjBuc0JP?=
 =?utf-8?B?aTRKck1MZEkyZXE5eUFlbmJoVE9wNTkxS09QamlicWx0RmdRaG16ejVobU9w?=
 =?utf-8?B?SmUwM2sybjNPVlE3N3hqeEp2UTAxNGNrNFlqd2UwMVFxSHB3VGovbXRvR3JU?=
 =?utf-8?B?N1JOVXpHcVkxQS9wRFA4Yi9VWGhzTnY3TUtVWGd3d2dhR05aZVpGZUEwejQy?=
 =?utf-8?B?OWFTOEl5SzRWV1J4a21ZaGg4Y244QVNvZjdLNHVqeklOejhJTkFWLzVqd1FL?=
 =?utf-8?B?TTZ2dThSaGNjOUphd1ZPR09Hb2w0WlJkRHFIUFJQT3pjbFZmdlJzVnlnMllZ?=
 =?utf-8?B?RHVaWHJlc2VGaUV6MmN1d0k1cmYwMmxUajRIZ0pFR1pmdlcyNnNYbmMzbDB4?=
 =?utf-8?B?V1NDRGhydDdkZy84V2Z3VUtiS0VFaXpuV29hQWpxQkhWRlJnMG01RzJQT1cx?=
 =?utf-8?B?K0lzaWluSXB5U1hta1J6UTJHSXVDMk1LNnk2UzN5NG50c0V4L3NpRXRrTmFv?=
 =?utf-8?B?djF6ZUJNY1hyeXc5T2Fnd0NyZ2NjdXFCc05SRmtpL3Q4bmJ6Tjd1L2ltd2hr?=
 =?utf-8?B?ekZ1dC9xb3hReTRodjB1andwR0Y4MElpbm8rUGwyUnhjaVZiZUVJTDRxTlg0?=
 =?utf-8?B?Tm50Wm83Q3lNeE1QSUpZTnhFNFBBY0p6Skw5VkZnZnVEaGo2OEM0UWpJL0F6?=
 =?utf-8?B?ckZxSlZtUHR4M3dUQzY5R0diaGdRSTM3TDcwajd5Q2FTMUk2Y0k2dmtpa1dz?=
 =?utf-8?B?NkNmUEJqakdPS0gvay94MVY1M25lWEE0QjVTeFcxMjdZeWJTOE1tbi9KWGZD?=
 =?utf-8?B?R21vNk9QM0o2QUF3d242VnBveXhSbFJRK2RWM09nV0V0TjNTUW96Z0dzMm5j?=
 =?utf-8?B?R2xLMUhWcUMxRytzYzZUS3FhRUZzUUo4cDdRdnArRUxKNkdSV0ZCVHEwWG1X?=
 =?utf-8?B?djhONEhVVStBaHdBQ3lWSG9oNktLTmRjUDc4ZGNDclArR05JRXZlS0RHZzZi?=
 =?utf-8?B?VXQ4YUNtSjJ3M2NGUGRGUE01YWtWT2N6UG9oaGVMR1FwOFlnbGpEOCtZVkQr?=
 =?utf-8?B?RkVlM2sxZHJjT1hhT0VTSjFLQk04UmNTYTBNTDl2bDFRZXBZWUozMlhoNk1D?=
 =?utf-8?B?dEhrUDJDVzJ5S3h5QzR3RWN6cktvUHpuM0t5RCt1TWhCaE91ZXNTNWxiMkNI?=
 =?utf-8?B?OEY2SU51b01tK2haUnlvRWhvTVFGR0FPbS9ya2xMVEtwVU5jNUxiL0dXY2ph?=
 =?utf-8?B?VnFOVUF5NGF3YWdLOS9QOTdKZGwzRDdmaW91YUJGaWIwN3Z2WlZsdUNEVHR2?=
 =?utf-8?B?bUFGaWlDTjJMalB5WHB1S3RLUjJhalRoSDR2NU41VFBhTmtzTUNJY0VWb0xI?=
 =?utf-8?B?cC9WT2J0dFFqSHd1dEVwbHpLeWNHWk5vOEJpN25ZYWhYSDd1T2xoOWJCaElh?=
 =?utf-8?B?U0ZEVVZtL29OUy82RkpHa0FDQklXbmprL1dEa3grZktkM2dFYzBmZHhrOWJP?=
 =?utf-8?B?OXl4b25BRlNBVHQxcEtqTEpoRVY5Zk9IVGxFNWhBbER0bXRZWTNnSjBTUFRH?=
 =?utf-8?B?ZjhEZXdSNjYrak1NbU5Jd2hTSkl3MkFHRFFDcFpiODBUU1F3M3pEN2MrUGNR?=
 =?utf-8?B?d1N5TSt6N0ZGZFJGdTlibUZCNDN0MXVFRzJDWGZqZUgzclNCdFBDYk5rUmRn?=
 =?utf-8?B?Ni95SXAwZXcreEtUVk43Qy9aMnpjUEJSRzlsN3ppUE9jNlpJcVJLK1J5Q1Zs?=
 =?utf-8?B?NS8xMnFCTHowU0tjM21FQTZqcWcyWHFlektneUhrLzFzd1pCeHVmNjFCeW5i?=
 =?utf-8?B?N0YreE5wSUJFY0NrRnFrY0IzL2I1bzZuTW95RHRZMUhWeWhYTGQvQmcrNUw5?=
 =?utf-8?B?RzgyRWhuekpneHhlaWtaWGRlU3lZei9mUUpjYWRCTC9ERnJmSTc1b2ExalVw?=
 =?utf-8?B?ZkIreEVHampBblVBM0xvM0REUG4wNHNEK3dySFNpN1J6R25ZdVdWelh5VzlM?=
 =?utf-8?B?UVdxZTRnODBQaEM2bTJ5QWRLeEIwU2I3RUdzeUF3NUFiUWNGcjdaamQzVnc3?=
 =?utf-8?B?anR4T0F6MVoxb3lMcGVYWWNFR253aGdUeDl3YTVwOWFWUGg4TWMra3VEdG5s?=
 =?utf-8?B?NE9ZQm5wekdIelVXMko2WmZaSkpHSER0UGlybHBBU3JScTJTcXlLSEd6aDd6?=
 =?utf-8?Q?oNBbenxu803EWK5j929YliE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d7bc00-335e-4cce-7a26-08ddba594baf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 17:44:44.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9E2vtwXjmkdpD1heREbufUZ1B+vwC6YTXLiQBZpH/gZto452T4feYlU6F3U9LHpn+WCWUCju8zKgPvd3aMW3gLnlpCrCQgb2sfs7SLYxyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8087



On 7/3/25 8:30 AM, Rob Herring wrote:
> On Mon, Jun 30, 2025 at 4:38 PM Matthew Gerlach
> <matthew.gerlach@altera.com> wrote:
> >
> > Convert the bindings for socfpga-dwmac to yaml. Since the original
> > text contained descriptions for two separate nodes, two separate
> > yaml files were created.
>
> Did you test this against your dts files?:
I have a log file with a clean test, but I must have overlooked the 
errors below in subsequent tests.
>
> ethernet@ff804000 (altr,socfpga-stmmac-a10-s10): iommus: [[11, 3]] is too short
> ethernet@ff802000 (altr,socfpga-stmmac-a10-s10): iommus: [[11, 2]] is too short
> ethernet@ff800000 (altr,socfpga-stmmac-a10-s10): iommus: [[11, 1]] is too short
>
> There's also one for 'phy-addr', but that needs to be dropped from the
> .dts files as it doesn't appear to be used.
I see the phy-addr error. It is coming from Arria10 .dts files. I can 
submit a patch set dropping the phy-addr property.

>
> [...]
>
> > +  iommus:
> > +    maxItems: 2
>
> You need to add:
>
> minItems: 1
Thanks for the hint. Should I submit a "fixes" patch that adds the 
'minItems: 1', or should I submit a v8 patch with the whole conversion 
plus the 'minItems: 1'?

Matthew Gerlach

>
>
> Rob


