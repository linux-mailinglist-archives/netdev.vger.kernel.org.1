Return-Path: <netdev+bounces-207698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6272CB084BE
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 08:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BFE1A68264
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 06:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ECA212B0A;
	Thu, 17 Jul 2025 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="d1D/fBgb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5E1386C9;
	Thu, 17 Jul 2025 06:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733221; cv=fail; b=HKWPkmsTo+jQgPx8p69bzH7gLUpGLHydMBxMRvDN2JBU+a7HOqA5wA9dbU8b83wI25F8iGNgaQiqRObaGOpi7Ncgcjg0u/0Nuyexlthc0vz122snUlqYjQ6nI1zZt5le1P9dhT3qle27KNK7qWYmv2I7x957dB3euZVGQPuI+9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733221; c=relaxed/simple;
	bh=iOO7mUwT4YQ3YjKXkb19QrgdXgp9Tunh4bnQLO0XhbI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rG4CChbTO7VXo9KKlB05myTtKUl+KE7i1HeyZKWoCppmaFoHjX/UGns5elDcemXpk+an7TrArqB4UHvyTmL5yh6cpFrnlM6OS5ayy2ZZgm0e2zm9Ha3Yw3FVNp79BtTdTSwtn+IikaSaaUSzwaMLH2xFIenjTWwoOOrIo/Q4IB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=d1D/fBgb; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mO3gbgESHztCKM72C9qOCQjS1g5sDsu/YjwmThdKQ1JHjo+No2T/bKkUNriKYGsU5ZeaGirh0iCykdsb+m//GlIzyx8rXoTvfpbooMqQ5c7cDvzhzlalPGz0rSUQdKjI+JPuItoDTmIV76awlp10HaSP5aeLPRa2HtMACrMxktx+Q4k2My/LosiNaxJRc1UgRUwO8vPGMThHYr6ffa40RXxLKIWZd42CLR1CZip1nvH2Kmmr+J+VNp4956rlx3Mq2P/Opnb+dAYvSy+q1tSmVVFp+yGZFwe4nYQCf4IcCy41dj/SmSjlyZhsuMBVS+361CkVD5ezEMDHPVJmdGjuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUH5yPJOzyGcVRMwAN/g6mtZE87dxJNkshIgQkbrXI4=;
 b=OAVTFSUBTB+zdJ++07fKajBWLk0SEuWFvLMgcHTQydbMdOMOELHPCArbTro8uOtjbOd+NwAdkEHoulvqrKuUz/Vu8/meXQ7SiTbiNHRAfLGNXJP5mzIq+H6myNDZ8UpMdxiPTODvBexhLMyT6DBbcE+hxIsEcg/ZIO7GsjyccOkMzFzfUu0i200ksfC8HE3o9mRwpz31Qs/3Y2SGUD1EQ2k44uwsN2MDLdOslUyxF3VAex+/3hAqBGExJAZZWeO+WajAV6E5V6uNtpsVo2eZsdk4dfm2cRgGdIc1AVgVSDtzD6wk5XyL4FyX3O52K78vy+10yrHBoUG6adO+HLP23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUH5yPJOzyGcVRMwAN/g6mtZE87dxJNkshIgQkbrXI4=;
 b=d1D/fBgbqql8t/LYfHzPJJEnFSt/7q1dR/Nipm8NIlUjs+6EQ4D2HyR8bcqQcSCK4nMoNZR1UC4/Hsbr4QjOw+TeTbK3M3poT+IEkeJqkOA0nmLbGoYhyXj32Ur2EMZ1tU9Mv0zFdUN37Vt7glIouCLfDXByuBresfqJG9RKd1iXtw0TETWDx+hjwur5kMDG0nc0OZ24aGlyNdogEdZolPfwuSYoHJyba26cTXfykzE/4RG/laUqhvkxCcOojwOTrDUDdgV19ydBNXBW4fjmGYFonXC0rmPRX5Sh/6r0kizdEQgaJDEVOGm7GiGjVMOk75KD5W6t3nJaLkUVaVOoKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by DS2PR03MB8160.namprd03.prod.outlook.com (2603:10b6:8:27d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 06:20:17 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 06:20:16 +0000
Message-ID: <38d05790-eb4a-482a-89ec-8c17cf2e9680@altera.com>
Date: Thu, 17 Jul 2025 11:50:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: stmmac: Set CIC bit only for TX queues
 with COE
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-3-c34092a88a72@altera.com>
 <20250714134012.GN721198@horms.kernel.org>
 <9f4acd69-12ff-4b2f-bb3a-e8d401b23238@altera.com>
 <20250716082209.GH721198@horms.kernel.org>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <20250716082209.GH721198@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::18) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|DS2PR03MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c89833f-4828-4f85-7e1c-08ddc4f9ff3c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzdTVUE0dUpITkVmZ1N2VlpNYldQWUJPVFVKQW9zY2x4c1RzbFVtSm44Vnht?=
 =?utf-8?B?NlZTNVk5Ukh3M0kybFhNeXo0K1poV0c0WVNwRjl4bThiMGhhblhJREFsS0Za?=
 =?utf-8?B?MWpuWExSK1Vlajl0RGFTSitkWll1VXpZM0dQcnpEQzkzZFQ4aTJac3B2SW1R?=
 =?utf-8?B?UkxmZ0NpTm1uTW5wb1ZCdWJmR2gxZUl1TmlZMzJwaExSaTVYVXNsZFoxaGov?=
 =?utf-8?B?bUxkYmx5dHp4V0NwcDFwY3JQRnpYTHJCaEJYUDRVR2JKaEVLcVM0aTFZTjl2?=
 =?utf-8?B?bUZ6L1UyY05pdldOQVE2QVAzRWZJOTgrVy9uNHl2blY5S0UySFZ3VTR0SWta?=
 =?utf-8?B?VzJ0eTR0S2Z3UFlRWXFMR0s1VkNBaVBqRzBScXRPYkRQbVVPUFpUbFlYblNq?=
 =?utf-8?B?THQrL2pjUDZQSW5Pb3RSRWRqNVgxazFKdWZPcThGOXVvL0d3eXN0NDRBb0dx?=
 =?utf-8?B?MXdxUnJqeGpobHVIZkV0TWt0VzVlMEVIcTZmbG1PaHB0eTdkU01Qb1hDUm5K?=
 =?utf-8?B?RDllWStZa1NMS2xWbkxZT0FaVDhLSWZVdW9IZFk3cDYzZkdURVJ0RjVJMVc2?=
 =?utf-8?B?THVCcjY2TTkrZm85dGFoMG14VmUrMjY0MXJhQ2JLMEF6NTJhQmhEVVYxQmFp?=
 =?utf-8?B?V1hvWlp6djZ2dDJ2eTVvNmp5a0pQdGhMMlpWYlJ6ZmFiSFJ6V0ZRN2hSMFhM?=
 =?utf-8?B?RXNIajNqQjMxdCtnZXdXdWhZU3F4VDQ3Mk9FeE13MU9EeEJVRFZmTkc3dTJZ?=
 =?utf-8?B?aWFuTkhldnNKVFljaEEwQ0d5OWtCTzFqdkRSNXJ1eENRQU4wOXg0cVIvMFda?=
 =?utf-8?B?Y2ZlVFJub2JrMzdLUkRvWUJ3bmwzeUl3UmJ4YlhreU1GNGdjSktxcFBMay9B?=
 =?utf-8?B?RWhlTDFzUGdKRDZTYWhqQWkvZ1liRmY5TkY1dVB4cU4rVkhTRnRjTkIxME5v?=
 =?utf-8?B?TlJwbFFIb3haeGlhNzhJZ3dZb21BWDFtS3NKM1E1RFhDbmcydGcyQWg2ako4?=
 =?utf-8?B?dU9INTJ0RjdBUmRSOFV0WnhnNENzamthMFdHdnl6WFlTSFM2bTZSSnN1V3h1?=
 =?utf-8?B?UnNDZXZTRzFVR3ZlMUhOdnh2cnZXMGZBT1A5ZGJ4TXZlQ0lyWWlvTzJLc21J?=
 =?utf-8?B?SEg5RjZjYjl2N0poSysvMjIxa1c3SlRhY1NJWDVyNVRtOVU1aUxIRkswbzZp?=
 =?utf-8?B?TEcyYzh5WDFZRVowOW5QSWs3UUkxekNURkFlVmkyZG1xdCtiNXJqTFN5LzN2?=
 =?utf-8?B?dTN2ZmYxNGlneXhTYjFzUy9tYjJ3ekFKeWxKenRPVktJWStMbk4rT3ZOa0Fw?=
 =?utf-8?B?R1Z0QzlRdnUrbm4wVGxyUUt3eUR4b2dDODJUKzJmelZwaXdKelc0U1ZIQW1I?=
 =?utf-8?B?YWsrVE4rY09uNFFXd1dYSk1TUS9yNWdacXRyM0g5YUdtNktDYk9CYk4wUVZY?=
 =?utf-8?B?WUwveG14bGtaZjg3NnBHRzFhdGZtTUo0UHdRdVdHM1ZHZ2xmVDJTbmxXTTdS?=
 =?utf-8?B?eWhkT1hzQ0paci82WDF4R1pJL2FGbWVuZDhDMW9XdVdJcjlaU0tBTmFvN214?=
 =?utf-8?B?bEd5UlliWjBLbys2UnpLNFdPb2NRRTgvTnN1Z3dldW5IdHVReDRzMm5lUUpX?=
 =?utf-8?B?ejVCYjNLZjRJSmtkOVQvdE5sbEVFdVo5ZmhkNkI4bkRuMFRPaTBYZFdVWGY2?=
 =?utf-8?B?ZFpEaExRN25qNG9obEduQTN4T3VHT2JVQ3JmOXh2NDA0bGdUbEl4WGg5S1ls?=
 =?utf-8?B?dSt6cS84bkhRNGdJREhZbWNXcWR0WWNhNll6cHozcWdyVjA0bHI1V1ZpRWxy?=
 =?utf-8?B?bkRnT3ZybWxLQUtKTlRwaldzVE96eVRsYU1PUXpnSVZab2krY3FSZ0NWYjh5?=
 =?utf-8?B?Z0FKZytFdzVxaXYyM0JjOXZhQ1hrN096WWJqRUtrS3IyRmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDFJRVFTblB5MWQvaDUyRWRwclNTYWp2QU9mRHBKOTlDMUQwYTJCK1RtNDgw?=
 =?utf-8?B?NjZ4RHlYSDNGeHN3Q1A3ejVXdWhDUFlNOUExWXV0bDZPcjA3TTZUamNrTnVF?=
 =?utf-8?B?RDJOWitNalRzQ0oyeDVEenU1SVM4dk1XcWVxMDBkV0tJNnNlUVZDczRMbVlV?=
 =?utf-8?B?K2YxeGZkdWs4WnU1YVJ5eHEyWmJlNHdQamI5dTY3VkJudTN0UkxsYVNXbUll?=
 =?utf-8?B?ZmVLa0JoSHRvM1c1T0xIdjVYWnRhUzhWMU5KV1NidXZjR2pkK3hCK3ltRzNB?=
 =?utf-8?B?NGpMYjhONVpFemlxWCtwWlNqcm96ajBPSGZzMGRVUGlieXdjRlpySERnMVJu?=
 =?utf-8?B?N3RtQU1XcUNHWUNLRmVtU25rL3VBd1pEdU9yR29MQWl0bnhCTHQ0b0gyTEMx?=
 =?utf-8?B?cWcxVXNrMjNmdXA4UWVxandoMC9YRlpBdUdUcGVCUURZbTFIRDB2bXVEVUhv?=
 =?utf-8?B?S2hnRmQrRWhZSi9EOWtPRVQ0U3hpYVdQdmlzb3NGS3ZPdXlrZHhpVEJzZTFw?=
 =?utf-8?B?aXQ1aWt3S0JKZW9rVktHcFRiYjMzT3JLY3orWndRSVo2Rit3ZXMxVmdTazV1?=
 =?utf-8?B?ZlI1ZGJ3MEdML1RsQzFOT0FRbjFBMlRVRXZONnJpNlRCTkVPZFdmR3E5aDEy?=
 =?utf-8?B?NDVPa28veVZIbTkyc2YzcklVaVc2YVlaNFJWWXh5OS9PczVuUFIzQkdwREN6?=
 =?utf-8?B?cGdDbXZpUUQyNmdFZUtZSjNpUHJzQTZ6STR2bTJjR2MzM25rRllKRlZFclYv?=
 =?utf-8?B?clVFR1ZzMVRpZGprQnBSUGpvcnBYamxUdS9zdWR2WnJrb3dKTU9EajBlQ1dj?=
 =?utf-8?B?SEE2dHVJSVJFc0RSVmxqc0J6MzI5YjI0NitjeG4ycnFuT2V5ek9YM2UwenhM?=
 =?utf-8?B?OUphS3JBTitFNmxCelVhZUtiNzFnZ2xHTCtXRmNOVlEwbFNPSUV2NkduaC9X?=
 =?utf-8?B?UEZPckI2UHNWSTJHZmVUS1VHc3pFRnRXTDlCQmU5bkR5bGNHWTUxNEtnZkps?=
 =?utf-8?B?M2k2LzlzNVVRVnhyTnhJM2dKdmJmeVlNb0xkV3YyR2EwWSszRU5JSUpsTk81?=
 =?utf-8?B?OFJPRGNuMG8rcWZZblhEL01EOEVvUERRakJmQUQvNlUwUG51b0ZMQkRsVjdD?=
 =?utf-8?B?TjAwbzJhSEtWU3MwUFBSY1dlNm1CQWMveUsxanlXd0NiZ3ptUzZzWlAvSEx1?=
 =?utf-8?B?ZStSU0FhK1E4RmZkcWF5bFBVYWZBUmNmSXRvUTF4L2JxQm16QlhBWWFyYXJU?=
 =?utf-8?B?c0svWkJtOEtwY3F4M3orSW9XQ3ZhWHNPMTZlNU94Tm9CT1pHckkvclMrREtU?=
 =?utf-8?B?dWV0RC9QN25tMGlWZE5aMjZ2OFZGdW1IR3phN2dMYXlXWGs1aUdSenNXVU1J?=
 =?utf-8?B?ZGwrYjhNZmFqZU96cDFsWjg4aTFZOEZKT25kQkZhTnNzaXE0U0hNa2NKUTdV?=
 =?utf-8?B?TWFEM1ZTNmpkWldUVHBtdTJyZXRrZ01qRHIzbTRNVFp6NTRLWHF1NTA2WDN5?=
 =?utf-8?B?VGFXbTkyK0tseDl0U3RFUzdvNCtGSjVGaGJrKy9HaWN5ZjNLWm5XSmdVclQr?=
 =?utf-8?B?dHY4YjRSakpjZzZ3ZThPZmx3TnZVdGtQcm43ZGI2eGp6c1VBa0FPbmhqS1lJ?=
 =?utf-8?B?Q2RhVTlUY3BtRkI5RHlVa2hSOVJvTDRBQ0xqaHhrSkpVeWlqaHphRWk1VUJt?=
 =?utf-8?B?ZTc4NVlqY1I5emN6MnVJQzhHUysxMUdxWWNOWkZkaUx0YkY5VkgxL1RGY2k3?=
 =?utf-8?B?V3E5UGs4QnBSbGlPbkdFUVRzTWRYVjc0OWpYc0hhakNqWTBuMW8zR3Riclhk?=
 =?utf-8?B?eVo1TjVNOXlrQnlsYnVLRHN0QUZnd0RQTkMzQ01YUDRBc1RGaW4zWUVHdisz?=
 =?utf-8?B?WDZLMnZtWXEwcHZxdmdybGpCcTNxVXhOVEd5WnhkS3NkTGpwQ3BZN3V2MzhW?=
 =?utf-8?B?OC9yLy9PWS80YVM5c2UyUWd2eXQrTkdIbWVVUXQ5RU8zVmNaaEM4ckpkMjdZ?=
 =?utf-8?B?WG9JdmY1aEFMallleUNBM2UweE50R2FENFFBUElRZE5vVzMrczhBbWJPWXFI?=
 =?utf-8?B?ckhQSWExYmg5K3pFZWVjMWNBbU1hbklER29aK05nRVF0bDNndjRiejhpYXhM?=
 =?utf-8?B?eGlYOGJwdEVuWGIvTmZGS0o0WTVORjZ3akhXNjlFZEVSN2NBYnpLWi9qbHBS?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c89833f-4828-4f85-7e1c-08ddc4f9ff3c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:20:16.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bx61vz0cvfrB+rQ24xrk56jh0GeYWjvGq6t7ZIFeIfWCNgsXuDrv9d6Ehj53fhVVQSoxCGZa9C/dRE7VmTcBepEZJOm5OiYth4F4ezFgXyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8160

