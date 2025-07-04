Return-Path: <netdev+bounces-204174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3232AF95E1
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DD01CA2980
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC8D15DBC1;
	Fri,  4 Jul 2025 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qlH1c8BV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB6328B0F;
	Fri,  4 Jul 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751640360; cv=fail; b=uJ1Id1h3j8V275qOBTNWVNikWsZCkp+i3Zo/HuzQQAHaglik1cFjQ5Kt3BTWsvT9Um0waESIqT9Vcm17z0IKNmQrfaA8gdorIdkJ/3QH+BHciSKQXzWC13ImVTblKfkprxD2uFFBI0auqOSGKDL6nI5VqExqXxIEtu5Yx7s7sk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751640360; c=relaxed/simple;
	bh=AoyJau2C8kOW/D+RWmdnLUlU/+gPYJQIOTjV2yTrYew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X1NFY1eKeE3IWMtSmrPz4iwpUfZ8Uq+Lzaqk7O9tyMHVvkUwIUe7qPa99IClBhO3ipWI6HK+3ZG56f343mI1NjBhi/r4dA8IBXW4UZSnxPhGcL8Gja82ZrP/M0oqVm/iG9AAXht9Py6wl+wG+CqYhL1NFQL3wHHS+q8ha1+0xzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qlH1c8BV; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SipgUcUpqpsRwDhdaeZIyZsyhindoDNNXfcf6ziP5vG3iIPUIqN4cU4IsN8y9IUZHE0J4bIeTwRt2yc1cXN0bDxttJ9yh7DBxI16h1kJbouAWM0MloZR1e3oPmMXCDCpDikqCTc/5Qr60yyeSx8aV+ZLCsuGnFqVz+xKteBdtTVwTwlQqsGF2hdgFDAd5cWbl678CjFh+ehcU02/g7tHeLfyZIAl+unJCU20zb1taQtjGNqPxB3spRyIzijT15nKwbJpx5SP1QTbqn8BnhUyLQ6rbmED4pTc5dYMT4v8AVlGmJjudqoQAa+3bPYZxL4aNwGFMZ2FPo8juf6CfIkIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWounguR02YwTYJ9Omvlks7SQVS0s4jyb13gtoB7O6Q=;
 b=v4FtmjhlT4LU2JNmzAvuP7bnXKCPnSLiqOXFjoH/GHCvMD3WttgDu6/RRX9YKUBPpndaX//0vQ87UdclCxJppBm4AqYXHrBVm269QoYY1AcaGM0Ot8rpZ/HpsotPKY6PJ4v1QafLBhlYW0WNqdSi/DfyG6o2VPoePhRFq34VvvOnSngxCVvOtouE86ni7RN1MAbXb7hfVAtyY7bAUJTD6VODev8T9VBp+gx9J8AfnM5HWoepLTrzOG/Ou0vNArXPD+Ta/+exQtPndgnIkqrSBfIlRnC8xfxsgDuYAOS7aofQle9Tfk75MRoZ3ZmkMht8EjGOOMMoF81SGGb7L2rK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWounguR02YwTYJ9Omvlks7SQVS0s4jyb13gtoB7O6Q=;
 b=qlH1c8BVVtCaLEX0L6i3K8n0u9aOjlsBi69W/ePVnS1/ycNbQHUoLfInaKoagDJpm3n1RL+tnrlQAvaHyJ/GAVPWnAv4CRgMFlb5y5Xf+rIOUzAP3ni3hgIaDh09htGsRhYjM4nmk3YiFtQpnTuPNRh+WkWwBeUhoAyCICb/uX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 14:45:55 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:45:55 +0000
