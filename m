Return-Path: <netdev+bounces-204450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF53AFA941
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 03:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3063B6BD7
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 01:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7771B6CFE;
	Mon,  7 Jul 2025 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="aCxCMyBU"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022081.outbound.protection.outlook.com [52.101.126.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DBF1ADC97;
	Mon,  7 Jul 2025 01:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751852141; cv=fail; b=Iq/1FfpYyyjKKdSQrO4K1OZ55DrolyOCg2N6HbkarJlQsl0NFKOV8y6/2Ujx2OL+EycFtb1t86lfqXKGI/nFOS7QtTedsNQULWwbfbL0FeI6akarbckvxe2+wS5A0gP3ZCS+29lqCwwu/ipVe+UrU/N5mVEcknGryyTiX4Kpntc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751852141; c=relaxed/simple;
	bh=XnKCIiKZaMjYyFRIQvBzVeQiCYC2w9t3ifK6apTc0dc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iYyHgMduReKoDavRGPBuPrLK2kvp5q/2XDLj4KfTdWBjO0AYIaMOu3CnPIBp5UidYhvVHqVFc9aG6g5oA/Gn5fJ7eL2uRj2J9Z8IKEcOuLNcbMx7TFzBLxbrWAW2jlaXwRxXmI6m7EdOpzdpJ0aOMdAy6FDt/Gc+1jRIgrkxcSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=aCxCMyBU; arc=fail smtp.client-ip=52.101.126.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=co3vtLx06Xw+yhOHFKmJqfgvQNIARrY0eXNtYCY619QpKH8ePrN1fLJhpkKycJBgmWdkHjaqzAHOi51Quajye8YyHM5uRzN6WyoPHktQYlUFONtSyAzKA3e2qDzHQbqDbpl6C29mGuVDbKj4EwI3yi5pBzLS+wgG0zxH7bIilRPNd492mq48QCsINCDssOMy2zK9C3hgC0sFZ8p9+UApuMQ+6mrkpUVJylaD3QiSYC2DEoWZSc0e5ScIL2n2x9rX+pmyx1nLJ8/z9rbLUCNVYPN8foi0xx82eZiniF4nq9OOchE1WO6IDaveAJORWjGdH+VUYw6MtXnZZy7GnWUDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg7cfSpVbbJZWacTBW+W9dL46amv2SWOYcn7IXseRNI=;
 b=stGU2jEXopDuXS1iSM4SSYvNS2m/iybSiepyK4iFIW/ke0KNnxQwnBwJzUE+c0/nZo2WJr97Vm4zLVconSVPkU/G9EMKsBC4cugX7lAOrB+RBHFFo3XCrn7cW2FjTKcdFsftccGgHZRDY5uj+Erh5Xbw01oN1Di392sbmX7kg3r8oMbjFWbZJ5RkUrrJh933GvYQV54srh90dRxMNKX0/JSf3VYdHrEk0ZKon33lt2xzEv7fqQiRZ9MMM7f3LkYC6LUGbjP7xi17sSDKhSqf+ogWA+r8pfX/Vg+zbvsL3Gv0M5g1WGBpUZn+MKmVSS8ji/IIrWLRNRxN1UCKSN0FRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg7cfSpVbbJZWacTBW+W9dL46amv2SWOYcn7IXseRNI=;
 b=aCxCMyBUJ7ph7sEIs9C5AiaYrOoHNw7lSR2nXfw0hsFvGKo8/BnJ+hVcQJuj8h8g78KKzS+xvbSzrCimiBlQXJC+lr/jKKWF7nUw5eq+c2KobnF4vohr5M+3/HKMQWLnrA0AYC9FE2f/Q0lpJmWX7NLUCPP4e42KztJxLi8u91TCxH4hTZCX5IE4KrZlFo+f/sKpTdRJY0lF0dErhklpDZMefDSaXKY4NQPlGEd7jjNyIpa4D2RrWMYY/HZNLzFuh4S/StQi0r6WTBJ2BEd51IvMntCplxlCM/vcciqvk8StRUQyDxY8XTr+n8iwkpWPe0YaWaxhArXI4IWiKp+oJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SG2PR03MB6611.apcprd03.prod.outlook.com (2603:1096:4:1da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 01:35:36 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 01:35:36 +0000
Message-ID: <617b625a-c505-40d2-9ef5-b37f5ebfdeb8@amlogic.com>
Date: Mon, 7 Jul 2025 09:35:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
To: Bastien Nocera <hadess@hadess.net>, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
 <1f49c0993c61d97128a78667c1967b440dc5b7df.camel@hadess.net>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <1f49c0993c61d97128a78667c1967b440dc5b7df.camel@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SG2PR03MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3feeec-3699-441b-cf29-08ddbcf69222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0xLWGExS255M3JpeTZBbERFMkdTaHBkdHczSVJDb3I5ZnZsd3hObFgvTVVo?=
 =?utf-8?B?OTFVS2k2cXM2MU42QktJdERWeHM0b3pFeGVYa25QRndNSGZ2dkRBYkJnZEsw?=
 =?utf-8?B?NGpUbFZjdUY1TmNiTjBOck8reEdiVE1KZzJPT2JIamJ4eDVnZmRwbjdrOUNl?=
 =?utf-8?B?K1R3RDJRRitKekx1YWl1RHd2b2ROb0h0VU1KMXZZTGNGZmdORGplbloybjZp?=
 =?utf-8?B?NkhoeEtjc3N2dlE4ZG5OdkNNcGVFcmxaVXc3MXB0NS9yZlRZU3dsZkh1UzBF?=
 =?utf-8?B?MDk1eGZxZjg0WklxZ3hyYjZlcFdKK1hrTUM2SWlIUnZ0aUt0bXZIRjlWK2Mr?=
 =?utf-8?B?K3g2QzBBZU1OdEp2YkZiR0JJU2pidVVtKzEvSUVPeUc0L2pKd3ZFN2dBaWFv?=
 =?utf-8?B?ZmtIMFlsZE4rUWkwSzR0ellhSW84WldtenVkTE9hcit6dVJvRlVqMUVTQlov?=
 =?utf-8?B?UDY1MEhNdWpxUUVFVlRVelkybXg3MzdEK3VzZjEvWVFLVUtnR1UvVVg1ekxZ?=
 =?utf-8?B?Uy9RTEZndHoxbGxXVFl2VFdXYjVYVUw5VWtlQ21lSUc3MzY5SDh6anZ1TXhI?=
 =?utf-8?B?aDVCWnBIUUc0UzhBUFJzNHhuVmhuZzU0czFSSjhIYjlIclVnbVJOV1RwSmZr?=
 =?utf-8?B?cm9FVW9BZFhiam9uTXQyUUx6MkRVeUtaSm11UEt1L0ROM3JKZm1hUFBIWlFy?=
 =?utf-8?B?bUEvM3ljOFNmVFZVN0R0VFh6MWg1STZkOUk3djJWcFdOZ1VmRThwQ0FCRHNQ?=
 =?utf-8?B?emFYOGVsd2kxTDN2dGNDUUxxUnJLT2FXWGM5RHVkU1pLdkNPbGtRNCt3eHhx?=
 =?utf-8?B?L3BvbzdtdE9FUEFDbC92dkZuQno4V0VrbTZnNzJybjQyeVViTHJCcDZUSlNu?=
 =?utf-8?B?TlBrbG9SS2owWW9jQnU1MUVpbS9RMWZUUGpxK3N6clRISWxiTVlNaDlIMU40?=
 =?utf-8?B?ZjJORFJFVlQ4UWJGdWpZRUxvVVlKWHVQU2kvM0gyb1V2c25ubmY3elRyb25r?=
 =?utf-8?B?WTBBUnlrcVdiMUFuSFdKcmFLUkExdDBReExISEJRN2c3ZUcrMEZWdHlpa1Jt?=
 =?utf-8?B?RlMrbmpLNy96eURQWnBSdC81dExyU2pFd0dqRUYrS09BcitMemxFRnJYWEdC?=
 =?utf-8?B?NzlOZmVCOU0yWElrVW5GVTdlOHYyWFhQUXpUNzhUTGdjUmUxNFoxc0J2WHlD?=
 =?utf-8?B?VVdWNXluTmZNbDk0WWFDNUd2WS9lcGFWcHpqenp1djhDVUNoUDJBVGpMOXZk?=
 =?utf-8?B?SzFIOThsOTc5Y2VzNkdocGJSOFgrWVlDTEcrRnBualloRWFkdzNhWW15R3NF?=
 =?utf-8?B?em5OdlF5VCtkK1JYdUN5S0wzVzY2bXJ6NGxDYksxZE9zeEFVM05SZ3VjdDdv?=
 =?utf-8?B?OTY5cTEvRWNHbnkyeTUwRXAyZS8ya0dlc0l0Z1ViZCtQc3hXMzFLLzFBV2d2?=
 =?utf-8?B?TXNxUFZzalEzWDRFdGVrVExlNnVuZkRzYkN6OEtVR2dmKzd2VC9pdVJwemhG?=
 =?utf-8?B?V3VJWnRScDBIcHRYTEVXSEVjTWtYampFUERLVHJIUTZkQ1FzcWt3eTlnMHV3?=
 =?utf-8?B?ZXF2V0VmMkdzNkVINFpmak9NaDlHR1JJM0gyaSsvOFkxWDFHaGxhZkZ2ejND?=
 =?utf-8?B?S05TQTcrTlZyNXZYMnphc2NUbkpIZnNJbzlLbzVlZ2tkRGVrOUloOFBQTU1o?=
 =?utf-8?B?cDdia29rZ0tNaFkvWGJpemJscHJwUi9qdWFqYVpCdFR2WGgyVnpSSkY2SlQz?=
 =?utf-8?B?QjVGVWFROC94M1FSaGRGRFlHUS9NVGdTYjJpRG5BN3U1REp4QVBOMkFCak1G?=
 =?utf-8?B?ODIzMWo5NTkvYWt1T0k0MDY5STkyajRoUGtmMXRRVGtmdy9tdUYyTW1RNk9q?=
 =?utf-8?B?bUl2MWd3YWhVS0g0OWp6V2h0VFBFZGNSYm0xdEdJZ1B5MVg5VytaemZabTQx?=
 =?utf-8?Q?9dsnPQROa4I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVYwQ3U2TUk3cTBzNTlIVFNmVDd5OFVacmtydnp6M2V4ZHNOeCtZWm0wYmQw?=
 =?utf-8?B?L3hQTnlYZmt6SHAva1FHcU9rRzM1QSsvU2ZUVGx2Q2ZORUJqUXl5eVN5Z3Av?=
 =?utf-8?B?RE9PbkdTSXhFTzhTMnk3NEhGQS9PZC9sVzFBMkpaYzdVNEMxcWRpNUVIRmE3?=
 =?utf-8?B?UHdGdWUvZkkxeVU1TGJadFZqYnZlWnlLN2dsRXNrRWFodk51d1hsZnlLOGxm?=
 =?utf-8?B?ZDNuN3F6QzlBSmtXWWZtMlR3U2k2QUM2dVNhUWk5ei93NVVrZUs1cFhsYXhY?=
 =?utf-8?B?bURFY24yNkJncUlaZ3RuTE1CR28xMHdtWXAxalM0R3A4aUR2VE55aGF1RWVo?=
 =?utf-8?B?dkcrNFA2Vi84WkpYUUVVemVFaTFGMXFrOUVjdGl5dEdyZXhPYUsrbDNVZlgw?=
 =?utf-8?B?R0ZJK0dNR2Q0TjBmZHRURXJwUnBkYTZpdlZwdVNhSDI1d296U2I1R05uRytv?=
 =?utf-8?B?SUJZZWZ1c3RhQ01Xcyt1MFNWMURYNmtQMGZkNmFhZzBxNUcxY2E1R01FMWZt?=
 =?utf-8?B?QmZuZUpMa1EyT2lUa0lHYkRvdEpqdnJuWkxOMlZBQk83aElCc1BQTUNva3Qr?=
 =?utf-8?B?TUFaUjhFVm5mc0V3K0dxK3R4eEpSQndibmZ1SHZQdEp4RkdsVzlNK3dFUnhX?=
 =?utf-8?B?cC93UGVyV24yNCtRWStMTHprQk1MNk5TR2xqNENwczJvTVhVNGtGVzhnd29v?=
 =?utf-8?B?UWNGRWwwZjdaSXlGdVEreDRMWVZhMG5IdzBncEoyRHhWMVFEbzR2T0s1ZmFN?=
 =?utf-8?B?S0pXWGVIaDBwVEd2cFMvWGxTdDRVWUkyWTd3S0pqUmgyK3dpVThpOStIbktN?=
 =?utf-8?B?OWpnR2NHYjJ2N2Urb3dCSUtFdmh2NHhSZFhlZlZwczhsMkhSZGpPeXVqUE9j?=
 =?utf-8?B?N204ajZXY2dac3MxVmdvRVpjZ25BOUhoOERsUVc1eDRJZjdrdXJDVGtBdy9J?=
 =?utf-8?B?OFJWVk52NlZKcDE5YjY4NzRsVVNYQ3cyaTFrT2pPalJMS2JsZGt2SUxoVllx?=
 =?utf-8?B?SUJLZURDZHVqbDBSM0VpY0xVVS9jNEVFNVZ1SGNzTlJvSWwrNzRDalk3Z2FN?=
 =?utf-8?B?MURrSURSVHZUQjEvWGJ1djhZT1BCNVRaZjVRVmxlbkk0dGF4QnRmRWRiMWpS?=
 =?utf-8?B?ZnZWOVV2Uk1DSE9xeVFVNlhhVkpHaks3RGxlbE5NSCtuNlovNDlVbEt1VHFs?=
 =?utf-8?B?SHBkekl6QkY0akZLTGNjcVFCZ05sMXpJSzZrdDVXd2NEd0xtSkNlRUQxSnJJ?=
 =?utf-8?B?UE1HR0Zvc3ZYUDNSaXJKSWJoY2UyZzc3WE01N0dsOWZOWFhuUTROY2dtV05q?=
 =?utf-8?B?WDVHc1RkQzMxbXZhcGhHTkR1VGd6cGNGVlJNMUg2QnN1SVhiZ2I3K0I5TmpP?=
 =?utf-8?B?aDgrZU5OZEE0aGtLWmZTYjNYbjZmaWVrQjd6b0hjZ1AvODVlVXFQMTZZN2RT?=
 =?utf-8?B?WlBDNmp2ZXhuYWhJdVRMSzdhVHQ5Z1lIUDFyOU91b3FUNW14Uy96d2dEeTEw?=
 =?utf-8?B?ai83TXFTaFd0THJ1MjRkZ0x6NlhFZUMrUEdVQzgra0oyZDQzL3dHTmF2eVU0?=
 =?utf-8?B?WmdTSWVtVGJ2WkNOTnkrSk00aU9yR2ZMdVVuWHEwWUU0MGYwa3RCMGIzUVZL?=
 =?utf-8?B?dFhhMVNiY3JkQlorOVFKRGovZHN6MzIyVE80ZVlBWUJiVFlkYU12TDMwNTUx?=
 =?utf-8?B?R01taXB4aFZaQ1JndWFLdlpiNVdXQ0lJUHQ3NWRnZzFXS0dVaE9jbjY4VzZP?=
 =?utf-8?B?ZTdLV1ZibEJvN0RNZnM0ZDgzMURiWUp1d25VdVlFZEFwakhDeE1sRUhKMmNB?=
 =?utf-8?B?amo2aFNzTm13djM0VWM4QUV6dTlOZjJGUXg0L2xPblVrMFVwNEV4bDEyRTdG?=
 =?utf-8?B?d2Y0bk4xMm15blQvbWtkWUNuQXczTHc0RTFBWVc4SFRYN1JlN3hibllZRGFM?=
 =?utf-8?B?WVErNzZXcUtscmRFN0lCTTlyYTA1aWxHV00wWEtReDBsNy9QZmhhT0J5bktj?=
 =?utf-8?B?N3BzNjdxNWxWRXlDZDBOSytHUzBOLy9Qemt4QXJLMm5Pc2VLdnA3MnN2YmpH?=
 =?utf-8?B?cnJ0Y3RJS2IwSitpY2RFV2NyK2F5bW5GcGpHZ0hqcW5jYVVuVEdNK0dRVVd6?=
 =?utf-8?Q?MRqo9+CE6QdJswO3druHeohTt?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3feeec-3699-441b-cf29-08ddbcf69222
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 01:35:35.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcDlT8gObTwtQzFCU6GkZXwoSCnl/ZXVmrSPFDDgL/WTGaMtFjooK7T/L7yyolqRwZ0WqWlpVXHQXIe5vduk5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6611

Hi,
> [ EXTERNAL EMAIL ]
>
> On Fri, 2025-07-04 at 13:36 +0800, Yang Li via B4 Relay wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> User-space applications (e.g., PipeWire) depend on
>> ISO-formatted timestamps for precise audio sync.
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>> Changes in v3:
>> - Change to use hwtimestamp
>> - Link to v2:
>> https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d199c8068@amlogic.com
>>
>> Changes in v2:
>> - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
>> - Link to v1:
>> https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com
>> ---
>>   net/bluetooth/iso.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>> index fc22782cbeeb..67ff355167d8 100644
>> --- a/net/bluetooth/iso.c
>> +++ b/net/bluetooth/iso.c
>> @@ -2301,13 +2301,21 @@ void iso_recv(struct hci_conn *hcon, struct
>> sk_buff *skb, u16 flags)
>>                if (ts) {
>>                        struct hci_iso_ts_data_hdr *hdr;
>>
>> -                     /* TODO: add timestamp to the packet? */
>>                        hdr = skb_pull_data(skb,
>> HCI_ISO_TS_DATA_HDR_SIZE);
>>                        if (!hdr) {
>>                                BT_ERR("Frame is too short (len
>> %d)", skb->len);
>>                                goto drop;
>>                        }
>>
>> +                     /* The ISO ts is based on the controller’s
>> clock domain,
>> +                      * so hardware timestamping (hwtimestamp)
>> must be used.
>> +                      * Ref:
>> Documentation/networking/timestamping.rst,
>> +                      * chapter 3.1 Hardware Timestamping.
>> +                      */
>> +                     struct skb_shared_hwtstamps *hwts =
>> skb_hwtstamps(skb);
> The variable should be declared at the top of the scope.
>
> Cheers


Will do.

>> +                     if (hwts)
>> +                             hwts->hwtstamp =
>> us_to_ktime(le32_to_cpu(hdr->ts));
>> +
>>                        len = __le16_to_cpu(hdr->slen);
>>                } else {
>>                        struct hci_iso_data_hdr *hdr;
>>
>> ---
>> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
>> change-id: 20250421-iso_ts-c82a300ae784
>>
>> Best regards,

