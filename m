Return-Path: <netdev+bounces-110785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF0C92E550
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 363DFB23739
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 11:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F815958A;
	Thu, 11 Jul 2024 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="pcRe+jxw"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2139.outbound.protection.outlook.com [40.107.117.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD5155C8F;
	Thu, 11 Jul 2024 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695574; cv=fail; b=VIeuWngy1ANDliruUKRFmskIQlTDcL4s1lHjrXhXV4h5PL0IBxw/o0JtbuBGYs8Czad9YpFNFW1UtOHnIj9d5EHSPQQwlgTA/+L0OgeL/4igkzJAwy6MKfb46dd4Cf/fdF/AKo2gwaIecpBTJtlwz7bRoZGbPB0WmkihPc4bgLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695574; c=relaxed/simple;
	bh=CQQKLRQEYsq8rYJvbz5ue1HOOmpBlyukMz6LOsNC2t0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jOkQYNWIJSHlmkSFvlo56cgI3qj/8ZF65dNAfMjqaI3RVCBEoiTUzHuIK5jAXEDgud4QelTIywMrrWnuJR/DBLDjwLfT9bXZmn3gY+G+7PfWw77OiqeFbOYA0ukW7MlBdbtYv3qCXzmgRWRDlhrCU7LcEFDUOAc3q6rsdTF7V6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=pcRe+jxw; arc=fail smtp.client-ip=40.107.117.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhQQgAnDLLJyhF0kZQS3/nLFxfibbDp/TiGzzsrjwjl+XlhKx7mAX7nTj2lV7mVAeqKRjuJN4lDbdPk5I/9qNpDRLe30Ut/zGMvx/8WNCN9MqButgyHD1INfabW8CVfUMzmC6FAp9wekYXlcLGptRBeIutCMH5TRIGskYgrOhNUIIN7me92JgupojDX8rgl7LhcS6mGqznJkpaI98cjjHWdG/yR0ElW1zXHpdPK2MaHIEIWlOulTJK2SQyjHV7tOlUjndqG4C6Q+zRRv1PWx52AboqxZpcXZUPNAyXzXGCCLFwXvFUNMbWSWxSg2CkYbLbRCwnQhpGTw5au9V+76oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MA2kv6V9XJlbPW3pdIX/QRNAZsPbqgbADoG269rgHVw=;
 b=UBBdFkbC1khB7f0VZlq590uBbSgNpCVrOIBN42C+ZUBhsdBGLtxcwNabhP1kWdXmYODKQllHt3IkMdek8+GyDghCZF/rWTc1iOkSeAnU9fvIfxn1ncckKah66e+DwaF/jazLTtPtan6vmvJNQ0ZO8GdK8mJOvUfngSzW4R/u7wja7Bq9xT7k7uPjQIcCUj9KnEaVh8FXMGHPSVkmznpFHa7T43U6UvZVkkKXF559PF1QhxajXLvJrtrxm2bUkd2nAMwl3Vep7X/GP7+G+LueSQg5uxhQolgy7Ng97AXufywijDIujY57vQdcMPxubvmfSoRu/DLUDu/xTA6xLsrj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MA2kv6V9XJlbPW3pdIX/QRNAZsPbqgbADoG269rgHVw=;
 b=pcRe+jxwjPiir6q/XlbaXeGNlkm8v4J7DNqWoma5MxTlT/mazwOq7WSgAfpxO4AVECuiJkiPcOFcQW/YS4Ki+lWllNckJCRN9Xk5KVcyMwSlb9Qvin4zwSWa2AKYuMWu1K6qGIMz/vaOlKa5suk4wu3m4Gilv02J7SLFYhQa+TFIowXOYXZc5SQBxYLy7c9ErH7BVJfRnED5RjdQCT8tOwwVKf1MxcTTP0dRTtvbNI0MZWbtYVH9ENrw6JyOUu5JQIH86OpmJXfEYIjIYWcTKlWzgKO1Os3RIYQImLB5cGGSRHGygAPZO9lBDBeJAzk11eR+//SluQHxHnSxDWe2PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KL1PR03MB8513.apcprd03.prod.outlook.com (2603:1096:820:12f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 10:59:30 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 10:59:29 +0000
Message-ID: <0e7f334f-a900-4132-af28-09d91866d109@amlogic.com>
Date: Thu, 11 Jul 2024 18:59:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] MAINTAINERS: Add an entry for Amlogic HCI UART
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
 <20240705-btaml-v1-4-7f1538f98cef@amlogic.com>
 <875d5c20-e614-4c45-a94a-8685f62a76b2@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <875d5c20-e614-4c45-a94a-8685f62a76b2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::28)
 To JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KL1PR03MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: b53aa4b3-00c3-4816-3bc0-08dca198896d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTVMVkpJL2EvNWd4Z0M0cmUzcFRSZG52ZHBQM2FCQnZIVHI0QTQzRE03RXgw?=
 =?utf-8?B?Y2hSQ3ZIUWU1a1JnRTRJTjdhaThETTVkSlllNWI0WWo0cXZOQWtJZjdQV3Nj?=
 =?utf-8?B?M1ZHb2lOd0dmQjRJMWVCbFdLL25YQzNuRWMvVFM5cWxqanpVUkt4ZUpweW9t?=
 =?utf-8?B?WEJZdVNCNWk5UjAyb0RHZG5jOHQ3V2h6UGtNaGROc3Z1emxpTCtUSjhjWExS?=
 =?utf-8?B?UGJ2MjR5MDNRQldYZlRXU0hJakd5TVZSMHRTRUpiZEp0VkNnaUZPTUp6cy92?=
 =?utf-8?B?VHRxUGRUTEZORWU0WHg2a2kzR1ZVNVRuYlZJKzRLdkl2WGdwOGlCdElIVkN4?=
 =?utf-8?B?a3VOeHZBNnZGMnRiY1VRSVRlMWxzd0txS1NOK0dYOVVpRnFVN2cxeElxMnR1?=
 =?utf-8?B?ekNvZWZHTnZweUg5ZytaNU5VL2pXcXJVTCtJWW80MnNaR2NtYVJ4LzltKytP?=
 =?utf-8?B?RVhQT0NZUU9OZDhFQ3l0bFhRKzcxSnMxYkt4S1cvYkxFeWxnWUMyYm16ZGEw?=
 =?utf-8?B?RVBETlNjejIzTHhGTlBhTzZ6SEZybE53SlRFekJBdm1zTnRRVk85ZXlELy90?=
 =?utf-8?B?VnlwbEZQWEhmODBjMjJNcmVDMmpqMjBSYUxENnFGZXJiTjlOa2dnUDdxUmJs?=
 =?utf-8?B?MVFFTG8rZGhmSllZZkFKN0FQWFRmKytiVkQyMlFwalpPUzBxZFdtc3dKVzZK?=
 =?utf-8?B?S3V3dW1VOXBaVFFpK3VCamQxYzlRSGQvQVg0TjVIY3dYK3hJdVQ2NnVCRnBY?=
 =?utf-8?B?NXBtNnRxZ3RMbTNwcHM1L2dzTkd2Zm1Dcm9OMVN1UE56RmJod0pXR0FuK0Q5?=
 =?utf-8?B?Z0dubThMWGg5eEZtN1d1VFF1ejNiN01qSVRzZ1d2dlFDSitEclBENlhlRFpn?=
 =?utf-8?B?YlU1RG0veE9pem9kUzgvVFpVNEdRdWJRUEpuSjU1Y20zZVBkNmtYbFBpZTY1?=
 =?utf-8?B?SldYTEwrd0FGai9Ra0ZTVjYvK3ZhdmE2TWFhUFJveGxmMVkyVFZ0QUNCK2tJ?=
 =?utf-8?B?UldqMVdsRTN5emVMZ0lJV053Z3F3VU81em9mVmRNaVZYQ3lESHI0bFV1M1Q0?=
 =?utf-8?B?UmNic2xPK3VNSW1nZmF6K2ZUU3lUTXNnVzQxakNjcmFhL1M2NTI5MkVLQzFh?=
 =?utf-8?B?Z2VkTWVMdERadS9xblViUUFKbU1qdjkydzQrOUtLdGhhQWQ3TmNmSmVqWHBu?=
 =?utf-8?B?TzBvRHVrcERrd3ErWGIwWklaVUdHZzdLNFJZTFRxeE1JeSttNnpQU092dTR4?=
 =?utf-8?B?dE80RzgrdmxNYVljNElPc3hrY1RtOUp1dnlaSS8zMytCM1FvYmpyWE9BZlBZ?=
 =?utf-8?B?bnV0aU1YUUY0aUgvTEtYRE10MzZTaDRaY3VKZVRUNVpZUzg4cGlqdVkzUkxT?=
 =?utf-8?B?blhaN1dTQTd2ZVlvek85Rzg3Mkc2d2psa2dySlBnNHlSS1NLM3hTZHpFUTQ3?=
 =?utf-8?B?VFczSTdNcThrWCtvWERVeHc4VDRQRnl1Y0M0SnNNTXdLTkRPU3BKM1JKZFA5?=
 =?utf-8?B?Wkd1ZlVTZldxbmw3TjVLWEQrbnJQZXhqR0kyMUx1elNmcGQ2NjVJb2dUcElv?=
 =?utf-8?B?cjd2V25FQ2JDeUdhT0NNZ1MwMlM1dERQbFdRSFJVYlNlTDZLeVRBZDBmYjNs?=
 =?utf-8?B?YlVoR3hYSS9maWdzb0VqazZ1SE1hK3hjb0tYZmtUc0JsWm92SENLSWJLK2Vu?=
 =?utf-8?B?akJsMXYvU0FRSGFPWUsrbHpFc3pVQ3NVbGNYTkVzbHhmU3BkMzMxeWRJQ085?=
 =?utf-8?B?c0VwOHlGanptNGpkNFphSnAyNStBVUxZSzFaSUtFczdxTDI4Vnh5MVF3RjJn?=
 =?utf-8?B?RWYxV1o0dXJFVnpGQ0tpZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlpyK3c2aVVGd3ZxcWNFVXJxUXBpdk5OSXY2UHFkUXd4dVFUQTNBSTMwSFZB?=
 =?utf-8?B?S0RwTC81d29lQkN3Z01SeWo0LzgrU05YNFBaKzh3eDdNUmtyc3lhYnVrVnBs?=
 =?utf-8?B?NHdVazA3bVZ5dGEwZ0xvbzhWRG5qWUw4NFdsQzJCbE9FUGt3SGJ6THU4SGJT?=
 =?utf-8?B?ZktxR2Y4d2NUVGFYK3RTcVNhTzhhNFdpRnJ4VFhGZVNaa0ZjK21vQmR4V3d0?=
 =?utf-8?B?U3g0MlNqdndPOTFuY3QzUEtwUEZzVG1LbkpSSHJhSzdwK1VDRldUVWtjTzJu?=
 =?utf-8?B?RS9kZUFsaWF1VzIzRkFXTStHZ2c0Z1dKV000L0VNb3FNRVpabGVqZ2NzMVJX?=
 =?utf-8?B?RE5KeDdZbmhoRVZQTE1ZcFhIdytURFlRVkRLbTZuUitLM1hPVzhPcHFESFpj?=
 =?utf-8?B?MTgxSkI1Zi9nZ3JOdGtnWkRmaEhGcTdqTngzVlZMM2podzVLRkF3SmJLQlFD?=
 =?utf-8?B?OHJnZW01azFQSWFxWHYvZDdrdlJzT3RRaytYcWp6Y3ZYTis4eUJ6cjN6c08r?=
 =?utf-8?B?TmIreDd3NDBXa3pObHBNUGw5SjdpVXM1U1JmWlZ1Q0N0dVNES2lRSWxuc2tT?=
 =?utf-8?B?WnZtRUR3OTlMa04yOWRYYWJ4OVUxUW1XWnBtczlORlZQL1JhQThDbTNTRkhF?=
 =?utf-8?B?T2g5WjJiUW53MWs2eEpnYXZoejBTY21HYjlTM3VSNU1xMkpEZjZwVkZpVTVT?=
 =?utf-8?B?K0RzUEhqYy9EQXFoSnVBenF0MzQ1SjNhWTB2dUN5dzRMamVlK0s2dTRMZS84?=
 =?utf-8?B?RlQ1SEt1S21jaHBhNXVHTXo0a0w1dk4vclk3aFRvNkNDK1hqRGRHbVdxU0VF?=
 =?utf-8?B?bm1WK05HWnI3SkNjMjdDYVowenJVc0VTbG9Gc1QycFJnU0ZLS3AxeGwvZXpz?=
 =?utf-8?B?c3l4dDZKYmxPVStOZ2VDMG8rekYyTFNleS9YUGV6WFBSZjJVQytveGZwS0xY?=
 =?utf-8?B?NnJhRzVTN29jaVJ3UXQ2cjBrbDFOcHJmRElLSXJBVkk0TUFVM2U2ZlFOTzV0?=
 =?utf-8?B?b0YwN1JYakdZTW10V05KTCtHdUUwdEc1TzBGTDlGSDlTL0dmMTFRSmN0cjcw?=
 =?utf-8?B?cVRzMEhjV29Gcm9hNmRPSlFjcW9OUE0rS0c3VWFaR1hRbGxVNnNOZkp1WGdp?=
 =?utf-8?B?MmowdEJQQTd4MmdoQ1lFVkdCeXpYKzRVVWw4RVkzdjNVaU00a1d3MVFyWlJt?=
 =?utf-8?B?QmZnZ0VhZHpEMzlHRzM0anZzamk5M3o4RTJXbkpYYzV5ck1Gbkh6dUpTTjdH?=
 =?utf-8?B?MXJaVVFSWmJ4MzVFRW1uYzN1Vk9xY2NwYmFpTm4rNGtSMHE2ZXVnTkM5Qng4?=
 =?utf-8?B?aFNzSC9UbVM0aDVCaHZSMHkzRndLRkg0RzJ3b05uczFnbWk5NnVvdHZmd0lB?=
 =?utf-8?B?V2xXejF2T1BTelIwR0RHQXQ0dzM1OXRpdUlHejdjTGg1WFZGZDhiQUVLcEVo?=
 =?utf-8?B?TitianBhS2JUQklKM2QrY1dBUENNU29zVm82R2NNY0l4Nys2NzJlYUhOYUdO?=
 =?utf-8?B?N2tmbnp4ZlZub2RGMjV0TUFXY0M2UXc2cWpSaG9VYS9hQ0NYMzI5VDBoV1Q0?=
 =?utf-8?B?VktDd3FGMGwzUFNabHViY0FHVGhCZWhEVHpmbVZNa2tYY1pWS3crai9FUTVL?=
 =?utf-8?B?NWdiM3BwODdhSnlrSHhwU0NSUGJ4VFRNeXU1SVV5cmowK3FxYnNRYjBCclgx?=
 =?utf-8?B?Mlc3V0ZTRm96S3ZEWHkzMngyWUpZWHJXMnNRVU5EWkRtZkJLanhtdlFCL1pS?=
 =?utf-8?B?SC9WVDFJdjNCZ0lrQ1ZYWldwdFg2cXJqMndTWXJxZ0RyemVuVVBnM2x0dmRD?=
 =?utf-8?B?ZE50eDZxTno3amdFdE8ycS9ZZHpyd3YxUmIvVmVwWnJscEhBaFZMekRzVkg2?=
 =?utf-8?B?dDVWUG8xczM0aU9kSnVDMEFuZU5NYVhzOE9RSlUvQTZlWkYxWnE5cGF6dTJN?=
 =?utf-8?B?WTJFYnBRN2ZTSlBZZStMQ2pMQ0hKVURXdnEvRS9DTkp6Z1F5YTFhcXZCTmI3?=
 =?utf-8?B?OG1IMCt3bUdCNFN5QVZ4L1pNNkc4RGNNT2RvT0h4WHV5MTNiNlltcy9iRlBL?=
 =?utf-8?B?VEtHamM3RUtyWkhMMlR4NDRTU2NJYWZvTkQ2Vnp3ZHZIU2xmZzdRZ1BRMWIv?=
 =?utf-8?Q?MzLkJvFrdLNUjuTGRJCy9VLXh?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53aa4b3-00c3-4816-3bc0-08dca198896d
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:59:29.3587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBui3mI13EkTJjEO4pIgle77E+QML3e7sbccblGhg/OqCtnt/wjzTIxxBqylGmimeZ47clWRyjKBqXmKQHCmrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8513


On 2024/7/7 21:11, Krzysztof Kozlowski wrote:
> On 05/07/2024 13:20, Yang Li via B4 Relay wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Add Amlogic Bluetooth driver and driver document.
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   MAINTAINERS | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cd3277a98cfe..b81089290930 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1140,6 +1140,14 @@ S:     Supported
>>   F:   arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
>>   F:   drivers/net/ethernet/amd/xgbe/
>>
>> +AMLOGIC BLUETOOTH DRIVER
>> +M:   Yang Li <yang.li@amlogic.com>
>> +L:   linux-bluetooth@vger.kernel.org
>> +S:   Maintained
>> +W:   http://www.amlogic.com
> Same as in your other patches. Drop. It's not a place for marketing. Or
> provide useful link.
Will do.
>
>
> Best regards,
> Krzysztof
>

