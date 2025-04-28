Return-Path: <netdev+bounces-186542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A26A9F8D9
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49C118888DD
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69D228DF18;
	Mon, 28 Apr 2025 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="uYeuH4R3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2114.outbound.protection.outlook.com [40.107.93.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006EA270EBC;
	Mon, 28 Apr 2025 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866146; cv=fail; b=ZkCxbcPYSGc2NEq6lUdVoPFK7N6u+bSSI5+egEIw6hoQpopMEu6rCVJR5QYHOP04AA361P1Yaq8Pw/kceLho6nuAgy0yNHa3zZbcVCTQemagBH7JWbQzivyvvx6pb0Oj/zNJghEpEv8w/dJ3DjRka/EnoKyv67h1bpXXN8VqA9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866146; c=relaxed/simple;
	bh=SgbKgE09ymwqrQFXHp6OItlKktzlYsGszqFT/5crZ3g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T1GtmqRFeAc56vSi5dwGemOUZ68GUGaU5CFC74oo3jjJlQ4FaCXgaH+h5ybZcoE0o0DrPjf3CjUYxjBQ1AMsy3IB6xylBtRZ3yte5kwwy6m+N11rFxAuKe+5oH2zANfTBzlNc51hNIXYZY52fRrXdZmO7nNU1IPJ76bPnaq9fXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=uYeuH4R3 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.93.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tddqL/bUMSXsGjoFRgUAkbDfrtYg1dPopAK57GlN2pooRr+J5rdhoRIrPgO57xOIHbOzb/HBIGUsmrIDG8hwAoj/cZZN4ewmYkP9clyrDOJVp33pA3ZdAHj6Fib1QDgCuzm7BLjm4UYvKElCakWJwuEg30l14BYhXaj0N3xdhGMYSb/68k7wYvF0XEYorQtk7wtznGckDad1PGS/XDLxaKX4aFGtNQIa3y6p4kGirnYGyiY6+IjhFayDQK7ptIsqvFANiIxiuDuvhY9ijNg7V0NMhG3rjk6WD0ihp11xlj6wIjEPJYxvVPiURmwSHoLUqcwCCG1YAr7PqbKWKB2vjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdbhqLkR53yLc3LVOLucNrekmjPlOxuM2m0e8OORikU=;
 b=gYBK/0UJ3hi0jAS0IPrEzz9MyNHL9v8d2+6IfzRQ6x9ClbV+jLA7ohBYYFS04r0WYy0XsfRl8BkAv146Go1E54vIMouLMirShyf4VSAybiZvP3XeQXnM0PjfnIX3iRS3nNViD5ypGGH1/tMZG/Dz5HsxCjdQKtMQmAPVNa2k5OX305etOUA1WpoGiJHTL5gRCG10RaIqyVyOOjC8QdTrhYuEimhDIp0IameO6y6ODKmz0JHSuIEnP1jwjJHo4meVs1LsRoaXLwyFyVxrcXkUSgU0vqWZ5m9iwLvv6A4OUEu0SME2eJhP2jRsvv0ox7A2ZJXoV28dG7QBSiKVmt71IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdbhqLkR53yLc3LVOLucNrekmjPlOxuM2m0e8OORikU=;
 b=uYeuH4R3aSaatrLASJJGiigu1kLYYNHlQ5KZEz06nrX2YYmOuViPGztjZSXe77amadGqxMqttM+pwYcOBjxMtqRxkn2au8zwV7m/Q7Pl9kcMGl+s0n/6G8VjfhEeMM7HL4C5CqmN5RBjrSf+LLkY0K4pnT71WooTuPMIjSCDFrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB6620.prod.exchangelabs.com (2603:10b6:510:90::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Mon, 28 Apr 2025 18:48:59 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 18:48:59 +0000
Message-ID: <a9f67a55-3471-46b3-bd02-757b0796658a@amperemail.onmicrosoft.com>
Date: Mon, 28 Apr 2025 14:48:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: "lihuisong (C)" <lihuisong@huawei.com>, admiyo@os.amperecomputing.com,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250423220142.635223-1-admiyo@os.amperecomputing.com>
 <20250423220142.635223-2-admiyo@os.amperecomputing.com>
 <497a60df-c97e-48b7-bf0f-decbee6ed732@huawei.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <497a60df-c97e-48b7-bf0f-decbee6ed732@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: e43d3c35-409a-42c9-6d25-08dd8685561d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azBURXBFWlZJaUs1QXMzNXphZlVidVlST2JmQ29VbHVBbGNrR2ZkQ05ZaEkr?=
 =?utf-8?B?aFQrL1RhK2pTaGZsKzJFbjJuRDNzWkNUbllVakJZMmpTaGR3N3NicFVVWFN4?=
 =?utf-8?B?YitVZnh6b0g4VTJIMkRYRmwxSnRsTEtuWm1BZVpWNGxiYmFRc0Y4Z0FUSjFW?=
 =?utf-8?B?a0pBM0lNeFpiRkk4cWIxQWV6QitQdzhLcWhwNG1SN1ZDZDZlU3F1UXZWL05h?=
 =?utf-8?B?T3hGOWNsL2FUWjhIaWtVUGU4cnlIYm53LzFlWVFXdUNJTFZrZkJVbk5TdzVt?=
 =?utf-8?B?ZFhFNVJpSDJneFZLT2VuU2pEVXU5RWhESlBpZjNTWmhGdXQrdG42azdxWXZ2?=
 =?utf-8?B?eUpwWklBdWloOWpReDI1SlN4UTA2RXFQYnBmR2lmS2J3VEFLaFJEc2YwUHFT?=
 =?utf-8?B?dTJqczROUm4rZzczWVNTb1dIR0hjTzMwbTlEam9HbGhSWk05UHZmQ2pFZEF3?=
 =?utf-8?B?OHplQTM2MEZGQ2Z1ZmYwRWdOQkd1cjZEOGZlWUtTdy9Zd01WRk9lRDdUaWhR?=
 =?utf-8?B?QmthRG9PZlBObG9XUlQxcXkvSTh2bHY0c2o1dlVyVE52Q0VPUlhNRllDWEln?=
 =?utf-8?B?NnVVZEp3ZEJJb2ZtR1ZZbUpoVmc3QzhwNklDWEthRXV1aHFqN3V4OC9Celdn?=
 =?utf-8?B?NWZ5a3p1dUtXQjdlcXhRS2V2K0I0T3RCd29Ia3owd3FIQ0JCMEUxaWZ5UXBx?=
 =?utf-8?B?ZUZFNmc1bDZ1Z0tXOTJyTGcwR2FaSzY5S0NNYldsNVE2V2UzQms5ZnFvbkFB?=
 =?utf-8?B?cUo3Kyt0NjFqTUhRK01rMjVRbDVBT28wWFphNUhwMHhUWDF0eW5ybFlpc2dU?=
 =?utf-8?B?Tm43VncvK00wT3dzcmNTRWVyaG5LWHNER0pxTVMvRnRIcldsd1NBc3QxUVJT?=
 =?utf-8?B?WE4yMTBXbmpSYWZJdjFBcGlIS21KK1ZNVTdXY0U2SVN2RFVHVVg1VjdyazNN?=
 =?utf-8?B?TWFDaTIzK3JyN1lPL2UzWEJSdzcwNHpUR3N1cWlNZ1dzUTJKRE55R1I4RHpw?=
 =?utf-8?B?ak1pZlBBL2RrNkVHWEFJcmVEZmEyajhtK2o4OFFmMjdnSEJXWDkwczFOa2hr?=
 =?utf-8?B?RFJDYlR1azljcVpBY1FXNmdHRTF1VmdLekY0OWw5NVViTndlOEkrQlJEb0Jy?=
 =?utf-8?B?bXJOSmVRZFZOSEk5MWtrWE5HVXM0T1ZMK25WTVZPVUY4V1VRbXk0bk9lc0d0?=
 =?utf-8?B?LzZmamduRUlZTVU1VGJEaHBxeEFiNXhyTmRreWpOOCsvSHBWWTFTTXFIaVYw?=
 =?utf-8?B?N0NsNnI0c2EyWHV0Z3Z4amI3RGk1bEdLdkdISjZsaFFLOGt1cUhVUmVDQnE0?=
 =?utf-8?B?dk9vQlVEb05mbm8zR3B1Y1pnRXI0SFFVNjVqRnI4b0pMaGZwcm54Y3FHdzhx?=
 =?utf-8?B?bk5URDN4eGFqR2g0Z2V2R0xjdjVSUUltVkJWMEpraEZJSHlIb3FFZ1k1UXU4?=
 =?utf-8?B?d3pHY3ZHWXE5V1BONzErUTU4UG9HWW5Wcnh0YUpwOTFwMWdPR3VXWXZPRkl5?=
 =?utf-8?B?cEI1bDlyc2RrRGJrY2oyenRsaVBabDJDR21PTE8vSkpOd2s1RDE5bWhUYk5G?=
 =?utf-8?B?d2IvczQvRnN3QXdCUC9FSHZQUllaZEJua3NaZFpTSEl2cGUvYktFREc4a04w?=
 =?utf-8?B?aFNQeU5BTEJXNUcvZDdFUS9kbDU2RmxVcEoreTZvazhjTzRUVHo0blJvTVNk?=
 =?utf-8?B?SGtWM05NNWpjYlZtWVJ3VVhZai91NGpSb3JlSE9nVjZCRGdlSE1mdURVd1Vk?=
 =?utf-8?B?SCtCcG9KNXRwQ2pUWHI5ZS9PYVRDSHEwYmZsN2RWVkhmOTVxckVtR3I2dkZl?=
 =?utf-8?B?eFplMCtZeXVIMVJyaVVWK1RQcnMvMlppZHlydkh6VkgydlBQWkdxNEZaZ3hr?=
 =?utf-8?B?dHhLaDliaUdYK1dBMUtuR1IvRlYzQk1SNFVvczlUVkFRZ0t0MVQrNVkyT2FC?=
 =?utf-8?Q?3XiI9uun/mk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzNmYXNYSWJNRktGbVRkeXZITU15b0F6b0JVQmdJRXhzdVpJSnJqYXl6cVM3?=
 =?utf-8?B?aTZYdVN3UVMzMzd2TVJlMnh4UVBxWm8ydVk4TkYrR0FKQXpvVkx5NnNqb3hR?=
 =?utf-8?B?ajE4ZXc5blJHZklGVkpERzBKTVA0UVpGa0JlSjRFdUtkb1VSbWxDTXZBQktB?=
 =?utf-8?B?UnVGM0VhcUIzUTZpNXZDOG53RnJDU3cwOXNia1B0S0thVGtLZUtuYXZwM05t?=
 =?utf-8?B?Y21IR1ZHS2FCeWdkRGpIdlMvR1ZJREFLWHBJSnU3aVcrZjVQR2pGOXBjTjV4?=
 =?utf-8?B?alFDMUZNVjJWbFNOSFY0anY3NUhORE8ydGJpNTVXNzFCNkdENjg0YWlyOGgw?=
 =?utf-8?B?U0FERkJNeWlTUTFvQS9pOHgrb2dscGdmTmI1a0lFeC9DSHlzMjZBNHlabUxT?=
 =?utf-8?B?ajRvQ2s2UXc3dG9YUlJ3UG50M0FHSVlXSk11OGdxcmxQKzNIUDRqRWcxb3R4?=
 =?utf-8?B?bW03WUxWVUVCNjNmSVNIbk1vaEpxOHJMRVpCb2IrNzJQWG5MWWEwNng4T1hN?=
 =?utf-8?B?TnFodnhpK1dXaXZjVEszaFVwbzVFLzFZaUQzaGxxU2srejZNaUloa1EyOXBt?=
 =?utf-8?B?Wk1iQ0pSNHFQeHI1cTRSaG94VUZVTnNpVHRBYlJDbjh0akpFcm54SmR5akFi?=
 =?utf-8?B?N1h2VnowVW4rSjV3TkNqampiZlE1RlFySjZ2bjZjbWJDc1oyanRKUkdBaDhm?=
 =?utf-8?B?NzJpdmplZXpnRnNPbEw5cDhLSHVCeFFHK0xKd3UxSW81M1Rja1Z1WnErWDdp?=
 =?utf-8?B?eWIwVmZKV1JQQWVpL3BHNXhZV1lkUjJzWHBsY3hYZkxOYnpiODc4WUphLzNY?=
 =?utf-8?B?Q21qdEY1ZnpYUzNXZVFudnZJcXRVNHgrcVZaWFpCdnhaczFjL3RaNElVUzdh?=
 =?utf-8?B?U2dtMmtXKzR1d0hwMU9ZanRuZ2pDdnd4akx6VGJ5ZmZzdEpUbjNvOVlQNlpn?=
 =?utf-8?B?bG9FbVNyVDdSUmUzWnh1dzYxQ2pNcWgxZ0xLSlFaak85Y21GU2hwTG4wNU4z?=
 =?utf-8?B?S01VWjV1djJhS3UyZXgwQVVhWUkzdmdzTWxrdENWc1BTWDdOSHpJaG9iQjZr?=
 =?utf-8?B?bWhJM2hSempyRCtXb3VxNDhmZCtwR2dKcGh4TnBYY0FJSkhyMXZtWVRZL0NO?=
 =?utf-8?B?V2k3VlZJN3BOVzgvVVZvekdNSjJacDNRMVM5RFZPeml2Y3BsY0Ewa3Y1Umhk?=
 =?utf-8?B?QUVJdjB2eDRmYkVLWURhVExSaFV6MmNpbzh4dk5Ldy9DZ1RyL1VyVDVncGcr?=
 =?utf-8?B?ckkyMHk3d0FxeFFJSElpVFFCa1NXSUdzNjRUbWhUeDF3UDU4Y2FOQ3cxQms4?=
 =?utf-8?B?czJWSmNKQUdjbVdlc3h2MUJnZWpkTWZJOHFmbVd0SUtwc3MrYkNDTTB6QVE5?=
 =?utf-8?B?Q2hMdWlwekV3eXdrSHlDdkV6clB4Q1gwZlVsbytJbDJtejdzNDJVY1VXZ0dX?=
 =?utf-8?B?Q2Z2VkRrdWRQZUNLaHRsTElCNDIzNFpNSHU4NHRlUnYwYXpaaTJSdVN1bXY5?=
 =?utf-8?B?SEhVSTVLakdjRHF1ZGNCVGl1clRxclh6a2FhNWNaYUhPRlJHS2FjUjBnL0FJ?=
 =?utf-8?B?c2ozYUttUWc5c1FLVHR4M0JNSndNVXFIbERZYkR2aDh0L3ZFdHpqV3ArNWdu?=
 =?utf-8?B?L2dYczJ5b1YzdnhrOGVTOFJoam1CZG1TcU9sNnd6N3g5NHRLc3pjd0h5MFNx?=
 =?utf-8?B?S2RiYW16dGNMMTRTOVc0ZDlhazNybHlrd2VydFV3U1JDWUEzbmFaU2s4Y1hH?=
 =?utf-8?B?Myt5cTZUbStnY2lGRjVyODFuUlNkdjJFcGgxcXVEakF6eTJoeXFINXdNTEg0?=
 =?utf-8?B?MUZ4RmlpYzNveUo4TkF1dERzcWVUbE1sZ05tSG5KbVNmcnRZSjkrdFZsNk9k?=
 =?utf-8?B?cFlId3VzTlZ6WkU2YVZWY0l2ZnFLQXRGSUdqRDR5S0loVGxFczlPQ015UGRH?=
 =?utf-8?B?a0VhS0ltaTYxeDVZTmw0OEkzMkU1TkphaXFyVDNzK1NXYm5FSHRDSTIyTU04?=
 =?utf-8?B?ak0ydGJNSVROaXRMMExWLzBIQWo2TTJCYldLNWN2aWpVRE1Ma29BUGVzakNH?=
 =?utf-8?B?dEdnTHVZTVQzZ2dKVHhjcVl0M3ZlSlRlay82cERuQUQ3Tk1OUlNYdUt5c2c1?=
 =?utf-8?B?bllEcFBKNXJPKy94a1RCOHFyQzRvZFVOKzBkV1U2cXduZjc1aXNETkZ6TjU0?=
 =?utf-8?B?UXhybjRLMWhvV3dxRHIwS2tYdVpQOTdnS1l3RldUNEx5L0NxaUU2MklsZHRY?=
 =?utf-8?Q?2ZjcACJCIg4xSaBMcK1s8ZxjntY2ujf2cLVAMIDvHU=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43d3c35-409a-42c9-6d25-08dd8685561d
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:48:59.2148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOXRsrlpcXbER61pvrpfk8nFSFL0jnSUPLC425q0FlgAV1DSH6SNq3eu8jQtsFskEwHjjh5igym/vivGA865AKPGWUaCLlAvw8F7SA9v8Qk8CVXfB8f0XUWxF9cH64GZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6620


On 4/24/25 09:03, lihuisong (C) wrote:
>> +    rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
>> +                     context.inbox_index);
>> +    if (rc)
>> +        goto free_netdev;
>> +    mctp_pcc_ndev->inbox.client.rx_callback = 
>> mctp_pcc_client_rx_callback;
> It is good to move the assignemnt of  rx_callback pointer to 
> initialize inbox mailbox.


The other changes are fine, but this one I do not agree with.

The rx callback only makes sense for one of the two mailboxes, and thus 
is not appropriate for a generic function.

Either  initialize_mailbox needs more complex logic, or would blindly 
assign the callback to both mailboxes, neither of which simplifies or 
streamlines the code.  That function emerged as a way to reduce 
duplication.  Lets keep it that way.


