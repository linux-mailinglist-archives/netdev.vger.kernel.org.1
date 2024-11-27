Return-Path: <netdev+bounces-147620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E499DABD7
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 17:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C21B20430
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAB420012C;
	Wed, 27 Nov 2024 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WBO7QYBG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E11FF61F;
	Wed, 27 Nov 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725176; cv=fail; b=ELztpnpvtzSlUZxnar4EPdcWLL0l9yGGQI+vJAANoKcvFFes6NOgIduzAaKBW3A/E9gp9Gd8gANdB86Jr8bupgGj6LZlu4hOl3/ykcBde5+IFvZt0A7S1C4XY+LYlwlniaeLpj0bCVIuBL+vBgPy7uUyXeJMdowGG3tIx8fl+lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725176; c=relaxed/simple;
	bh=nqQJ7++1LrfDHaYBtaKIPAzJaV1rMUlJayQNo8FMw2o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B9w/Y4CoXxjago26stqkapADByXeXVV1xmTpBOImLxJRf8p5pUoNxXrrJxNl1IZnYjqmun/LsvtV2UupmMZVqQ0SlLYccvXNr4QloZ9agW+ukt54uTWAAbb/KmfScHuOdHbxOWQrsANugPDWlzchlbZumzevV5qJl8N2+ov0hoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WBO7QYBG; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C86v35zo0IeuLHcRTh/y7bMj/0+qJla4i9DF+roWx7MyP3CVTFPJM1LVXYnoeres/VXeHmFsPg157QTBNCpkGLM2NhrlAYe1MfWQt1kUtGMmEVOj9DE5bEfMNccoQBRXobPYrKsiWw9hXsL9ymCdSfF+pCqZXG9N1P2uzha/vXXRZKlOwinHPERqSjqK5AbWDcjDM49CKyB66IjdaYRhRUhULimPH7BnWFpQM8Mx3awkk2drc3chDvAHR6OPk9sTxPYllFtgH6LhG+77sCeB/cPgMTjjDHlaVuWFjh83g+Klun8+nUEPGeUO6Y1pWZPG1hyv5I1DJjRffxRASiVzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEBwajiJ/gEXaZinh+sPKvl+k5KydJFgRqP0F5avNeA=;
 b=KB5KKOQksjeSURGsdCHTKcYSEjrutcdgaTe6XYH1sAQ7RH3Wg9QLG/P5RtoxzpYLz4KOxhTMqHuU5k5PyRrP1sZqRe6ebdqu6+1I9hH+jZ+LmYmGGFHlYlLdX8DGGsP7tfbGcgWiMbIW9m2kka24qBM+BUDDwu97O/D1c5pYu9Ko5v0/xda71Qc6a4ksYuczgu3s/P7dMo8pmrWhlm5bmTkAXP4ofupCRS5oI1e+1mSyWSGovshqPx4sBJDBFaS9TdB79E7yMO+ind+4E9cLOzF4sziVx62Kq1Bmue/JudMqvwM86bQ1WK2MTd/7FE/sCpzpSZeKqciTw/gN6Ke0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEBwajiJ/gEXaZinh+sPKvl+k5KydJFgRqP0F5avNeA=;
 b=WBO7QYBGNlrz5s04OLfuo/j71K+tbx84GABQgGrGlOwc75X8ajHZjWYsMfDHOkjE+TnA6J4vZSM0VHUQxfmh2bmcM9Vy7u29nquzqGTFy/knxdJqN7QCTrt2Jyp1kWom+PrOZ1DJLYs5kL02HTbVTWHyaOaC3iDyI36OFa2EjP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 16:32:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 16:32:46 +0000
