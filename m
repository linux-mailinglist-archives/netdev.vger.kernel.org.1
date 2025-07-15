Return-Path: <netdev+bounces-207205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C2BB06388
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C364A845F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91288264A6E;
	Tue, 15 Jul 2025 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ASnAyfpx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33321E531;
	Tue, 15 Jul 2025 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594813; cv=fail; b=KkcDIqpN4fZbmG4LD0qMhAaO43CaYA52cFVtc+y0DeB9XFRlR3u/jXPN/zouBOKxaRU6WvPdW6WWZ6cag1INPaaraA0a9g0LqxnkETzI6WcJ9owDe+oA33Qma4MW1fASjiVeBLZzWE6a57JzF2wwo8rrrVD2BmmeaP0y343j+ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594813; c=relaxed/simple;
	bh=30X2xrJRNguKMX0jITO2EaMSqIl+ewFGBKahf8EZFUc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J2i4cVsOZ8HMA+iPWDtQGFx0xwzOr2s9nHESgRkuTXaCIlwyIfgmOxgBZeneQmRay7UIAYffq/s2ywnOpuqxLzXFIVQ5DqxUeZUxa7WqvoG84LtWm/+89sCjyp9leKOQgijFPf6ln3tCNV0Tf7K3AvyPuMRlSe/cqGkl6rFw4Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ASnAyfpx; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCBmWA3r7RTIBgXXX5YtUHkHFBW5rHUET4m59MmaTOPeajXUoN3SJmYuQFYA6nOaHNztgiRrYumd+wTkTIQEiLAN8KawmMeQ/6XXAKDCqWn6yzYsP3+wEp/vop6H4BdQyRf8VAoUuqWzhJzwqH01MpljAkwjJgSoySUnQz8las18CI5TojrTGCYsfGFaUgR/KZ/6CIb1mtKek1FjCXsoHzUfLme6DtdDo2/jlHTv/ywcbh2qg1Ct3Jj8fAFy0w4STZxHbC7WNZZnPeuFjUjONoQKMAU3FFfIC7QlJDXlzj/sUF2bjMm4BlencP2XrE3s/QVLXagApSnl28y9Vr7BSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otwwLS32/c07Y81fWlFwQGT75KQ8JMil2ILlArTiBy4=;
 b=tSWQIz7zNNcQgW4FuKy7nLBeAclBeFqBmPhrUb80ZFQBeIb1lx5yVXR98HdSDM+/yCGV2UqfVfauGW3sPLDq/Nif9Kz+zrngmjKuEf7Qv/vdF4Iclo4uk/aBVuK+ZcL2xS42Cz0xD+zlbRoEoktGO6rH4/LyJMRjNEdd6QN99cp+IH7//OzBBwq9eJXWMwtJuwsexePtsOgL+E5irBuMF3bstsdtSQfzRfFL8Rp4fUPJ0YvDuh3nVGTEyvfCLnG/4Cr/lgOcByqN4QygC6O+O/rqPm/iQtywUVg5l34tn72mb9z+tRCfv3cjIspe5JDK9fAv9O/QGTfrYa/ejLTNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otwwLS32/c07Y81fWlFwQGT75KQ8JMil2ILlArTiBy4=;
 b=ASnAyfpxk1k8YdZfTBYgdOy/Zm70tA4QuIhf7ag3aSrbo6+6w5dn18Svtd329Ad2wW2HVB/mdZfwKhGpTV2AlNMYz8XcXgPkVMKkPE4uhBZ/31Na41Ax/aZTrcPSVonSzlgfiyiLxk20i51XVM2Ig/F4UMAWkMfSfvusgVXju36k19gj9F8CDsaZom9gWLkzIVn5HWH5nlNT/vev4VpqnYwBeNmEYcax0DrK2Nfqob9lMgpUBHxSS+/ysnSR9HRxuOK+pEifH1kOWTg2cM/NUo4KrMoVHMhkORRyUiw+6w502+SA8vJ8O2CWwos2B0M2rQAY/jd4b1a+Y9G+kxeNyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by BN8PR03MB5107.namprd03.prod.outlook.com (2603:10b6:408:d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 15:53:28 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8901.024; Tue, 15 Jul 2025
 15:53:28 +0000
Message-ID: <52f67fef-d6a5-4e9e-8f4b-2fb904ce81b4@altera.com>
Date: Tue, 15 Jul 2025 08:53:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: net: altr,socfpga-stmmac: Add compatible
 string for Agilex5
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 dinguyen@kernel.org, maxime.chevallier@bootlin.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250714152528.311398-1-matthew.gerlach@altera.com>
 <20250714152528.311398-2-matthew.gerlach@altera.com>
 <20250715035731.GA14648-robh@kernel.org>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250715035731.GA14648-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::28) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|BN8PR03MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: e6df130c-d52c-4e6f-8af1-08ddc3b7bd81
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azQ3R21FQllYTWo4TUxVSSsxa090ZnZ4LzRoaHNLMDFwM0FkRWc5S3dweVl0?=
 =?utf-8?B?SGtjbGgyenZzRFUrcTJMZ0ZTS3V6T1F2TVIrNWhzZGgwemRYVlg5dDl2RHQz?=
 =?utf-8?B?dVRoQ0RiV1N6ZkJKcmlUTVNWL2pOQjVYVGxqZXVLSmRPR1NaZWIwUkRaaEZT?=
 =?utf-8?B?dUVkblJocWhNRmpqbEFqRExJTmU4UWRjNmlPa0JaS1JzN3lNbW8wdGRqRlZ0?=
 =?utf-8?B?M1pMNUtlblR1T1VtZVNqQzR4K1VnMVhIRjlMZUhnRFRxenVDYlpRRUlPV1po?=
 =?utf-8?B?ZldZS3M5T3ZQMGhjVkJ4TWtBQ09YOFNBUlBFQkM2TzUxa1BLWU5jRTZQQVdV?=
 =?utf-8?B?SjREOHp1R2RxMytiTU54YStlQ0ltTm9ZeGJDKzg5UVZCd1U4bFRVTVFsOVov?=
 =?utf-8?B?TDZyTFp5d0ZSMDQyVi9BRitZOUJSd3dTdU92dUoxVFdRNVc5d0pXemZmbEJB?=
 =?utf-8?B?KzdPU2VuaFJMUTNndEo0RVhWOUowNGloU2JETFdLQ01iVmlacDk1THpBMDF4?=
 =?utf-8?B?NWVud0tGUC9DNTNIc3ZXdGtRWE1IdXRBNlFJRVQxZzJ0OVZCOVBsV2R1OXpK?=
 =?utf-8?B?RjdvVCtoUUZjOWJBUThPaE1VRjJjWitFYXhTUmRSU0FrYkJkZGVaT2U4RHBD?=
 =?utf-8?B?K1UxVXk1Uk5rNDJDS3hGZzdNalhvYThObEJOaWJjdzRHT2dXQnRxNUdHRGdz?=
 =?utf-8?B?Zk1rWkIyemh5dkpueFR4WUZkSi9sWHdxVVZuYkpYNXdjT29FcmFRR01SQVNt?=
 =?utf-8?B?VzBUcVgwb09UeHZjVEhRZE0vWFdLdWlRa1dEUE9kQ3k4dzlUN1NwbzlDWnNQ?=
 =?utf-8?B?QUVkQm5yVzJZZHZpREp0eFk4TldFbG9xNkIxSUVaaWZsRWdTQlpuMFozSU9j?=
 =?utf-8?B?a1RuQVJIV25meis3MUZ0d2VFL1pBTktHWmRLVllLcUM2TGpNK2haU2VMTi8z?=
 =?utf-8?B?WEd1Z2FwVzdwV1RoeithbHBVdldub2FEK1JQbitmTjJ5S01RUk0vbS93Nmhz?=
 =?utf-8?B?aFA1RTZwOWMwWVZ2SDd3ek5LaEtVRDJNam5VMUVBTEtBRnJ4TzlBMkc0L2Q1?=
 =?utf-8?B?ZnJ2VURma3UzelpadXZkMzFIZ0IxaUpEZXQ4Y1VIend1TUx5UFBEZjg1TU5n?=
 =?utf-8?B?aGkzV1QrZTZ3NmtXZWZZWHNVMTErMEVUS1VScEFHOFNHZUFHcjdBbkVSYnVx?=
 =?utf-8?B?eHB1VmxNMVVOd1pyeUxIZ0poRy8wdDZwZUpUTUZIL3Y4dzFrUWpCMWxKdmN4?=
 =?utf-8?B?cDFvbFdEUG5obldNOE1YUXBoRWZqN2pXUStuMm9wRHdlNTd5aHpaYzduSytJ?=
 =?utf-8?B?eFhKTkhnZm5NT24xWk5RSkc1aUdGR2ZsV2lOWmxLakxkaHowOEtvejJLcy9q?=
 =?utf-8?B?S2dzRTBiTHpxaVdjK2hGZ2dFdysvL0VJdTEyc3o2TTF5QUxlVUw5c3gvWW9p?=
 =?utf-8?B?eldlWGRFYmRtNjg0QVVuSzFWNzFkSHZzTXJRQm0zYkRjSzVZc1NiOFFpOUJw?=
 =?utf-8?B?NDZnMnFPWEhZeXJueHdYaUMveWdiVXdzYnFuaWltWGpIYWJ6U1lpUzBrZHRm?=
 =?utf-8?B?MUFxYjc4cGZtWTNsVjFLTnlBTUZlZVZFcHlPVFdBRWlNNUtNSUQvUU53VEZx?=
 =?utf-8?B?UUVHSFJHU1F6ZDJGcmU0UkJVZG1Nbks2Uk9HNDhiQTV6aXhmS3pURnpLRXpm?=
 =?utf-8?B?SllKdlZ0V0l4eFp6OTJIeVdkRU5YRlhIVHQ0a01qanlONktPV09oWUpBYk9s?=
 =?utf-8?B?ajBCK0E5a1BTM3lPaTNMd0h0K05rakIvRDl2Mi96cE9JNmQ4NHpxMkw0bzlW?=
 =?utf-8?B?NUNZbVJlVDFXaDV0RkwvZ0t6eUFHc2ZwZi8xMVF6U0x6dU40OHM2YnZRYkNK?=
 =?utf-8?B?VU9WS0lwTHpvWnlvM0I5bHpuRGRLMlp4UHNZcDdpV1NHdmhQVUpLYTRrcFBS?=
 =?utf-8?Q?N1V9eZhPC9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVR4OXBiTUQ0bVczM0s0a2prOFo0YjA1NS91aU5QdnFXbEhXS0RpdzBWb1VF?=
 =?utf-8?B?TWFMSUtYeTMvc3dJb1ZKdG5UME1mOWFRTFlvUVRVM1dJVjRwYjd3WkRHakFk?=
 =?utf-8?B?WWY0SmxOQk03N2lJMnpVN1M1Z0NUM3VTMTAxVmc4K3BpVURJMEM5ZlFSdGdu?=
 =?utf-8?B?NUtMdzJwVjJQUklOY0ROSDNiWGxFNHFOYXhwYjlydTFIWjdxRTlCSjAvK2FX?=
 =?utf-8?B?ZXN1L2t3THVrbnRuNk5YcVZnOWVhci9BZC82S01Ebm9nSTVyVmpyUngrVk5V?=
 =?utf-8?B?MHppdXdYTmpROGNRNFA3eG8vbjNNQjFZeWZmTVdhc3NuZEE4U3RwNHh1aEc4?=
 =?utf-8?B?ZForVFlKOTc2a2dRaHBZL2tFeWk5MjhSdmttckZXTXc4ckNGUHptd0NXZW9W?=
 =?utf-8?B?WGZPZ2dZUVZmQjR0eStrbktKVWtKS0F6UmxzeVluWmpjLytjZjMxTlRIa0M4?=
 =?utf-8?B?YXJLZVcwWHdUM3ArQ3hUVGJWb3BwNHlwV0JINDZuVm45YkNQYitmaEVYd0JW?=
 =?utf-8?B?VklDdGxDMXlXSEQ0c3BkTG1NMTFQMDQzb1hIWWtxbmMvMHNBZllJbHAxTVBl?=
 =?utf-8?B?QmxpemZEWktDN1FzMkxtdWluNndGajE2NVRVaDJxMzlqOGtqK0M4cnpnbVFG?=
 =?utf-8?B?bEVqRmpGWmltRDd4MEtpY0ZkV2QyOEhlSi81bGluUWpwWTY4UGY0S3FJWEpt?=
 =?utf-8?B?ZEgwWE1lYzRuTHBIYlFBU1liTjF6WS9jOUtNOGJuUXZHb2xuWVJ4UnNxeEV5?=
 =?utf-8?B?TW9EL2ZZUTBuc0NETjBwdW9nRUt1Mi9vMHJRNWYxZGpLR2hQajVHTHBxQVZU?=
 =?utf-8?B?TWFxclNRblYrd0FCbnYxanMreEZYK1BtNjhPbXdlRkZIYmE0VjBIQVBGN2gy?=
 =?utf-8?B?Y28zTThwYUZndm1wSC9Wa2Q1YmR3d1VEeEtvbmZNOVZQZHlDS2JMVVJPZWhD?=
 =?utf-8?B?am5tTWFlaGZmSmc4bWN2RzlnNTUvMkR5cjdjSTBQMmNkMVh3VEQrMUVWWW5T?=
 =?utf-8?B?S1RkVWJJZHpnS2xUVE5rU01SQUZFaDZMei9jMEE0ZjVBMnNBT0dPaDlaVDNi?=
 =?utf-8?B?YTVMcUs1bFp4Y3ZvNEhTcTRXTnNaR1Y3akh3blhpY0tTSjYrZ0YrYUovR2M5?=
 =?utf-8?B?Tjc1cnhNREtwRzB1REk5RldKMGFxdzRzMHVKNXNWWVU0MHJwY25OL3QyQytE?=
 =?utf-8?B?MHBHUmdCbTkwbFk1VkcyTVBsaXZNVkFrY2VIZUV3WHhoeHZoYmRSVmRPTHdw?=
 =?utf-8?B?aDdqV2JobzNnMlhnUTYyV1IxV0JiS0E5akJPSEpxWUZlUFpEQURFU1NtOHpk?=
 =?utf-8?B?MDdIMTk2eExkOGxZT3QwT2ZOaVZTMTdFZVE2bVhMTGhCdnFNWkdhMmorc3Nx?=
 =?utf-8?B?T0RFWjFqSnhhUFcvUmEvUS9KMkNKdnkwZWV0aGt4MjI1UFF0VFdobEJBUlJJ?=
 =?utf-8?B?SjExS0VhTG9iRG5HaU55N0M3THpZZ2oyVjZxamdZWDR4d3ZaK0VFZDQyc2NQ?=
 =?utf-8?B?NFJJRk5aNHBqTUdWT0xyMzQrZWJTY2tYaWZldCtsRTMxVnQzWk8weVhPY01a?=
 =?utf-8?B?RnNmVWk5Z3h0WU92MUF0aEF4TmVZQWIrZEJTVG1JUG5CVU5sU2xKdkpVUXg4?=
 =?utf-8?B?RmZkMjBIeHpXb2NFbklZZFd3ei9seTNYdjZaNEVjUEl5V24yQ1MrODkwVHFl?=
 =?utf-8?B?V1Q3cnFzQjdocTV1M3JpMjNKbWljMWMyYm5Wc0NuRGxUc1NjRnlQY2tyOU4y?=
 =?utf-8?B?eDd5bkdvUXJjdDdEckJ5TVh2TXJVTVRycjJHckF0dUZUdTJHeU1SVmU1OGdq?=
 =?utf-8?B?dHI4cFZjVGNlN2RtRys5cW5BSE5BVWJJODhIZFJkdHlBSWlmcHhTTks3Y0Ft?=
 =?utf-8?B?Q2xXV2M0eDMrZWZvL2ZsZXRBd0trNTE1eVhYTDhLRnBZU0xFWEo5OERFeGg1?=
 =?utf-8?B?bjUyTXBYZERqMk83TzZEam9sMU9PTzhWaStHM3VxL1haTDBabkx3VWQ0NFds?=
 =?utf-8?B?TDhPemMySjJreGNQdHBLdTZ1cUg2cWtHQlV5QUd4RWV0eTJHTENpZDJ4cEQ4?=
 =?utf-8?B?ODJwazlGR0paN2tyZzlXaXJNc282K2t6SmlzdnZnSk9JNCtJTGhSK0JiNDlC?=
 =?utf-8?B?R1hLcDQ1N0hnYW5pYy9VT0RWUkNCL2c3UWNjZ2g2VUNLcGxMdTRJWWtHWUNZ?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6df130c-d52c-4e6f-8af1-08ddc3b7bd81
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 15:53:28.3984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntocoFU6XrOEun6kSM5VSH2FErEGP+p6ZQG1sI5UqmGrdUqf8FmitmoX8yQRuIDv+ecorpIaWw1IoI96I5PlmcoDj65GUctBStiOem3k484=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5107



