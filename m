Return-Path: <netdev+bounces-227882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFA1BB940F
	for <lists+netdev@lfdr.de>; Sun, 05 Oct 2025 07:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 063534E030C
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 05:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190971A0B15;
	Sun,  5 Oct 2025 05:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="W7rEZp68"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023072.outbound.protection.outlook.com [40.93.196.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE919D065;
	Sun,  5 Oct 2025 05:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759641209; cv=fail; b=VHPPuNjjzI0F/BiyWx2a7nLWAlkBiXOSjrY6f2Yz1RUhrBq2Hqx1tOEGTuIfOgepiUfd3KDe4P2e7hsv+s8POj3NyvxFueS1yPwTUikkbNKYfzQjNpqvgsWWZzHuebf5yUserUQrQdpnTkezAnpmjhn6yiQ2Nz7tCVHXACbVmJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759641209; c=relaxed/simple;
	bh=DqpfYD488ya/ohBQ9D9pdqswvD+0UMaleBYwvC6oHuE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aRHsCsXCWhSPnNK3YoKiRweJdjpWj0Fdica3c0LAXfp7dLpAjglbxeROgUdD2315qjwIYPviA2Y58G0IELl/WEJzDOyNDW6pfEsfOzvW6MQwfoCSQ+dZ7AUJQqDRdZ6+wUeIXlpBD2H71/w8X1AWCwLnmU/5RjKSMuyHtXyP6zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=W7rEZp68 reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.196.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knfYpvL+KEqjHONdSVp2LMW8V/4osgZa28qsjNCka+iOHiotVGBVvk1DpP+IfoOkQXmghzGrR4Pezjby10qWCVTaIhOTMwxCi9A6aLU82Kjxm8Lqn1HtvINgFu5RUFBDt59Yd7Q0VoPPbq/UT4ipmQdXmxSthEDCPm0bcEVb0FAaneZehP7+CBTaOyAjljhWrcAhESyGo/MNTt7dxNqZ84fDZSZh9hf1kSaCkW1CdfaGrA9Are6JZuoBsR90wBvmQ7seErqjtTVgutl07LBx3W9YfONTgOadNs2zuycft5084ODAZW5tTLIYBdms4HUXjg8/jhdBEoU0BA7vssr+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7DK4YPLNq4RkMP5j4W3wkudwoghUDk7p1wH3nOKCio=;
 b=avdPagD4MY8MPCOu3XV6qgFBXyZGk2AbpVS1+YFNl4FbhBGoFB1uHFMdyKm5EcEr5E63LM8MWy7Rny+csbULR2VP82zIjwXXyxMjUGED632xZU9NPgtEbG700fxlKVe9T+taXvV7dZXV8Ak1SsE5jM8pdTPcKKImmEN+QTEbHZqeQ9uOFK8g5mR4ciCSIKo4En81KLB4NkRWnch8jAb4wPFMSxfmMgl8ehqPdMxd/pTf1MyW7CpkENBwNLQh3s62WJf/rwBnXfsdGY6Owxl2ZU3027uJ6wFVPG+8tgmwF45pwGtHGlhjhRXtrIRll733uLkoI9/hsVlsG5z+sEUwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7DK4YPLNq4RkMP5j4W3wkudwoghUDk7p1wH3nOKCio=;
 b=W7rEZp68oRWtOOZNYIaz9chKU2nUbT4V96K7/oY2rWfjocAUgB/Grv2IR7g7jy1UAKS7gt1j7y1k7myz4CxF0cTSGXEMs0pp18plMcit/9t02Dc5fVmWdToQQGJsT7xY4az4Os7G+3Sxeo2XJC7LptnssSWtkX730JlDiSnniRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 LV8PR01MB9353.prod.exchangelabs.com (2603:10b6:408:2a0::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.18; Sun, 5 Oct 2025 05:13:20 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9182.015; Sun, 5 Oct 2025
 05:13:19 +0000
Message-ID: <5dacc0c7-0399-4363-ba9c-944a95afab20@amperemail.onmicrosoft.com>
Date: Sun, 5 Oct 2025 01:13:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v29 1/3] mailbox: add callback function for rx
 buffer allocation
To: Adam Young <admiyo@os.amperecomputing.com>,
 Jassi Brar <jassisinghbrar@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
 <20250925190027.147405-2-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250925190027.147405-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:208:32a::20) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|LV8PR01MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: dea8ec66-8082-4568-1f89-08de03cde60e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aERBU0JWdmd6dkRRWm5qTFlnWDRwMGlISVBaV2RuWjgrSnA0c2ZnbzdJeHlm?=
 =?utf-8?B?N2h5N3NLNkdzK2loOUp6bW05Y1k3VW9YVUtleHlZZlowZll0eG01WHYwZjNZ?=
 =?utf-8?B?ZXpuSFFqRHM2dVdHNmxSNXdBK2NNbEFYak4zaEZhbUtxUWJNNVdtYnM4YTQ1?=
 =?utf-8?B?UFFPdVNSTnJVLzJVMHdMT0grMmNiL1RkUk5hZ2pSSmpCcTB1alBiSGU1YlAy?=
 =?utf-8?B?VC9NdlRTcHhpNkMrRjk0S1VIbkUxdWY3bkdyYWZXaEJOVHErelNKUjJtZVhC?=
 =?utf-8?B?RVdyL1pGMkdLN05ha0toTFJpemdmcE5YcHNERmlCL21VWVEvNnhtS2tWZU5I?=
 =?utf-8?B?UWd6d2xNYXFtdEdlOGtBVTN3RFk5UHZ3V1ZOL1E5UGxEL3J0TWpYSENCZCto?=
 =?utf-8?B?bUNVclhUVWhQbmZ0L001N0ZJSmRROGsxS3BlaDlxUlNDVU5RWFpNcVdCU1NH?=
 =?utf-8?B?eXduL1RKVnptRmE4Z3I4OHhhVXljWDZLSmZzbW5aTVhUOEkzdXNEcGJrUlQr?=
 =?utf-8?B?KzZrRlNYR25GWXpkRWRFZVUxV0Jjb2dVUG9uK0VlMmZEbmg0L2dNdUJYMmdq?=
 =?utf-8?B?ZFVySk5Tbi9PTDg3RldMbE41SjlSSkNlUUNFZEp1cHN1MFNISG1jZFRJQjJm?=
 =?utf-8?B?VXlmK01rNWVDSS9zMEdKWTZoMVBQTTFzM3BRclFoNzRYamdyYzFtUHhlYSsy?=
 =?utf-8?B?Rk9JMXdHczZqRy9OaDZZTGtPWFplTHB6SEhEdUVoUEppMFhuWjRMdUUxTGxQ?=
 =?utf-8?B?bWNSUkpLclExQytyY2R5Vkpsb2FoblQ4ZkFsT1lFZUNhNzN4WUh1VDQwQm1Y?=
 =?utf-8?B?VDJJOUlQV2E1bm8rekgzNzRLWjltSXAzTjhhOWQ4YkhneGsvVFUrTElTamgv?=
 =?utf-8?B?K0VsWTZPYm5lYzJNNmdXTExqUXdyS0NxVzFsN1BzY21GcytVcXNPQUVybEtW?=
 =?utf-8?B?czIzWktiTm1OaFFCOC9lR0d0Sm5Wb0I2YmdYMUY5VjdERWdnSkl5dmpBS3pp?=
 =?utf-8?B?VmhIUFo2L3E3ZFcrN2xnajNEM2c5MFUxbDQ0K3NSY1RGa2pqTm0vdEZHZ0F6?=
 =?utf-8?B?cXVPOW5UY3BvM3prUzY2SkhCQnhOYTQ3OUFvcHZackdib1RySTlYVCtRTWdQ?=
 =?utf-8?B?Tlh1UytpeHUxMDRhMHQzUDUrSHJRWG1PbktVMGZTNVNMVG5MOGoxUUlQRDdi?=
 =?utf-8?B?V3FCbnFyeUtNb3ZhODZ4MWZLakVnaG9LOVF3WGMyZWRiUTJseHNML2tFNUJk?=
 =?utf-8?B?MHlNcmxLbVMyeXJRVGc2aGc2cmxmQWV5TU9GcnpQSHNHeVNDMU1EKzFnOU5z?=
 =?utf-8?B?SlBNZlZSRFI1T0hKWHlMLzljVmVGZDZQWmhpTEFuVkFZbGtvclhEdFVVZkZ5?=
 =?utf-8?B?OUhxZ2J0Vkp3aXQzZVl4eENDa0FaOVBHdUlzU2lTL29Ia2ZaOUVlMi9HVHRQ?=
 =?utf-8?B?UWpBcWt4WjZEM2IzRDJKamdBU1N5OUt6ZEcxVEdidnViS3Zvem1iQVpiKzlE?=
 =?utf-8?B?SVlwNXlWaXpYZkNpQUkyM1RqdURDQ0gyd0xGZlhFRWVvQTFVZjVFeG02ZFpE?=
 =?utf-8?B?aFFjcnZpaDA2RnZLVzh5U1ZSWDR3L2tZaDNZYnVMRHhubDc5VzRKQXVPd1lv?=
 =?utf-8?B?elIrVzBaaW40dDRyT25ISUhrbWNVMmhCWWd0RndMN2lvSHZyLytBdStyMTFu?=
 =?utf-8?B?WUd5bmIzYXhMVloyTVlSZ0ZjNk5jOENDTVNGYkkzWFkvQnk4STl5d0dGaXRX?=
 =?utf-8?B?bU96Y0FhdjR4Q3dvQ0UwcEZYTzErbXowWnh4SmliZDJMQnZvdUFLSzVQckx5?=
 =?utf-8?B?RzU4bUxkQlZnelVvVG9FVmt0R3JmWi9SdTIwQi9FNS9laGhKcFdNMUxLZ3cx?=
 =?utf-8?B?b1ZUTDdsM3NMQVRrd2tydWlRT2RSazdQL2czZlFNajJ2VlhybitGZSsrUjJs?=
 =?utf-8?Q?MlwyPCi5jqGjQs/gboJDCtpswpY0NKIf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z09XOEJFQjZocXE2NVhxTmMxS2JreGNkQUcxWCswc0tUeGMrZFFnZ1B6U1FN?=
 =?utf-8?B?a1BQUEJoV2NHcGRhY1FpNHViWnB0SVFPdy9hZGwrRFdMWHM0cEViU2RZU3ZN?=
 =?utf-8?B?T3Z2RzFDM1FlRmZPdUU4SjhTOFJWOGxuS2NwNlFDcHFGaHdTdTVHcDhtcXpF?=
 =?utf-8?B?V2VzVTNRTnFXZXlLVzBibXlLVlU0UUdqajBFT0J3SE8vd1RjWktlZmxacEFO?=
 =?utf-8?B?czNLdDdaRnNLTWh2UjBuS25TV3NBaVUzRld5ZlVldXJXNGNtZ2QrbEdvMTRS?=
 =?utf-8?B?YlMxTzFmaEFiY1lGa2tucGpnSnFaZExYL3VzMjZYc2ZqV2hzWHdmajFudkpI?=
 =?utf-8?B?K1RmaW03SmJLMHpGMkN2OERsczZNOTFaUDFhUWt2elNRWUgwWjB3Z2VHWXJ6?=
 =?utf-8?B?Nks0dE5WOGQ2aEFNZDc4MVh2Z0ljQW9pOERJeTBiN2JuRTlIY0tJenFJZkpu?=
 =?utf-8?B?b0o0WjNscVEvRlBCZDVLT21Vak9LTTlPV3VHWGJKa0JGS0NIY1R2OWNGbXpz?=
 =?utf-8?B?Ty8zcFdqSzJMbGNRSGZNa1dPanZ6TytBYWo4Y0ZrS0xtY2hKenQ3T2ZvWWJH?=
 =?utf-8?B?QnYyajJERHBaN3lPbzM1REhsaUhWcjQ5dlNSaHlpTUJUTzVZYTFtcTlrbzl3?=
 =?utf-8?B?b0lxMXZoQzlmRzBENW1Oa3ZaTlNxM2NxMXhXcUtEZnJNSTFlSnFvbFN6c1lR?=
 =?utf-8?B?Z3hNRnp0WVZISzB5eXZJQjNoTVJ2b3FVUXNOQkFPNGRHbUtJQTV2Y01Lb1NU?=
 =?utf-8?B?bVpRK3FLS2lYWlY1Z3pPMXRGc3RuRlVua3I5YkdWMHdEVVlLUVpWWlc0R3Q0?=
 =?utf-8?B?NVJZemI5bU5SdmZjek9HV1NBQjJISUZPZEYwV3ZWUmd5ZlZwbnlnS2YveWZG?=
 =?utf-8?B?Tk9DaU9IWGxUY2Q5QXJrazdwK01iQVNNeFlTMlhlcXM3TVdGaDJDOFZab2Vp?=
 =?utf-8?B?anV1R2djQndRbFluL2J2cG4xZDJrS05CcHVBTFlvSktjMDAzcWRzWFRNSHF6?=
 =?utf-8?B?OEVzTEJRdVhWN0oyMTlQMnRvZUVKcmxaWGNOL1Z4ZjZCalZueGN2dnhteEkr?=
 =?utf-8?B?MWVGY2tndUsrdStraGpub204MHQxYUh5N2VvUmd2bXhoQTh4V1hjZjRCTzBt?=
 =?utf-8?B?S1RRbWpLRi9Cd3d2cmM4QW0zWndqWHZSNDNpTUFRMEkvU1ZYWG5sOFhrN0c1?=
 =?utf-8?B?N0ZJTlAxaU9TcVhIVCtuZnJ3OHovdmczQll5L3VVbzZRQlNxOFUzekhVS0Np?=
 =?utf-8?B?amRueW90TVpJVjhNTUkrNURFdDRqeVFnc0IrRzE2ZDcrZFRGYWZGS1A0V1ZI?=
 =?utf-8?B?eHVzSlp6eG02K0I2Sm4wTFBzbFN2ZG5lYXFHcUxlckhIZm40aU4ycEx0cUxE?=
 =?utf-8?B?NlJYL0I4SVVROUZDVXBXVnpRaXArYkcxOWFhaGxyeUtvTWpvaTR5SWJwMDFI?=
 =?utf-8?B?eFV4OFZ4OExjQ1hPS05XZ1cxZ1FXOTlNdm51VUtkbnovRzZyZTRqZU5KcUhM?=
 =?utf-8?B?ZHowVUFPU2RmMlR4dUFXdjVGL3dDRXFuOG0vY25FMklWVmNYVm1TajFYbDBl?=
 =?utf-8?B?MStvaHpaS0hHS0xrdUg4L1lEMWgvNVJmZEw2L1J1Q2pHYW1MMXZnRUNPN0J6?=
 =?utf-8?B?RTVoSEFqYTVWNVhxVENFN0ZFNlBQenBtMENURkZmYUh6eEQwMXphSkQvd2oz?=
 =?utf-8?B?S1U4Y3VPSG9jT3NHNmtuMGl1SlZwZHJLa2dUMXZoc1lzSEtrTGZUZCtmcUY2?=
 =?utf-8?B?VVVudjdReWFZNERSSHVKeitLdDRiSFVpQndxQU01Y3BFV0h2QWF0QzlWS2g3?=
 =?utf-8?B?UTNyODUzQzBBdWVhMjVMTXlVdGNsYnNudFozMlc5WkZ6TWxUcDdGRE1xNmpk?=
 =?utf-8?B?UFROb2RyVThsaEZkbDBQNjVDVkkwQ3VXQUhUSzhlZ2gva2duTFpaeEcyY1VO?=
 =?utf-8?B?RHdqTW9wdGMySjBWem1rRnc4NU12cW9lVCtDR2Vta2FEVXRmb25nNzZSS21n?=
 =?utf-8?B?L1dBTWhYQ21nZUgxWGpMUW1RWDFWdzhlcEYyS2RRd0ZRZ1RPdFhjN3phYkZG?=
 =?utf-8?B?QmgwWnFlWm1KZzlTOWpINXlhalNyeURuUEpDTXVpaEV2T1NOWEFpY05iUjA1?=
 =?utf-8?B?NktOelJ1SUVhY0FML2NQWmhuRmc3TEJMSWpuVGMvV2tYNVdoUnNibnRsNS9t?=
 =?utf-8?B?NTZOa1dhMHFBR2M2dzcxV3g2TDhBRUE1Y0JjQWdXZnRKUUdvU2lsbnVhcHo1?=
 =?utf-8?Q?RKJeblUMplBNR4267EOlIcwRiS2n1thaFhjUPrVBdY=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea8ec66-8082-4568-1f89-08de03cde60e
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2025 05:13:19.8961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TISH1OHs4X14La3ul7e3uwn3yTIMkYjx6Yzpvq8CPvuQHOEMsNC4Oo5mSXq+irDpiGF8PemjtZ1DJicx2W0IpuPFITXK3ybVHVFb35V6o9TmI0kkkN9ytYL7JyA1fyI9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB9353