Message-ID: <b6f68d11-6578-713b-1581-29e98ef39c8f@amd.com>
Date: Wed, 27 Nov 2024 16:32:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 15/27] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-16-alejandro.lucero-palau@amd.com>
 <270c4969-6f1c-4dc3-85e8-fd03fe2b1dd9@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <270c4969-6f1c-4dc3-85e8-fd03fe2b1dd9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0196.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:237::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 78151038-3016-455a-9733-08dd0f01203f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWJ2MWVrRlRldTBHcWE4cnVINVlDTzBGNWNZRWNkb21HVjhVQVFYWEZwMy9M?=
 =?utf-8?B?d1BwaDE2dHd6TE9Bb1NibGtLaVZFbkRPK2hDc0x6YTJIUXRnUWtML050ZnJj?=
 =?utf-8?B?L1pnbU1uTjlQZVRIdTNsZ3JsdHdoSFU1MjdPT2FvakNnVDZPaFFYMUpadktS?=
 =?utf-8?B?R056VGorTUxqQi9lM0FubTJiK05WWFlMN1VPeElOR0hIOER4ejhKYUhsbHJZ?=
 =?utf-8?B?cVJnL3dnVTI1SmNmeGxTYnArbU05MUp4RW4rVTU3dld5cWg0Q1FyUDZxVTRP?=
 =?utf-8?B?SFhCbjd5dGlpVmtwSXF2SnVPUWNjcVAwc1A2dHJuajY3SFp3dHZVUno0bjVp?=
 =?utf-8?B?TmVrRnd2c1JyR1BCcWttZFRhRlZQNHpndzVuSytWOTd6am83TXZ3SG4wNlhV?=
 =?utf-8?B?TlF1dVN2Sjc3Zkxwb2JqU2l2ZS8xTnVveEVxQTdRSE5wSG1XSU5JeEpGNFFn?=
 =?utf-8?B?eW5hcmovMFJId3orYW5oNUdvVlBFamtXMURZOVdsY3RuSGhNdTlZcmlJb3No?=
 =?utf-8?B?ZTVVeGRKVzQ2eElXcngzTUlJUGw4ZHdoamhkb2N2U3JjR3d6bkVpRFlPMVQv?=
 =?utf-8?B?Y1hPakQwazE4ck9PNWFsQ0s1QUo3SHB4Vm5kV25NS2tSbjZ4SDZ6SnJQU2hU?=
 =?utf-8?B?YkZoNkR4TjBZR2RzdWxKT29xbzdkandQYlc5ZTU2bW9kTUJOSTNlWnVVeUFF?=
 =?utf-8?B?TEYxU0tBTGFjVUZWV2MydTFIOUNOS3ozcWdQOUFsZXJjYnNTOGlzdTlicm0z?=
 =?utf-8?B?MlNDdnk0blZaaEh0U2Z3dUhQNnFTOE1ZSU5uUkMyUkEvSFYzKzJYTGd1RDRI?=
 =?utf-8?B?dExRM3VlOFBRQ0tBaGVEZnA4Q3FIT1BOc3hhNzl5MXNmUUhaVU9sZTVRWHRY?=
 =?utf-8?B?b0xZdlhYbkhpYnBOSm5xaFhEWTFURTIybmtUamF0ME1UNEVkaG5IWThEa2xN?=
 =?utf-8?B?S0xoWDkySzdqNmtQaWk1STl4Vm1XRWNtVE5adGc0NWJzb3hlQnVVYUc5Q1FF?=
 =?utf-8?B?eTJOaGdodU0yUVEyWkRZODZDZEZyZjFjdkdOVXNsRUc1S3V2YXRtSFZubnYv?=
 =?utf-8?B?Z1haWU80UWhYZlR4emFIaG03VXRqWkp3Zk1NVzhnelFiYVY3NXBqTXhhYzFE?=
 =?utf-8?B?ZFMzcGF4MU5udlMza29xaXhXQnA2UUFJdzZTLzRwZkNrRUJuUXJ5UE5rbkpZ?=
 =?utf-8?B?am5kSnJaRkNrTWR3QXR6cytOVnYzMm1xSzhMZlVBbjhlYm1FVWUrZVR3T2py?=
 =?utf-8?B?KzZrV1g1a2ZuVUJKQXFiRis5YlFUaHlISmltNktDSTNrUFR2OWp3ZklnMisv?=
 =?utf-8?B?V1drOWUxRFZJWGthUTB6RWlMUUZqVTBWRncyNVByYnBkcFVOeU5jbE0yWHk4?=
 =?utf-8?B?ckxZZlp5TCt2MXNpc0lHa3lVaW1zOGpRVkljVnlJWEFyMUhVNlFZdUsvNlBH?=
 =?utf-8?B?OEszbnRRSklZWVV2Rm9UK29IdStCMTZLNnVmT3pHMEFBRitwQlYxRUltZnV6?=
 =?utf-8?B?dDUva0RDVmhEdTRSNzFLSGVuVGE1NDJadVduTDh1Y2tGMDRpUnJQQ1VSWmV6?=
 =?utf-8?B?MUpWbjVuVWx6WEpxZmFKOTlkdnJNblRHeFlPY3dxRG9wRlB6RkYvaWsvc1pi?=
 =?utf-8?B?R3E3bGdKdnUwTXREbXV4UndmdHVuTGhBYkRiajMwSEU0SERXSC9OZ3A2YzBX?=
 =?utf-8?B?aTJXUkZnS21GdWhIVUlEMVZDbVlsRTY4SVQrb1NsZHIxZGFxTEZ2MXdSa0dy?=
 =?utf-8?B?YUFoUGg5dkllK1pXSzg1dkZpWStxSVpsaEoxMENrVS83Q2t3d0hkK3d4UE9J?=
 =?utf-8?Q?0JKgVNmqpNRu5zko/0q/ZJ76ushhwtoJQ9r0c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ukw0aWhsQVNjSm83RzhvTHgvbHVqMTZGQlhqL0xuN2tzTXQ0SUR2L0ZlSFl0?=
 =?utf-8?B?a2luRDRIVURjVWlrajRFY09vN0ZaYWVlOGx4bjJBSDJBMWNMcUlqMGxtQyt2?=
 =?utf-8?B?SE5ia3JycnloVkczWmF5aGgyTGp5d0hRS1FaZnlrSmR1QkVQZVJLZ01JNlN4?=
 =?utf-8?B?VlNPZzBUSms2cDlCc3NCMzdzaktlNGxFQTUyRjJyNEJoLzhsbEJ0cC9lMGRu?=
 =?utf-8?B?cEVqMTZzcWVVMVZ5TDlQRisySzlwcW9IWEIyek5WekFiWHpJY1E3eDFMRW9R?=
 =?utf-8?B?eFRaMlVjSGJHU3dIS2pRWDh3RFhIU01GcjJPcDY2ekxEUitVRjRDSEY2azgz?=
 =?utf-8?B?ZmlwUkxNT0xuanowT2F1Mk5JVk9ycklxWE83NTlGSUlDUU9oeW9abXpSdkhI?=
 =?utf-8?B?UDZoc2lBY3c3Qm9ad0U4RWNnNXE2SDZTVkZ6SXdOemY2clhtcE1MK2xuK0Qy?=
 =?utf-8?B?cmZvQlpZaExCYWtlUnB6UWJsN2FCeTgrUko5U0tLa1czVjh1SnZYQlNRWmRX?=
 =?utf-8?B?Q0REd01WMFRJbWhCM2I1Z0ZCb2xCdmhTZmJuTURkSWt2R2Npc2ZRL0V2Skpz?=
 =?utf-8?B?SmpGSzlwNVNld2JSOFQ3L1lmc21WbHAwZkJ0SVhYZUhjNXp5SW83QXp0Smc2?=
 =?utf-8?B?bWs4RVdVc0FHNXE1TDA1eCtiaGtiNkRWMGlKYkZDYWtFQnlUdHRBcUxVNXpv?=
 =?utf-8?B?eHVaWStLOS92RHB3S2V3WkNUVlE1UlNEOWN5NERCSXFiZWJ0czJJb3ByY3U1?=
 =?utf-8?B?Y3NlQlhrenVuTDd6a3hEcUFJYnBGQ1RhRzlJaElrY2VwK3h2SWZMOTM1dVd5?=
 =?utf-8?B?QktUbm9JcG1jWEo5VlBGclNQcEpLTkxlODVvWWM2amxERjJHamhBYms2dUk0?=
 =?utf-8?B?cXhCT3VxdWNIZjEzeVJIN1Frdk52YmtIWWZrL1NneEdrSGJ2dGljVHkyYWJq?=
 =?utf-8?B?MDBDcTJuTFU4czJRb2xlUVZXbCt6dkdjL1BqR0Z6eDRMTFBSRmRZV256SE8z?=
 =?utf-8?B?MDAvN1lKaHloWGtGdnNSbU8vYW1TTWtLS3B1Q0VWb0J3VlhQUFF4dE9qZXda?=
 =?utf-8?B?REFxRURBQjdFdmdOYkZqWkJnQUN1YUJHdHNha0tOWnE5R040a0FUL3JRcjZ3?=
 =?utf-8?B?Mm05Y2F1TkFWUGtmNzc1ZUNXd2pQQTMzanBLclVkbXNKL0hyTDE4cmlwZ0lP?=
 =?utf-8?B?T3Ribk43ODdLOE45NGVYTzEwMWNWWlNWMTRWRmQ1cEFVNHM3c3YrZGpRV2ht?=
 =?utf-8?B?eXFtQW1UUGpyUXE4dStZWTV0UlB2K3U2SXlwVjBhNXNsenZla0tETW8vWXEz?=
 =?utf-8?B?V3ZmRnRFM3krSlNOS2lFaHZLM0JkSlVYa0FkQ2c1VnVkNldJZjFCZHhFd2Ir?=
 =?utf-8?B?NXJRNEZ0LytIaGNGc011cHNRQ2RJUGxFc2poOTA2eXRhazNlV1hidHVYRFlX?=
 =?utf-8?B?Uld2aWQ1czJWb0V3RkdGenZmdTZFbmQwMEt6M3doWkwwU2VhRmJYZFlwVndD?=
 =?utf-8?B?azR2SnprdEk4cDNIZXJYY2tvbUp1YnFyNmZOSytHd0hpK1NQK2pGdE53czRk?=
 =?utf-8?B?RmlPdllrNE5wNjdGK3ZyUXNPQ3FlSENBKzJ4bzQ4YThDVGtPYlFKaGdRTVdv?=
 =?utf-8?B?ejNoWEsremdxcWU0YlhEYTk2SDB0WTNvRTRLV0pyTkxkak5vTTl0YlRhU0dk?=
 =?utf-8?B?NFplMEpKYkVRRFRCVE9aUHMxdmt6OUlzQ25xNk9RWm9jOVNmSjUyWkJwSUlp?=
 =?utf-8?B?UzExbkQvV2E2VG9LQkU3cTVZR1VOVk02QytndUJuT0ZLaG96dmEyYmkwTGxP?=
 =?utf-8?B?eFBzblpsWUNHRFM3OS96WnMvblNZR05ZdjFPMWNreTNuRzBaTUt4d09WcnQ2?=
 =?utf-8?B?MTg4Vng1eDF1Z0FnSGlTcHZkelRrK3djck1IRG91NEc2R1V1SGkvbzVSUHR4?=
 =?utf-8?B?MkNrTXJYcmNFZU1PdFZpNmhmNTI0RXlUaS9DNWlOR254c3F6QkRNT3laT2Yz?=
 =?utf-8?B?YmNIRlc4aHVBSURQT1R1SzhsSlUyY3Y2MXNrOVhxNGpJb25ldExYandsaUIw?=
 =?utf-8?B?MWRXTmRhaUNGWDNNZGxnQWRibkZyYytlaGFuU0JMWDBFN3o2RGJwT2w0RjNM?=
 =?utf-8?Q?vZWFOIngQn9CM/74t7bUOcbA3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78151038-3016-455a-9733-08dd0f01203f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 16:32:46.9153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjFyTpdi10KuAfb2mQKtf25GIi2XCHsbpTbAHRSDchP3p9k/cTbZGv8CS46cERbDrKo2cRH0tfGLg21vpUK/mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370


