Return-Path: <netdev+bounces-154356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F509FD2FF
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 11:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90777188383D
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 10:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78E51DD0FE;
	Fri, 27 Dec 2024 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZTPhAZIF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241B1146A79;
	Fri, 27 Dec 2024 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735295279; cv=fail; b=ZsuMUqJrbxw5QGsNs+91gvkgi6kSV0DIHU54aYzrXpeCjHBbSyzH2JYMSezQsXoHHN8W5QhtzNSAwweeL9e/HDqVNO6gAOR2lt82Go1cAuCwMd2QXElgoCqKoMUDIzsMv1Tcl3zEL/u9HB+c2Bs5qltU3cP2nk6eo+rrB+2fZcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735295279; c=relaxed/simple;
	bh=G5nwrxwmnnhQoRmNSyiRgakoqSMdF13uGfOFwc2c/AU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FQQ11Ju7TaIkQEgtZ+sZTeEfD1ruk4d9Rr7sfgeOrGk6HixZCXYTKYVA+BtGaPfZKBVFBOxnpAyZIpGHEKUJ5ItLC2iaQZPV8nVUuqpwMMJXSaimk9tJUOu4uEYn67K01/yTqqZ+Tc9m0L289aaOtqTi6nJjQKhZd1gYqxjlj40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZTPhAZIF; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhMDDqviWsyn2SOhAIqpyoTNyeQ7Zi/N2TKL0sewR1N3drdkVo+G6/5CW+GZwo0i1tmrqFebFNbYGLGvQjd17H3g/lIkomuGl4q0xVphQGnrBErsRfR1TV74yAiOun1rB719H96e33/7pDO7mAszRck9aiNk/pLxDGLjlGvjCYudok+JO61hzCzi19iSoHhXtXIiEguq4g6+XGaa0YrpCv3SH4BJxVcwkQBcrP51MQgHmr2acJDw6zGdp7Z+7o+BqfNd87Ggtc71cn1lQXdz0FKXGmb3Eu4d0IASe0pDxx8DipYzsmxgzOdhPsSvCb2wxLB5UAedJJhtU5JN/w/EGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2ahA/kXCCRjk2/jfnycO4IEjRml+5axvuF3ggqPs3M=;
 b=GLMdhzlaYJRMr3ZBE8VlZXohItpW4SaeGI8qh1AAV1S9nMbbHadAUXT6luACywLxKl/1ZHv4je+N/67iy/TmEYDSLiDONaB2V1Lt8sFMZ+PIBk89kQFTmh52SnGUdf7X+EwvnD7734A9XNVRmgDvKGm7xBfuRRBONJ/2vPWRBRfcVvvYa3aKyGkEKOdxYuIgwRxbmSTjys1rbidJtHQ81R90H1oUPgIXT3GnXa5uutfkbUtAeIk8bvsDwNy8b+cQtezCIf+boT+PGuASIlmQYn+VnSs976BAhDHIB1601DqJq4lklpdprumbTbZtQyHQPTI7RefEFk9caYqlM87Ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2ahA/kXCCRjk2/jfnycO4IEjRml+5axvuF3ggqPs3M=;
 b=ZTPhAZIFhKafIU9Z9yD2yeGMvXfQUEfn73wRXtkfxydv3GS8yIwWtwBrITMv075w6FKBGGhyKAQsraVfniCBGx2ImZuLkCtBUNlmJOX39puEepJpufi3gpM/7hKYJWzwXeMWZwPetw9j5T2c5/TbxXHYka2WKRv5ydMQfmwJx1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.17; Fri, 27 Dec
 2024 10:27:51 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 10:27:51 +0000