Hi Simon,

On 7/16/2025 1:52 PM, Simon Horman wrote:
> On Tue, Jul 15, 2025 at 07:14:21PM +0530, G Thomas, Rohan wrote:
>> Hi Simon,
>>
>> Thanks for reviewing the patch.
>>
>> On 7/14/2025 7:10 PM, Simon Horman wrote:
>>> On Mon, Jul 14, 2025 at 03:59:19PM +0800, Rohan G Thomas via B4 Relay wrote:
>>>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>>>
>>>> Currently, in the AF_XDP transmit paths, the CIC bit of
>>>> TX Desc3 is set for all packets. Setting this bit for
>>>> packets transmitting through queues that don't support
>>>> checksum offloading causes the TX DMA to get stuck after
>>>> transmitting some packets. This patch ensures the CIC bit
>>>> of TX Desc3 is set only if the TX queue supports checksum
>>>> offloading.
>>>>
>>>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
>>>> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
>>>
>>> Hi Rohan,
>>>
>>> I notice that stmmac_xmit() handles a few other cases where
>>> checksum offload should not be requested via stmmac_prepare_tx_desc:
>>>
>>>           csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
>>>           /* DWMAC IPs can be synthesized to support tx coe only for a few tx
>>>            * queues. In that case, checksum offloading for those queues that don't
>>>            * support tx coe needs to fallback to software checksum calculation.
>>>            *
>>>            * Packets that won't trigger the COE e.g. most DSA-tagged packets will
>>>            * also have to be checksummed in software.
>>>            */
>>>           if (csum_insertion &&
>>>               (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
>>>                !stmmac_has_ip_ethertype(skb))) {
>>>                   if (unlikely(skb_checksum_help(skb)))
>>>                           goto dma_map_err;
>>>                   csum_insertion = !csum_insertion;
>>>           }
>>>
>>> Do we need to care about them in stmmac_xdp_xmit_zc()
>>> and stmmac_xdp_xmit_xdpf() too?
>>
>> This patch only addresses avoiding the TX DMA hang by ensuring the CIC
>> bit is only set when the queue supports checksum offload. For DSA tagged
>> packets checksum offloading is not supported by the DWMAC IPs but no TX
>> DMA hang. AFAIK, currently AF_XDP paths don't have equivalent handling
>> like skb_checksum_help(), since they operate on xdp buffers. So this
>> patch doesn't attempt to implement a sw fallback but just avoids DMA
>> stall.
> 
> Ok, fair enough.
> 
> As per Andrew's advice elsewhere in this thread.
> This patch also looks like it should be a fix for net,
> and should have a Fixes tag.

Thanks for your comments.

You're right—this patch is a fix for the TX DMA hang issue caused by
setting the CIC bit on queues that don't support checksum offload. But
I couldn’t pinpoint a specific commit that introduced this behavior in
the AF_XDP path. Initially, there was no support for DWMAC IPs with COE
enabled only on specific queues, even though there can be IPs with such
configuration. Commit 8452a05b2c63 ("net: stmmac: Tx coe sw fallback")
added software fallback support for the AF_PACKET path. But the AF_XDP
path has always enabled COE unconditionally even before that. So, do you
think referencing the commit 8452a05b2c63 in the Fixes tag is
appropriate and sufficient?

Best Regards,
Rohan