Message-ID: <06f4e50f-4232-43f6-80e8-1e15c55e9520@amd.com>
Date: Fri, 4 Jul 2025 15:45:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 11/22] cxl: Define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-12-alejandro.lucero-palau@amd.com>
 <380431fc-686f-4ed5-bb1a-c7e679f88555@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <380431fc-686f-4ed5-bb1a-c7e679f88555@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 147c77bc-34ae-4a14-7b84-08ddbb097aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3dvd0lDYkVrZHdIMnRobFNRQnRYVVdhMldhazYzYlNhWnhBclNVdGZGOVE1?=
 =?utf-8?B?UTdIM1BqUHY1b2g0ZW4vN09vZFZ0YzZ6MVFOZkhkYTdKZnVyaHJxM3NjRU00?=
 =?utf-8?B?aGk0eUw0ZFZlVW5IdmZROW1hbHdoSWVCS0diYkx6ZHk0R0VLY3VteVdFOWNN?=
 =?utf-8?B?RDBqOWNsUmZuSHlaM21ybGpSdWEvUHQ5UmE5eHVWWmpMKzlQZzlPN05vRXNW?=
 =?utf-8?B?dWVBclI0WHdTQ1hOVzhRaVErS0ZvczNRRUtsTkN1eTdWOUdCS1ZpNGlVTndR?=
 =?utf-8?B?V0dZd3ZBOVIyelVLSHpSRzNxL1BKdWZSQkNGOWNmYWZubTJleHF0ZlpNcXZu?=
 =?utf-8?B?bUFlVGw2SzRlMHFVRkJrSTErVVU4S3ZQNCs5R2VqeXMwZU90YlJ3ck5JSG5M?=
 =?utf-8?B?V29FbXIxbmwyeWpGU09HNDVuTXR3WmxFQjBONlFkQXZOTmJCc1YwbWRnVVNz?=
 =?utf-8?B?OWIyakhuL25nVWQxaXNuVlJFWElxcm4wREUzQVZPc1BObDBWd1JzOS9wRmVH?=
 =?utf-8?B?aXdUR2p1QVJWVFJrdllhVks1SXVDVmZqVU9NZit0ZDhHcXg1UklOSXZDbnFK?=
 =?utf-8?B?NlE2VUZYaFNxQ0txSW9lR0FRZGoyY2lUbTFnSE56L2RrYWYzZnE3VjR6TWRI?=
 =?utf-8?B?NmpzbSsya0tNRUIzdFI3YW82UUlRbVJ1dmkwT0FLclJhaFZIK0FjTnU5ejJm?=
 =?utf-8?B?RUhrMG1PcUNhODBndjVPaE02S3ljL25pMmlmaUZUbjA1eHNXdEhOQTVkanhl?=
 =?utf-8?B?WWp3UytyK1U2MFlRQ1cydUJzK3RuNXlVNzJkcy9zdjEwR3VZanhQR0M0MmVp?=
 =?utf-8?B?NXN3MGp2V1RnQzU2bW5CZS9NSnVrYVFPazY2cURyMTUvVkZxU3JUS2N4ZjRT?=
 =?utf-8?B?MUx6MFd0UUhOdkxWTzBGM1AySkpPaXZxdEMyOGR3S2dEY1YxbmtBcklTTmFy?=
 =?utf-8?B?djJKTTYrc1BpVHNZNjdtQ2pmNUxveE53V3FGR2ZtL0xBZ3pKMmZsbVpuUk5W?=
 =?utf-8?B?OGJHOVN5TFJ1NUU2SHdNM0d6V0dMUGQ2enliOGdhY1g3R0RjM1Vkek5rQk83?=
 =?utf-8?B?T3ZXY1BqZGsxREMvejBvZGd0Wkw3Y1ZSNkZQWlZ6bWxIYStsMlhTMmFTNzB3?=
 =?utf-8?B?S0F0NHl6L2g0anlabmdyYWM2OWpobEV2NjNnRGVFUklaQ2I5QVZueHpkRjNo?=
 =?utf-8?B?TlViMVpSaHJvdTJkVTlmVVdOT0lSMzFoNzRqdFNlc3VKakV1b0U4MFU0aUdm?=
 =?utf-8?B?UjFZZ1pyNWFGaDh1dkRCVUxoNkhGeDR2bXQxYXlHazk5S3Q4Q3J4TDF2QWs1?=
 =?utf-8?B?VnRhSDcwSXZuTHIrWTNsb01JeWxONmVRWGs3eVU1bW5PMGQ3ZkRjZDBFazA4?=
 =?utf-8?B?RWJaQmV2TXVHKzFxZDRlZ0hWYmxrU2hiZjBUb1RFaE1hdjFEWWx3WE5ZY1k3?=
 =?utf-8?B?cStwQzVRSGpaeVozYTB4S0hHSXhGb0FMMkZHaHFQWDlDNnRwbkh4b3RLT21Z?=
 =?utf-8?B?LzQ5RWJ3b3dJY3ZQUlhxMlllUVFzSHBXNjBlUXdlZTFTS3FJNWViSW92NStR?=
 =?utf-8?B?M01KemJHbW9TWjdrVVFuNFplVGxqS2hLT0h1Vy9ZZmtaVEN0bjhmRFlpRnZY?=
 =?utf-8?B?WEUwNDdKck9helo0NklDUklDSHhNN0t0RVRsbElMMTd6N3Y4QjFFd2ZoK3U0?=
 =?utf-8?B?MHlwQXBhZnNjWDQvVnJyM0gvZXYyZFpYbzFmZTN3RmlWdWlNckloaEdrRmZT?=
 =?utf-8?B?N0JxMG9qVUZMdW9rK3F0MWx3TGw2WjRnK1FVY0JqT0hUK2Fpa2d4NGJ3ejll?=
 =?utf-8?B?NW1KUGpOY2VHOEdmTWZvU0NlM1AzekNQRzVRT1dhOUtkcmlza1FDRHFFbFV3?=
 =?utf-8?B?UUZiaTUyb1FNOVVEUVQxUnR1ZXZ0R3NlemltWmVZMTQrLzR2ZTcrOFlLdTVa?=
 =?utf-8?B?RDRENDFaQmh6NGxUL21yTjBFMno1TFJrdXNENFo5K29zajdZbUY3TE81RCtS?=
 =?utf-8?B?bHZkbkNPQWVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVVrZkRERVRuLzdQWHZQMSt1Y2hQVkcxWHczK3U3ZTVqNzV6NVZ0VU9wUHdz?=
 =?utf-8?B?d25uZ1JucUgySUlENWgrRDlKQ0V6aVQwTW5vMUFxUDdJT2EzZ2JMQ09nR2xz?=
 =?utf-8?B?SDk4eTMyeEpHc1lET1BzS0FKTFRTRExTZ05mdUY1SU5KNVNGbCtNYnY4TkJM?=
 =?utf-8?B?WWp1TXd0UXBHdWMxWGM3Qml1VTJvOUJqZGh3cjZNWXJHNGFtNGpSaWhHSmNV?=
 =?utf-8?B?Z2NnZHoyWUFveUp2WEkzMGluWEVBbmt1Wjl4dzZVOU9iTmJGeHlHSjlTTzFa?=
 =?utf-8?B?Tmkyb2pnYUdveUgyWTdCRm1OZkNNenNHZFk4U0lPK1lFQTdYUXh0eW42K1dw?=
 =?utf-8?B?eFJNVE5RNUZaVTVFTlkwaVh2S0ttTHBUZ05sUGhPN3hoSDQ4YjhxVTFFYTVs?=
 =?utf-8?B?RDlSbjF2V1ZuWXFWVEdPQmszK1ozUEc0d2FKWWF2dlV0UEswR01QSkRnUlR1?=
 =?utf-8?B?dGlFbWxXby90ckEvY1ExcFcvRXduTVhUMXQxRUg1QlAxMW1Nd0svbjlFVHl3?=
 =?utf-8?B?WlVPcnNQMHJ2a3FKNWhPSWRsMWExK3V2K25LbCtYQ3U5ZEtFd1BwdnZjdU9z?=
 =?utf-8?B?UXQ3RHdyZEpvM1JSZjJnVlVoZml0c2pJd1BXa09rQURlNUsvVG1xLy9jREEr?=
 =?utf-8?B?UHc5clZkdW4zMmh1QmlxY3VWSDVIVVhyN09sYzdWTnBRbmNvZFM4cjVoWFFy?=
 =?utf-8?B?Z3J1WjQ3NVNNaE0xdUlaelNIYTJjL2hTbFdOK3ZvUVpsR1ZTcENRTWJwS3ZK?=
 =?utf-8?B?Y1NWYjdPMWpZdDMybHd3V0p3Q213OVhOYitxaEovS1Q0U0Z1VEhqZ0dMdkdI?=
 =?utf-8?B?SVJqZDlrV2ovdEE0Y3Z0SFVVd2YzK3NwbG9TM2pJaFRZaFh1dEZDd3JBOFVz?=
 =?utf-8?B?eDNWbmk2K085YURyYjdVQU1wNmY4OGE1ckJzV0FiNmg5bG5jellMU2dRbGtv?=
 =?utf-8?B?VzJ4SGp5WjhKc3lVMUoyVnh0bU1Bdk1rT1BMcGdWaVBUWklrYzRtdjRnbUFG?=
 =?utf-8?B?dWxFVTA4QmEzeGgvQVVRN1E1Q1FzaDFsd3lsRkszNFNIZEs4K1YzeUwrT0hw?=
 =?utf-8?B?TCtESklrd3E1WXYzdHhRaVFRT05Yamx6b09nWHRWRUIvbmZiM2xVNHNNeUdP?=
 =?utf-8?B?MjBlMnJYK2Q4MnVJTThscXBORnl6WWdRSXZQSUlpSStabmhVVk1iRy9OcW5X?=
 =?utf-8?B?R0Juc0IrRkdtMGlucmRhQ3Mzd2FZWDdzbnpFbkx3RUFqNXo4K2ppNjlJNnRR?=
 =?utf-8?B?bHorS3lQK2Q4Zi9iMzVrZDlkamg5USt5K2pPN0I2aDRmYnBxVXNiVktYRkZr?=
 =?utf-8?B?Wms2KzQ0NTF1ZW1CTUM5Z1VQNEJsenJTNWlpOVMvSFpFM2VPWGNyZGR4TGo0?=
 =?utf-8?B?N0k0eThLMUJBZ2xvK05mUE5obGIxdkhkcjFvV2ZIaGM4aFJ4SUlsMklxWDI2?=
 =?utf-8?B?WjR6cTY4N3pkQitldno5cEFsbUdGd2JRWmJJSkZDZHJIK3dvVVZBZUhHUndO?=
 =?utf-8?B?T2ZMVHNCNFJtazkxUThwbUhzVHVUWUwwRzE3K0lzSjBvV1FWcGhtek94M1pE?=
 =?utf-8?B?bjhBZVNlZS9naEJ4TkxYcnVrUFpWeTJLcmhIejduaHFxclVHQjIwSjZHcHYv?=
 =?utf-8?B?Tno0N3FGaWxzS2xsZ0dEVGdiMmVZenMyK1YyUnJlM0xxQjRqOGtLbXFxUGJ4?=
 =?utf-8?B?RFlORG5CaUpobXF4OXNlVm5jcE9xcmZWMjRsWVFVTXIwZ2ZJSE42clM2ajhF?=
 =?utf-8?B?UUlwV3pPVmgvQ0ZQaFVlUmdRaXZDTW01YVBGZnhra1JyZ3ZTcTNZVzVDNmRN?=
 =?utf-8?B?dVNBOGhRM1lpRFVkUHpNRUl0Y1M3aUhOUFluUU9WM1Z1Si9BZ051SEloSjBj?=
 =?utf-8?B?c2RBT1JzU2lOQmpOVEhPbWdlOG9qak5lbVJZUEFwWmlzYlZZZG00MjBBV3Nu?=
 =?utf-8?B?NmxCSHI3a3pwNWhXUHJwZUp3VzlXakwrZkN3a0VYblRXKzVQak1GVTVoSEJY?=
 =?utf-8?B?RmVWOFM5elczQlp6YmNaRm1BeFBvQlhLV2l3Z2s1eWFZT2tqMXV0TTZCbklR?=
 =?utf-8?B?WmxCWmhlV2Zja3VIWDVGS2tyU0dJVFB2bjBrU0ZkaGhpZWpyNmVYdVZUUlBn?=
 =?utf-8?Q?wcKUoL53GwnreMubPfds/bBr1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147c77bc-34ae-4a14-7b84-08ddbb097aff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:45:55.2015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xStYjS1rLW7U2Ye4abCbFF/c18lZtBJAjew8xY4iwhj2NgIHrL4c+dQ4NpvMlxSzE52crpBJ1CGn/8+bASnbfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774