Message-ID: <18c32704-5521-ef30-6186-0b189d0e8117@amd.com>
Date: Fri, 27 Dec 2024 10:27:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 22/27] cxl: allow region creation by type2 drivers
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-23-alejandro.lucero-palau@amd.com>
 <20241224180135.0000159b@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241224180135.0000159b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0126.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 0918a379-f266-42d7-e8d4-08dd26611de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFBJam84RGpIeVhUSGJIRGl6MW1KR1VmLzlPeVpNa0gvc3hmOWkxOFc3M09D?=
 =?utf-8?B?ckV6REl5UG40SVpYYWpOdjJvaTNGQUhvbDdzOVZaaUFGanBMSlg1ZmxLaGxS?=
 =?utf-8?B?Y1gzQVJtWlNEcVJhQTAzQVMxMnlLWkNOc0s1ZUl2UFZ3ekRGQmNvZnhUaDhW?=
 =?utf-8?B?dzdGTEJBQktZZnpVcG9MdVhKdXFVOTRtOWFjOFdkS1pHZ0grZCtxYVdmREpN?=
 =?utf-8?B?QVh1dkpQTzBTRkZYMzBrTTE4Y3J4Q1FyblJqZ3NSQS96R1ZTVXpwc1ZrTk9T?=
 =?utf-8?B?eGRwVktYbE1Wa0E4bmJMdk9KVXdibkI0VTFyRWVuTUphSjZpOXdmdCtURWhH?=
 =?utf-8?B?Y3owOXJxcmJhK2E1d0FDVkFpMTV3Tkdqa1NlZ3lOcWZjdW85bm1yRkJZOWZU?=
 =?utf-8?B?cGNkUytJUWdlYmFjMUZUaWZNUDdyZ2xDOHdYcy9ET3ExREtlK1dJNGthUnpa?=
 =?utf-8?B?Ty83WjN6TVdrdHpCSVFyY1YwWU1CYVd6RFUza3FFOTdaRC9Ia0pkcTkxK2Z4?=
 =?utf-8?B?Y3p1RDEyaDZWd25MK01JOHR6TTFzeWJZZm1wZXJpV2tGdmNuOXNxNTNmaThm?=
 =?utf-8?B?SDBZT28rRjZmNEJCVTNNN3hCZktYSk9YVTFKZkFhRWI4cm01QlNJMWtQSGg2?=
 =?utf-8?B?c1VFcDYwRjUzRU96L3dWc1JVdzZ3Ulg3dXhpdEl4NDZjVlNiRDRuYitEWWw3?=
 =?utf-8?B?N2JKMFRsVC9QWDd0bG9Eb3o5c3l0bklpcHRKbkp0aUxQREYraUJIYzNadGEr?=
 =?utf-8?B?T1dDT0o3dm1kMWNtRzdKSHRxUGpKZWNDZUJsVENybEtkVzBsZEhMM2Jlb3RP?=
 =?utf-8?B?V3A4YlBKazhxRkovL1FodWR4ZjlzZDZZMTVZV0ZUWTVCL1hMYTdzcVgvUUtW?=
 =?utf-8?B?T3BHWTF5UmZ1S3NtSHNQVEJBVTBDV0hDUEU2elBIY3V1ck5KVDZIK1psd3lR?=
 =?utf-8?B?VG1FSWE3Mm0yNEVnYVNnQUZ4S2VNWmQxSVh1Um1Ja3pUcDlodDdPYzM5TzAr?=
 =?utf-8?B?NFUzd0V1TVlvT0liSzhVbk1yOWFEeFE5Vy9rZElRbVBzNlVnRGhnOVJ3aXB6?=
 =?utf-8?B?Y2o2bXBkelRtVklnMlRnL05BMUZiMWpvVmttblBIY1E2dUJOQWNhNnQzeDB3?=
 =?utf-8?B?YkxuQm9jQ1NtQlVseU1YRFVvVUUzSSs2UXR1Vys5OFNDRW5KdkoveGo5VXNE?=
 =?utf-8?B?dmVQbE5pZC9OemRPSDNXNTF0eHM1aUd3SHpGdnpINlBTUkJzckxiUVJLcytn?=
 =?utf-8?B?UUcxK3lVVUMwcUNqNUIzaWRIUDFQMWZjMjNVN1o3VGxUL2VHa1pHRnJVWEho?=
 =?utf-8?B?cStYbGRNenk2U2pCcEJwOWtnbnNmWC9KUEtWalp4ZS9VZGRMVi9wd2lPTGFs?=
 =?utf-8?B?SktLeTF5ZkxqUmJMYlgvY2VOZCtiSlNtSTlFamJ4am1Sa05TT2pyc1BFNjNt?=
 =?utf-8?B?VmFLU0RicEdCd08xcGxQc05qMnZjVVplUGY0M0g3aVA0OTRzRmVUb1RNdkJp?=
 =?utf-8?B?SEdJK3pCZTRtMEdOZ2QrVzlSWnl3TmhEVGlnbndLZzhHTGZVVEhyWWhQckxj?=
 =?utf-8?B?am53UFRaSkRPUnpLUmxqVGpuaTV1SkhocHhSNVJXZ2tiQktRL240aE9JcWhO?=
 =?utf-8?B?M3hTWnNLY1BKQXRXU1YycGtWSm5pZWwyd2g3QWJJVk4zdGRsTlVPV0pnV1Za?=
 =?utf-8?B?REFpUU1LWVQ1dUpnYzFhMFJuSzNsUCsrVlF0R1hXU0tMWlMzOW54YkZ2UUdn?=
 =?utf-8?B?S2pDeW1LOVBCMzY4ZGhzL1ZaU3BhTTMwcUY4bW5FelNPWGMzellhRHFlSjhu?=
 =?utf-8?B?RldLeXgyWmlFZU5JaVc4dHBJeHVWd2xXem9wVVoxOXNYTGxiR3FOSmNuMy9R?=
 =?utf-8?Q?g54g7y0thGiGP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXlNY3ZvRDNBbHYrZTVrSms2K0tjRzhWemZ6dVZndjVGM3JLaWZTaW10THdE?=
 =?utf-8?B?VjA3eUtmVWhVVDdqT2Y3RVBDdU1tL0Z3UlU1c3dNc1ZIUHZmNFZDQ2pnSFBx?=
 =?utf-8?B?WVdET2ZnRkt4clRtTTVaSzlQbnRUekFqMk8yODVZcXFPcTJhUmZlKzB0blZa?=
 =?utf-8?B?SUdvTGtSNTIwdUo5dHNGUVZQbEtLalNhM3NQbC9mUXBBbFlsV1k0bDF2czhH?=
 =?utf-8?B?cWxaa2oxajNyMWJ1TFpTK2dsSXI3MG42L09odXdNTGlXK1lOWVBRODlsKzNj?=
 =?utf-8?B?VlVSUXpkRC9JcGoybkdTM0VCU21VM1FERW5SS09BOXhuUXVva1l6dXRrN0lD?=
 =?utf-8?B?K2hPY2VmNDU2alRFMG1RSWJxb1dCeC9aOWlTRGYycnZyRmduazNpK1cvYWcx?=
 =?utf-8?B?OE15Q012em1sWWFSVzNTRmc3NzdQVDc0OUpEOWxEeE1UV1dwZWlnanhpeE5m?=
 =?utf-8?B?OXZRWCtpSG5VdW9wcURZQ2pOT0VrN2puM0czMHdmU3RyTWNidVhicTVyMGk5?=
 =?utf-8?B?aE5rSjR4QjY0UzlWR1g0dWF6TDVRY1BOcUdqNnRNeldiNjlOdi80Y3IzNHV6?=
 =?utf-8?B?WGRYNERnSG5kbXptSldlU3dHUGVTU1JvWmV6Ylo5RUlMV1AxY3BKb0MvanpQ?=
 =?utf-8?B?cWpSZVVCWTkzb20zU3M1d2JkN205TzhqNHRJVlIrL1M2TGIvZzNVY3daL0Iv?=
 =?utf-8?B?ZGhucUs3ejhNMU9mYzNSRThMVTRqSzJFWExmZyt0ajFLaVZ3empYbk1qMDFO?=
 =?utf-8?B?c2dZM3hDczRwOGxzaHlGT3VwbXRYdE1IbDlHWXMyZzdqcVpBNVUxYzRMNnZK?=
 =?utf-8?B?RURvQ1RFY0lwczdwSHdxRkN0N3BIZUVvYVpDcWFGVldUclpVZUpqTmcvOXNW?=
 =?utf-8?B?MXhma3ZXZ3dTOFdpR2k0UndaWXRicHc2RTJhbnYrZWFPYUN2c29Ndkd1MmlW?=
 =?utf-8?B?cGtLVjdzNEVNMGhTVjFJc0lPYy9kZFRkYSt5U0xwa09YQkt2VFNxbXpIeFgv?=
 =?utf-8?B?RDJRNmRNa05nbDFmQkp1RWFqcEo5NzlhNHo4VWVhenBWTENJWHQ4RGpTdE84?=
 =?utf-8?B?OEFaZy9kRmlOc3lDZGVjdTN5RTZKSkhxV3lZTnAzekllZ1llWnplY2NVdmRT?=
 =?utf-8?B?c01Qdi9kSDBtTmJIN2ZIVENjQVkyUkpzMHIvd2NFNThsdFF5WjZrUkM0VHdH?=
 =?utf-8?B?OGRzU0hES29xSmhtVjI1c2JKZHpRK2M2eHh4Q0ZJejZKZGdwbEpOekVRaVIv?=
 =?utf-8?B?a3I2MEVGcThKTEVkZFoxSWptcUxDSk1mb3JLUmJKb0M5azlZY0l2SHNyVUFL?=
 =?utf-8?B?Y3ZvcFNiVVZmd0V5WWhmYmU3TS9BMWFWNWdmTDZZL0tTU3pQMFkwY1c3RkUv?=
 =?utf-8?B?QmQvTHRtQ2xoOWJQeW1NcEdieEpqbi9rUDVneDNQQUxXUXM0VE9BQ3BLVlFO?=
 =?utf-8?B?WWlobE5LQ1RrNjhlMWxkUFFKL0crcDhyQy8ybVRQUTVDU05LWFdRNnA0RkVC?=
 =?utf-8?B?M3dBem5CYW5lYzhCZ1ZNR25zSzY2SEFNOW16dU9TSVRTSUZuYnBtVGRoZ1U4?=
 =?utf-8?B?WEJVdWkzalhWNWE3eXdjLzB1V0I3bWxkOWkrU3ExTm5DZmszVmdyTEl5djNl?=
 =?utf-8?B?S3hPSHFQS1dkc1NUcHZ5Wm1UMk13VWlaalhlNGgxa0NHR014QkVDdUovVlFE?=
 =?utf-8?B?MmU1eGZyUkJZM240eGxneXBLU1o0eXQ1YVk1YjRiVjE3VXVEMk5KdWhwSk94?=
 =?utf-8?B?Vk5UWklkNlVmVmEzeWNqTUd3NWFRNXROSUJ1WDdDVzRhTm1nL1d2eStkenEv?=
 =?utf-8?B?bncvamFLRk85a2JIY1VwaU9tTlVJMUlobURSenRnaE9mdTJDajd1V1JFdzZV?=
 =?utf-8?B?T3p1YnJFNUJSK0xSU0RLSmJpK1NaWmg2dGRUWWI3c1JhSWtqTmpCd2NjOUxp?=
 =?utf-8?B?U0hKYXZTT0RLaGhUVE1HOXdYc08rLzRQQm9raTZCMlNVVDhlZmJucW5vR0FK?=
 =?utf-8?B?a2k1UjVjM2drUXh2b3RIb05ESTBOOW91OGhNclR6RmRGUzFmSlRuVDRKVXE1?=
 =?utf-8?B?NFJxNU1qN0J4RmlEUUJ3ZjJrbGFpTmM1dHpmQ2s3dFp1QUN6aUd2bGFlUm9q?=
 =?utf-8?Q?H5Fg1XQtzeo/mbhKjXEzPnTZU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0918a379-f266-42d7-e8d4-08dd26611de4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 10:27:51.5021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csCgIC1IYPxoLn8TAuLfulCJbE+Bd64rZ5JQIJQUMinVbyFQ2/GCfef2oJOKj9IfGS1qvXHZCW4TYqvmOGtRbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231


On 12/24/24 18:01, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 16:10:37 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Why does this have Dan's SoB?  Co-developed missing or author
> wrong?


My mistake. It should be a Co-developed-by as the other patches from 
original Dan's work.


>
>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> One minor comment inline
>
> Jonathan
>
>> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
>> +						 struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> -	struct range *hpa = &cxled->cxld.hpa_range;
>>   	struct cxl_region_params *p;
>>   	struct cxl_region *cxlr;
>> -	struct resource *res;
>> -	int rc;
>> +	int err;
>>   
>>   	do {
>>   		cxlr = __create_region(cxlrd, cxled->mode,
>> @@ -3400,8 +3421,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>   
>>   	if (IS_ERR(cxlr)) {
>> -		dev_err(cxlmd->dev.parent,
>> -			"%s:%s: %s failed assign region: %ld\n",
>> +		dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
> Looks accidental unrelated change as I can't spy what is different.
>

Yes, I'll remove it.

Thanks


>>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>   			__func__, PTR_ERR(cxlr));