On 7/14/25 8:57 PM, Rob Herring wrote:
> On Mon, Jul 14, 2025 at 08:25:25AM -0700, Matthew Gerlach wrote:
> > Add compatible string for the Altera Agilex5 variant of the Synopsys DWC
> > XGMAC IP version 2.10.
> > 
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> >  .../devicetree/bindings/net/altr,socfpga-stmmac.yaml     | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> > index ec34daff2aa0..6d5c31c891de 100644
> > --- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> > @@ -11,8 +11,8 @@ maintainers:
> >  
> >  description:
> >    This binding describes the Altera SOCFPGA SoC implementation of the
> > -  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, and Agilex7 families
> > -  of chips.
> > +  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, Agilex5 and Agilex7
> > +  families of chips.
> >    # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
> >    # does not validate against net/snps,dwmac.yaml.
> >  
> > @@ -23,6 +23,7 @@ select:
> >          enum:
> >            - altr,socfpga-stmmac
> >            - altr,socfpga-stmmac-a10-s10
> > +          - altr,socfpga-stmmac-agilex5
> >  
> >    required:
> >      - compatible
> > @@ -42,6 +43,10 @@ properties:
> >            - const: altr,socfpga-stmmac-a10-s10
> >            - const: snps,dwmac-3.74a
> >            - const: snps,dwmac
> > +      - items:
> > +          - const: altr,socfpga-stmmac-agilex5
>
> > +          - const: snps,dwxgmac-2.10
> > +          - const: snps,dwxgmac
>
> Is the distinction here useful? I doubt it, so I'd just drop the last
> one. Generally, we've moved away from any generic compatible for
> licensed IP like this because there's *always* some SoC specific
> difference.
>
> Rob

I will drop the '- const: snps, dwxgmac' in v2 and just list the following:

> +      - items:
> +          - const: altr,socfpga-stmmac-agilex5
> +          - const: snps,dwxgmac-2.10


Thanks for the feedback,
Matthew Gerlach