On 6/27/25 23:42, Dave Jiang wrote:
>
> On 6/24/25 7:13 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
> from Device Physical Address (DPA)


OK


>
>> (host-physical-address space). Before determining how much DPA to
> Host Physical Address (HPA)


OK


>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is created equal, some specifically targets RAM, some target PMEM,
> s/equal, some sepcifically targets/equal. Some HPA targets/
>
> s/target PMEM/targets PMEM/
>

OK


>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
> s/host-only (HDM-H)/HDM-H (host-only)/


OK


>> In order to support Type2 CXL devices, wrap all of those concerns into
>> an API that retrieves a root decoder (platform CXL window) that fits the
>> specified constraints and the capacity available for a new region.
>>
>> Add a complementary function for releasing the reference to such root
>> decoder.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/region.c | 169 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |  11 +++
>>   3 files changed, 183 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index c3f4dc244df7..03e058ab697e 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -695,6 +695,175 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +struct cxlrd_max_context {
>> +	struct device * const *host_bridges;
>> +	int interleave_ways;
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
>> +	int found = 0;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +	cxld = &cxlsd->cxld;
>> +
>> +	/*
>> +	 * Flags are single unsigned longs. As CXL_DECODER_F_MAX is less than
>> +	 * 32 bits, the bitmap functions can be used.
> Should this be type2_find_max_hpa() since CXL_DECODER_F_MAX here is defined to only check up to the type2 bit?


I've been told several times to not name functions as specific for 
accelerators or type2 when they could have a wider use.


>> +	 */
>> +	if (!bitmap_subset(&ctx->flags, &cxld->flags, CXL_DECODER_F_MAX)) {
>> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
>> +			cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	for (int i = 0; i < ctx->interleave_ways; i++) {
>> +		for (int j = 0; j < ctx->interleave_ways; j++) {
>> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
>> +				found++;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (found != ctx->interleave_ways) {
> 'found' never greater than 1 since it breaks immediately above on the first encounter? Should the break be there?


found can be greater than one. There is a double for loop above with the 
break exiting from the inner one.


>> +		dev_dbg(dev,
>> +			"Not enough host bridges. Found %d for %d interleave ways requested\n",
>> +			found, ctx->interleave_ways);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_region_rwsem);
>> +	res = cxlrd->res->child;
>> +
>> +	/* With no resource child the whole parent resource is available */
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
> Could res be NULL here on the first iteration with res = cxlrd->res->child && res == NULL? Maybe set res to cxlrd->res above, and then pass in res->child to resource_size() above?
>

I do not think so. If res is NULL the condition fails and no loop execution.


>> +		resource_size_t free = 0;
>> +
>> +		/*
>> +		 * Sanity check for preventing arithmetic problems below as a
>> +		 * resource with size 0 could imply using the end field below
>> +		 * when set to unsigned zero - 1 or all f in hex.
>> +		 */
>> +		if (prev && !resource_size(prev))
>> +			continue;
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
>> +			max = max(free, max);
>> +		}
> Can you do something like this to avoid keep checking prev?
>
> if (prev) {
> 	if (!resource_size(prev))
> 		continue;
> 	if (res->start > prev->end + 1) {
> 		...
> 	}
> } else {
> 	if (res->start > cxlrd->res->start) {
> 		...
> 	}
> }


Honestly, I prefer to not do that. Same with code below.


>> +		if (next && res->end + 1 < next->start) {
>> +			free = next->start - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
>> +			free = cxlrd->res->end + 1 - res->end + 1;
>> +			max = max(free, max);
>> +		}
> Maybe
>
> if (next) {
> 	...
> } else {
> 	...
> }
>
>> +	}
>> +
>> +	dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(CXLRD_DEV(ctx->cxlrd));
>> +		get_device(CXLRD_DEV(cxlrd));
> Should this ref grab be a lot earlier in this function? Before we start using the cxlrd members?


I think the protection is with the cxl_region_rwsem before the loop 
calling find_max_hpa.


The reference to the root decoder obtained will avoid its removal after 
the previous lock is released.


>> +		ctx->cxlrd = cxlrd;> +		ctx->max_hpa = max;
>> +	}
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @endpoint: the endpoint requiring the HPA
>> + * @interleave_ways: number of entries in @host_bridges
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
>> + * @max_avail_contig: output parameter of max contiguous bytes available in the
>> + *		      returned decoder
>> + *
>> + * Returns a pointer to a struct cxl_root_decoder
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
>> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
>> + * caller goes to use this root decoder's capacity the capacity is reduced then
>> + * caller needs to loop and retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with cxl_put_root_decoder(cxlrd).
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max_avail_contig)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxlrd_max_context ctx = {
>> +		.host_bridges = &endpoint->host_bridge,
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> Should move this whole line below right before checking for 'root'.


yes, that is probably better.

I'll do it.


>> +
>> +	if (!endpoint) {
>> +		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	scoped_guard(rwsem_read, &cxl_region_rwsem)
>> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max_avail_contig = ctx.max_hpa;
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
>> +
>> +/*
>> + * TODO: those references released here should avoid the decoder to be
>> + * unregistered.
> Are we missing code? Is it done later in the series?


This is related to Dan's comments in v16 about all those references not 
being currently considered if cxl_acpi or cxl_mem modules are removed. 
He explicitly mentioned about adding this TODO here.


>
>> + */
>> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
>> +{
>> +	put_device(CXLRD_DEV(cxlrd));
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
>> +
>>   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>>   			  const char *buf, size_t len)
>>   {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index b35eff0977a8..3af8821f7c15 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -665,6 +665,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>>   bool is_root_decoder(struct device *dev);
>> +
>> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
> Maybe lower case to keep formatting same as other similar macros under CXL subsystem?


It makes sense. I'll do it.


>
>> +
>>   bool is_switch_decoder(struct device *dev);
>>   bool is_endpoint_decoder(struct device *dev);
>>   struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 2928e16a62e2..dd37b1d88454 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -25,6 +25,11 @@ enum cxl_devtype {
>>   
>>   struct device;
>>   
>> +#define CXL_DECODER_F_RAM   BIT(0)
>> +#define CXL_DECODER_F_PMEM  BIT(1)
>> +#define CXL_DECODER_F_TYPE2 BIT(2)
>> +#define CXL_DECODER_F_MAX 3
>> +
> redefinition from drivers/cxl/cxl.h. Should those definition be deleted? Maybe move the whole thing over to here and call CXL_DECODER_F_MAX something else?


Oh, yes. Thank you for spotting this. I'll fix it.

Thanks!


>
>>   /*
>>    * Using struct_group() allows for per register-block-type helper routines,
>>    * without requiring block-type agnostic code to include the prefix.
>> @@ -236,4 +241,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   				       struct cxl_dev_state *cxlmds);
>>   struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
>>   void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>> +struct cxl_port;
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max);
>> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>>   #endif /* __CXL_CXL_H__ */