Jassi, this one needs your attention specifically.

Do you have an issue with adding this callback?  I think it will add an 
important ability to the receive path for the mailbox API: letting the 
client driver specify how to allocate the memory that the message is 
coming in.  For general purpose mechanisms like PCC, this is essential:  
the mailbox cannot know all of the different formats that the drivers 
are going to require.  For example, the same system might have MPAM 
(Memory Protection) and MCTP (Network Protocol) driven by the same PCC 
Mailbox.


On 9/25/25 15:00, Adam Young wrote:
> Allows the mailbox client to specify how to allocate the memory
> that the mailbox controller uses to send the message to the client.
>
> In the case of a network driver, the message should be allocated as
> a struct sk_buff allocated and managed by the network subsystem.  The
> two parameters passed back from the callback represent the sk_buff
> itself and the data section inside the skbuff where the message gets
> written.
>
> For simpler cases where the client kmallocs a buffer or returns
> static memory, both pointers should point to the same value.
>
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>   include/linux/mailbox_client.h | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
> index c6eea9afb943..901184d0515e 100644
> --- a/include/linux/mailbox_client.h
> +++ b/include/linux/mailbox_client.h
> @@ -21,6 +21,12 @@ struct mbox_chan;
>    * @knows_txdone:	If the client could run the TX state machine. Usually
>    *			if the client receives some ACK packet for transmission.
>    *			Unused if the controller already has TX_Done/RTR IRQ.
> + * @rx_alloc		Optional callback that allows the driver
> + *			to allocate the memory used for receiving
> + *			messages.  The handle parameter is the value to return
> + *			to the client,buffer is the location the mailbox should
> + *			write to, and size it the size of the buffer to allocate.
> + *			inside the buffer where the mailbox should write the data.
>    * @rx_callback:	Atomic callback to provide client the data received
>    * @tx_prepare: 	Atomic callback to ask client to prepare the payload
>    *			before initiating the transmission if required.
> @@ -32,6 +38,7 @@ struct mbox_client {
>   	unsigned long tx_tout;
>   	bool knows_txdone;
>   
> +	void (*rx_alloc)(struct mbox_client *cl, void **handle, void **buffer, int size);
>   	void (*rx_callback)(struct mbox_client *cl, void *mssg);
>   	void (*tx_prepare)(struct mbox_client *cl, void *mssg);
>   	void (*tx_done)(struct mbox_client *cl, void *mssg, int r);

