Return-Path: <netdev+bounces-192846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B89EAC15F1
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 23:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FD8A41EAD
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 21:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DDA256C86;
	Thu, 22 May 2025 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="JBf4Rgn8"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11010044.outbound.protection.outlook.com [52.101.51.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7CE27715;
	Thu, 22 May 2025 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747949938; cv=fail; b=L0i8OEzpsnYsLp6jE63swEVRGWybEAhR/QiZa7cLqCBgf9dbR+tIUVR+toXBTVa93Bay8JgJq7bG76Yp0bOeKTqo9whOKiB2qwuMGWChXTYK9biMLqaPA29BSNATVmsor8FyBLfCUmiD9QCCCmJp5yBB38RYA+UAW8Icut2N/cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747949938; c=relaxed/simple;
	bh=IPSFeNxU/tsv3N3WMDmJhc+MyMDzhR/RVplSpK4wq3w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D9hIWgZYA8tSLAubey3Ktg9D7Aj/HIbfJjThrBim3aqj+ikAWORoRPgTBz7SY+eN0CWQ3MDaxDLMbP1qy7pDjW/awxH4Vws1UwIPeaHAykOcukEkYBDwxhUoTi7DkKa64T8mr9NFKYyx53Z+JPMIL57b1C8BMabXGSKAd53fHIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=JBf4Rgn8; arc=fail smtp.client-ip=52.101.51.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnqpQecOG1TiaCPqhiyrBD0LaWIVPshZ3jbi4KFLaJyp+vRGEM1uG4yQjblgJOyTuuAmGjv1SZELFPZNzjIy/dpHXv0Sqs3eJBwd14gHIKktyzER870O8j3pxF1wsNaueZJgtHK7ZNBLkyhknWckFhM8YM9Y7SJZQPb///fKoFq+WuuUTFI5WvtQAiOgnaqw+9AmiY7yMb0jVPA51LyRuOZ/qc6mbwusSAAkphJVZGNVMGsdWBET7gyl/0YhkH0w8glpYUN+6iJ8y97KzVa2Qqjo6ByPVsFt1acd92L83PF3M6iatQlj6THeXAkU/Aiqc5/f5QI89tC5uvJIR7edHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fhp//J8JsBrUikqECjjd7Dtr1upwARlBxFSElMQ5Js=;
 b=na/NPC6B+sdUaY9/Uz9vYF67LCmvgsDfpEOJEziFGHwevUSoQPIIxNeENymLbbBziTeyUVrxShf4oCX1DsIV5thNux2zZrRiACDlmIyN5SXhq4KNG9TBV/GYaQijaNaGBI/pJUoIutKTSBc0naAmPZIwapv3pxPUaxiHQuZeBBrlqQuOXCpidc766SwdryXHHTsYHCX2W2Y6ixiOJ54X+yc49HQwAJP4uM/ltvPa4mdcFe5/PKj4FxeBX4/u8/eT1DClYI7hZsxIkb2pI45wqWLUf2YkhmmFMc6Pb7wLjuGfPezwc6CEPJPOoqoYkwdu3SFBRLD7lNndun7+oAqGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fhp//J8JsBrUikqECjjd7Dtr1upwARlBxFSElMQ5Js=;
 b=JBf4Rgn8xJT1dPxOLLi0d1uzsBODuHF+8KKC5iUq7VD+d6CKnkvoMr9VoFk4BF8OlA4YiD3D4165FR2U3nTqt0xbh7KvySVGLaGywVAFywWQGnHg+xDApN0xV1RLSAgi2dJE+RelQ5kBSQzJzoJ9+9Gh1nj9/0VSFgQQTKs+OLbbTNszyoK12hYs9m7KMWedG+fIEZK5FYHrAOPEY+knxi+aUUGDpEbkcCO9Hq/EM3P+K9x0t6Bgu+L+fILYzYM7XSlj4ZbP31kcb+6uYh0lnHhTgr7PTbhIBr+UVnlNVxR5SDrDzll7cjn8JlQPv87KuIdYFqLNSb66efDraHPYnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by PH0PR03MB6940.namprd03.prod.outlook.com (2603:10b6:510:16e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 21:38:50 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8746.032; Thu, 22 May 2025
 21:38:49 +0000
Message-ID: <77278a5d-e606-4a6b-b88d-d17968d7ab31@altera.com>
Date: Thu, 22 May 2025 14:38:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: Convert socfpga-dwmac bindings to yaml
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, richardcochran@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mun Yew Tham <mun.yew.tham@altera.com>
References: <20250513152237.21541-1-matthew.gerlach@altera.com>
 <20250520195254.GA1247930-robh@kernel.org>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250520195254.GA1247930-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0152.namprd05.prod.outlook.com
 (2603:10b6:a03:339::7) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|PH0PR03MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: a4389d73-e183-46b6-22f2-08dd997908ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlNIMUJTNm4zdlJZVDdEYW4zbnR1MWtwU1kya1BzblFDaUpoYzl2THVPSmlj?=
 =?utf-8?B?RktEVnY2QmphY0N4aWVMdUJwS013Qm11RjVQeUFjTEZOOEVFVFVPSTB5bHE0?=
 =?utf-8?B?Zy9KeGliV2R1OUN3U0N5U3o4bUx1bldKbm10d0ZwSnBHanZyWDQ4blFzN3Nn?=
 =?utf-8?B?MjhjV3VPQ1lwYlJBQ1JpQjQ1V3JnQmxPbll3U1JHdzNocnRHL0dyaVkzbGUw?=
 =?utf-8?B?Z3RIZU9UaWFsYnc2T205cTJTa0t3WW40NHJacFNTQTVKMURoMElLYmpOQmNT?=
 =?utf-8?B?VjNBTnZ4bVRqajJIYS8yVU5MRXlDanNJajlQcWliUHp3OXN4SW9qeS9pazRk?=
 =?utf-8?B?UTBlV3RjNVd1ZUh6MVFXaDlOVEFrWWJ2ZGFtS0hZTXFLTzBtaGszSHBhRjU0?=
 =?utf-8?B?RXg2MUUweVIvaFBIUEVVR0c1aVlKQWNrWHJkekVQTnpxRDdlckZZRm05THhi?=
 =?utf-8?B?VU1rcm1sUWhRNWpWS2pQTkhQbjFwc3djTm11ZzM3d1hsZjB5Z2I0cTBua3pH?=
 =?utf-8?B?WlJaV056UDJrMDRQbWdscE1OWmhUdUJTTXo1bHVTeEVMYTlldmxJNlcxcE5V?=
 =?utf-8?B?aElveVdTUFozN0pLRFIrUDZnTVlrWGJabVpHaUQ2dkpxOG94YnQzMGZRWEl0?=
 =?utf-8?B?T2RpSlJMaUd4VVUwWUJNQ2FWblpoUS85U1pBdCt5K3R0UFJVYzZlcm4vVFQy?=
 =?utf-8?B?Nmp6UUg4T3R4Qjd1SFgvMXpxWWVpK0tRRkszb1Vjd09reDkzQzBUeXpuY1Nw?=
 =?utf-8?B?dHYwU0EzdUFSM2tZdUpISnRYK1pobVJha29MbHlSUE91Qk83QzBDRm5mNFYv?=
 =?utf-8?B?SDltZEF5S1Z2ZkRCVVNXOVFXNnk5bVZpL01UOFVtL050MW5GcDBTUnU5S25N?=
 =?utf-8?B?SEdrVXc2U29QVDJPVFQyYUZVTkVxY3ZyMkVUcjZKRWQyU1JodVBIQXdKRHF0?=
 =?utf-8?B?QzM3bTZWSEwvYUNNdm1IOUcvZWVuY1pIakc5L2w3MVhEU240aW9kb0FwT2Mv?=
 =?utf-8?B?S3NMTXBFK1hpRjhPMDVabTFkY2cvT3c2L0ZUaVRBVWRoQXdnaUtMNE1SQUMx?=
 =?utf-8?B?UUFWdjFLdmU3dVp5RlMyQ1ljTDJiVlZmYlZQQWZVWXBxQTNuc1FuSWFONXBl?=
 =?utf-8?B?ZWdOU3VzUVNOaElRWXp5eWk5YmxDS1hKbG1xS2JnbzMyQ3AxbE0rUzdPdHB5?=
 =?utf-8?B?b0R0MmlVd29OQTUyU0pCZHl3NGtiSGlqTG9kNHlGeG9LKzFBWDExTUFtaXdv?=
 =?utf-8?B?ZVRSd0dvVHFLZlNyUXVNenU5dE5KTHJTSFFBTGtMUE9vazJ1ek5MSWRwU0x4?=
 =?utf-8?B?aHhuNmJxYlA4a2VZOUVQcFMvSmFEMG1DRGd3V2NSY3ArZHphZWhLNGwvT1o2?=
 =?utf-8?B?UzJyU21yMGY2UE5aSmtVQ2RMVWVIOGszSHlhZ3U3Z3YxdW1pWU1wWldiWHln?=
 =?utf-8?B?aUU2VnVNa1hNbnBuMUVZdjdFZ3dhbDhUb3hLd3h4aWFzdFlvWWwwY2t3RVgw?=
 =?utf-8?B?U1lzclFVdGxIYlZ6dkFxT1ZaamV5bCtyaTJzMDh6Rnp3c0kyQURJY3E4T2Ju?=
 =?utf-8?B?eXA4QUdJc3lqaFNsNlM1cm52WEQrK1QwNXE3YTBYWDJmbDAzUHV1QnJ1VGVY?=
 =?utf-8?B?N250bEdmOC84Z0hkc3pnQUNtOGk1U3hqZkJWek9tek4zUDRheHArano0eUhF?=
 =?utf-8?B?dlJtMm1veVhrYmZRM2hvdjAzRzF4S3dvYnhDOUpxaFVLWHBjcGIyaVJsamdo?=
 =?utf-8?B?YmdraXlIZzRRNFRROUhSazZkTnNSdU1hVXJLdDVBNjB4L1JNcndjcENFdjU4?=
 =?utf-8?Q?z9OpSafhFqjL3/erWePw47wW7e3kLXzq6H8ZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2UwYWlMTy9rSTBtSmFFcXo4N2hZazZqZ2RDZHd5NG9DV1I3dG9LMUQxZnhs?=
 =?utf-8?B?MGhLZ1RmdUN2VGx4cXZmWmpUd1puZU1QL0d3cDFFbkpQaElXdDVldmE2S05r?=
 =?utf-8?B?N3RqUlp5VmhvWTZvZFhlL3AyUlczdGFzVVJ0MTdsalhvWWRXbVB6UGxITUN6?=
 =?utf-8?B?b3M0RlZUcjVwaGQyQlJOVTlnNzFtTDNoanBNS014c0p3K1pZamlOQmk5MHNE?=
 =?utf-8?B?NEE4TmczRXdXcU45S2E5K20za3dqWldibXMrdDcxTkFKdGk5aEN6ME9DRnNT?=
 =?utf-8?B?eFh4Um9WU2ZZcWtNa2VhRTJTZDRMTm94QzNFNWNhc01Nck4zalFOWlhZYmFJ?=
 =?utf-8?B?ZGZ0dm9YS1pOR1lKOFArKzFLVTgwTDd1OU5Qci9aVW95QlB6b1FnaDlDMmFm?=
 =?utf-8?B?SjZ6eUlxbGx5c0xDNExSRUdsaXQyS1FXZG50RjgvaTJqUFpkVWN3YlJlMHRm?=
 =?utf-8?B?ZXM2dXA0ZXRBS0hJZmVtZUNucmV6MHFIYVh0V1lpZFBxZGY2WENrYTZLUmdo?=
 =?utf-8?B?MlhrUXA4WWhvbVVIODNTQUlXUThNc3VacCtEUmlrU3k1VitacmFDaTd6U28w?=
 =?utf-8?B?UDV6blkwUXRVQWs4RXVTbmw0NUg3dXlEd051eS9XcWV4SnFiK0pzaU9pT2Rl?=
 =?utf-8?B?UU90cTk1RDQ0VVFqaDliVnVPdEZ4UkcrcDB6MVFER0NLQ0YzT3V1aWVNTlFL?=
 =?utf-8?B?eEpjcy9OVWtpVXlsTzJpUFFoMytRTjBGYWMxZ05qNUFrODlaUCs2dzd3SzJs?=
 =?utf-8?B?dlpYWU1pWlBVai80amljdFVwTFMrTU9lemwrcXFCOXZod1NKd1h1ZmIrMEVz?=
 =?utf-8?B?UFdVVWF4djJQckR6ZkZVUkNxSTZmL3NzT2VSc05jbElEUUtEUG5kaytRR1dy?=
 =?utf-8?B?akFOQjVrRFBPTXRPU0dTREVQS3ZVMUNwWTllSUUxMm0wbWg2TmFrNmxyZDBu?=
 =?utf-8?B?Vk8rVVc4ZWpmbDY1bFBuSlBsS1NteDZZS2pidnVxdmNiVlZ2bzh3Q1BYZi9k?=
 =?utf-8?B?ZXJISUhLYTJKTUpZTDhZNm5YVFF2K2pqTkNTS01ISW5ObXBVeTdtOE1WYVVl?=
 =?utf-8?B?VlhJSzVac0xOK1M2NEN4QmRvM0pCV0tVdUtYVFZLVU5rdDVuaDV1c1ljSVpO?=
 =?utf-8?B?ZTl2SzhWVWZiZmRWemFHWG9SeUI1dlNKcW1IeWpKQ1dWbGljZDh6eTVzVlZt?=
 =?utf-8?B?amJxOElCUnZsQlgxeVd4TGhGY2l3clRJQVV2VHJia1VYUU5HQjU5RzIycWRP?=
 =?utf-8?B?aUh3ek1XN1BvNzY0VTFnVlVrYVhjSmRNdGR6V1NUVU9EeE1kaFFrTmRvOUp0?=
 =?utf-8?B?aWpCeWlNcHB0Yno4bHM3WjFQWUNkS3BNMXdMN1UvYU5XU29EMnpIekpyc3ZI?=
 =?utf-8?B?Vjl6UDRUSmdjemFZakdaWUsyc01OZnlpeUpFU1RPUWxRSS82MWNjS2x6RE5z?=
 =?utf-8?B?QXNiY2ZsSVVTMEpGT0hiUXNBeHlBbTVrRHBBL21aTTA3N1k3aVRZc0lqdDRu?=
 =?utf-8?B?WjdBeko1UkZkb1I2RUhRYkRDejJLMTQ3TFc5ai9WSzZWalc3QmpTVVhjUG43?=
 =?utf-8?B?TVFSU0NuVjBmNFB0c3hIUy9oZ1BNRHpubVNiYzZpbWxpRkVlREpVVTV2TklY?=
 =?utf-8?B?U1RCakEyL1dPK2orTitaRWh0NVlCOXl0OXBWRGh3M0h6aWVuZkczbFlMM1BS?=
 =?utf-8?B?UTdWd2I2TnRuT01IZ0MzL1JTbEVuWWFmNU1SanQrdmtWOXE1blcvSmVHL1lC?=
 =?utf-8?B?Wm9qaWNtUWZ3SzNMRzdLTWpjRW9nZyswUVdaZlROSUlBM2VxYktjdTkyZ2RN?=
 =?utf-8?B?d1BoMHduQVFxby9QZDZBaFBDeDFUWitFV1lBUDFFTXVjTVJtVEZIaExpZlUw?=
 =?utf-8?B?aWpjVTQ1YXk0Q0t1TGpRUFZQOGZFaEdEYXp0aU5KUzdVMWkzTnNHMERJa2c0?=
 =?utf-8?B?RTYzbGliWWZhRDNqdUpsV3NVZ3RadTZaK3VFc0YvTXQzeGZuUmlTYk0rczhz?=
 =?utf-8?B?cWZJYjJJckN0NkZrclpaSjR1bW1STnFPKzVzVXIwaTBNNjgvUE5WQlVJUkRs?=
 =?utf-8?B?VGNrY2JtN3BhQU9TS2dyQzgwYW1PYzQ0ejF3NFRTN1IvMW1IVVZqR1dyenNk?=
 =?utf-8?B?Ym1CSjdoQktOd2d3Y2RGUVF3Q1hCT2tCa0tVbElsYzdSZ09qNkREQnJJZ2k0?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4389d73-e183-46b6-22f2-08dd997908ca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:38:49.3694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qnk/2DKptWIy6QalBsuMRsEU91+QfEH3nF6V59PY7lpvqpXcVmLEDsMN3PalQig7MEaFLnbuvAVFAkj07Y1Qe9WkzJJtJe1FdbdTire/N2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6940


On 5/20/25 12:52 PM, Rob Herring wrote:
> On Tue, May 13, 2025 at 08:22:37AM -0700, Matthew Gerlach wrote:
> > From: Mun Yew Tham <mun.yew.tham@altera.com>
> > 
> > Convert the bindings for socfpga-dwmac to yaml.
> > 
> > Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> >  .../bindings/net/socfpga,dwmac.yaml           | 109 ++++++++++++++++++
> >  .../devicetree/bindings/net/socfpga-dwmac.txt |  57 ---------
> >  2 files changed, 109 insertions(+), 57 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> > new file mode 100644
> > index 000000000000..68ad580dc2da
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> > @@ -0,0 +1,109 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/socfpga,dwmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Altera SOCFPGA SoC DWMAC controller
> > +
> > +maintainers:
> > +  - Matthew Gerlach <matthew.gerlach@altera.com>
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - altr,socfpga-stmmac
> > +          - altr,socfpga-stmmac-a10-s10
> > +  required:
> > +    - altr,sysmgr-syscon
>
> Should be 'compatible' here.
Yes, compatible should be here.
>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: altr,socfpga-stmmac
> > +          - const: snps,dwmac-3.70a
> > +          - const: snps,dwmac
> > +      - items:
> > +          - const: altr,socfpga-stmmac-a10-s10
> > +          - const: snps,dwmac-3.74a
> > +          - const: snps,dwmac
> > +      - items:
> > +          - const: altr,socfpga-stmmac-a10-s10
> > +          - const: snps,dwmac-3.72a
> > +          - const: snps,dwmac
>
> The last 2 lists can be combined.

Yes, the last 2 lists can be combined, but I'm also thinking of dropping 
the last list, for now. The last list represents the Arria10 with the 
following relevant dtsi:

arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi

The problem with the Arria10 is the 'reset-names = "stmmaceth", 
"stmmaceth-ocp";' property fails the oneOf: check for reset-names in 
snps,dwmac.yaml. I don't really want to change the old dtsi, and I don't 
think changing snps,dwmac.yaml is correct either. So I might leave out 
Arria10 support in this submission. Any suggestions would be appreciated.

>
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 4
>
> You need to define what each entry is.
I will add descriptions for the entries.
>
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 4
>
> And the name for each entry.
I will list the names too.
>
> > +
> > +  phy-mode:
> > +    enum:
> > +      - rgmii
> > +      - sgmii
> > +      - gmii
> > +
> > +  altr,emac-splitter:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Should be the phandle to the emac splitter soft IP node if DWMAC
> > +      controller is connected an emac splitter.
> > +
> > +  altr,f2h_ptp_ref_clk:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to Precision Time Protocol reference clock. This clock is
> > +      common to gmac instances and defaults to osc1.
> > +
> > +  altr,gmii-to-sgmii-converter:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Should be the phandle to the gmii to sgmii converter soft IP.
> > +
> > +  altr,sysmgr-syscon:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      Should be the phandle to the system manager node that encompass
> > +      the glue register, the register offset, and the register shift.
> > +      On Cyclone5/Arria5, the register shift represents the PHY mode
> > +      bits, while on the Arria10/Stratix10/Agilex platforms, the
> > +      register shift represents bit for each emac to enable/disable
> > +      signals from the FPGA fabric to the EMAC modules.
> > +    minItems: 1
> > +    items:
> > +      - description: phandle to the system manager node
> > +      - description: offset of the control register
> > +      - description: shift within the control register
>
> items:
>    - items:
>        - description: phandle to the system manager node
>        - ...
>        - ...
>
> And drop minItems.
I will update these too.
>
> > +
> > +allOf:
> > +  - $ref: snps,dwmac.yaml#
> > +
> > +additionalProperties: true
>
> unevaluatedProperties: false
>
> > +
> > +examples:
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    soc {
> > +            #address-cells = <1>;
>
> Use 4 space indent.
>
> > +            #size-cells = <1>;
> > +            gmac0: ethernet@ff700000 {
>
> Drop the label.


I will fix the indent and drop the label.


Thanks for the review,

Matthew Gerlach

>
> > +                    compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a",
> > +                    "snps,dwmac";
> > +                    altr,sysmgr-syscon = <&sysmgr 0x60 0>;
> > +                    reg = <0xff700000 0x2000>;
> > +                    interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> > +                    interrupt-names = "macirq";
> > +                    mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
> > +                    clocks = <&emac_0_clk>;
> > +                    clock-names = "stmmaceth";
> > +                    phy-mode = "sgmii";
> > +            };
> > +    };