On 11/22/24 20:45, Ben Cheatham wrote:
> On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is create equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> Wrap all of those concerns into an API that retrieves a root decoder
>> (platform CXL window) that fits the specified constraints and the
>> capacity available for a new region.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/region.c | 141 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |   8 +++
>>   3 files changed, 152 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 622e3bb2e04b..d107cc1b4350 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -687,6 +687,147 @@ static int free_hpa(struct cxl_region *cxlr)
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
>> +	/* An accelerator can not be part of an interleaved HPA range. */
> Someone else can weigh in on this, but I would also specify that this is a kernel/driver restriction,
> not a spec one.
>

Right. This was suggested for simplifying the code with the 
current/expected devices, and I bet we will not see such a case for a 
good number of years, but I agree to add that comment.


>> +	if (cxld->interleave_ways != 1) {
>> +		dev_dbg(dev, "%s, interleave_ways not matching\n", __func__);
>> +		return 0;
>> +	}
>> +
>> +	guard(rwsem_read)(&cxl_region_rwsem);
>> +	if (ctx->host_bridge != cxlsd->target[0]->dport_dev) {
>> +		dev_dbg(dev, "%s, host bridge does not match\n", __func__);
>> +		return 0;
>> +	}
> Is this check necessary? I would imagine that there can only be a single
> host bridge above our endpoint since there's also no interleaving?


I guess this is a sanity check. The two variables are given by the 
caller, and there exists the possibility of giving the wrong one for any 
of them. So I think it is a good idea to keep it.


>> +
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_region_rwsem);
>> +	max = 0;
>> +	res = cxlrd->res->child;
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
>> +		resource_size_t free = 0;
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
>> +	dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
>> +		__func__, &max);
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(CXLRD_DEV(ctx->cxlrd));
>> +		get_device(CXLRD_DEV(cxlrd));
>> +		ctx->cxlrd = cxlrd;
>> +		ctx->max_hpa = max;
>> +		dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
>> +			__func__, &max);
>> +	}
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @endpoint: an endpoint that is mapped by the returned decoder
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
>> + * @max_avail_contig: output parameter of max contiguous bytes available in the
>> + *		      returned decoder
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available (@max)'
> The (@max) part should be (@max_avail_contig), no?


Right. I'll fix it.


>> + * is a point in time snapshot. If by the time the caller goes to use this root
>> + * decoder's capacity the capacity is reduced then caller needs to loop and
>> + * retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
>> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
>> + * does not race.
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       unsigned long flags,
>> +					       resource_size_t *max_avail_contig)
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
> This message makes it seem like there's a problem with the endpoint, not the hierarchy (at least to me).
> Maybe something like "can't find root port associated with endpoint" or "can't find root port above endpoint" instead?


Well, there is a problem for sure, but I can not see why your suggestion 
improves things here. It is not easy to really know what is the problem 
without a real case triggering it, so IMO blaming one or another is a 
blind choice by now.


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
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
>> +
>>   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>>   			  const char *buf, size_t len)
>>   {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index e5f918be6fe4..1e0e797b9303 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -776,6 +776,9 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>   struct cxl_decoder *to_cxl_decoder(struct device *dev);
>>   struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>> +
>> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
>> +
>>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>>   bool is_root_decoder(struct device *dev);
>>   bool is_switch_decoder(struct device *dev);
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 5608ed0f5f15..4508b5c186e8 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -7,6 +7,10 @@
>>   #include <linux/ioport.h>
>>   #include <linux/pci.h>
>>   
>> +#define CXL_DECODER_F_RAM   BIT(0)
>> +#define CXL_DECODER_F_PMEM  BIT(1)
>> +#define CXL_DECODER_F_TYPE2 BIT(2)
>> +
>>   enum cxl_resource {
>>   	CXL_RES_DPA,
>>   	CXL_RES_RAM,
>> @@ -59,4 +63,8 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   				       struct cxl_dev_state *cxlds);
>> +struct cxl_port;
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       unsigned long flags,
>> +					       resource_size_t *max);
>>   #endif

