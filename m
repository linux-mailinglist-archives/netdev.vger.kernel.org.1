Return-Path: <netdev+bounces-198974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FD7ADE838
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5473166C51
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A9228506F;
	Wed, 18 Jun 2025 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FSK/oHYm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314FB285053
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241556; cv=fail; b=QChdVHa4ZIcuqoTww2swsUJRy0/5fF5+yW0Kh4zHosCeM018XjuF1KApSvbo19sgpMzfSW28uCQzRiMq0E0KWWA/yWI1tAVFnvLJDJleeDcXqPYHD1j5Pb6JmkFB2EScMFH6yknLH2klFreJ6Iqgm2hpM2LnJpNJT8Npp7CDGSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241556; c=relaxed/simple;
	bh=SqbbN9oVZbR9LYVqfxhNUkohJK9lKh1+PbVWu5c2XAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sojSDgXR4BvpbWEomrvWhM3w9zF74vtF83nCivDnR4PfWcwPWkocSwj2tgtYT/uT0tEIB2uA0AWppfYN+e6yFfmIj9QHqoiGpRQlDFEtZUq8me9TLGVwNbauqdeyZOwxHeJEP34Y0YoGEkczHm36L9fsRtAmfemIadGVy2KQPzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FSK/oHYm; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioHGcugkkCBS4ppwxa7TxY41uhs0202zgm3gGCpeOloXT10Z1dqWQEr6XWTYsVp76JkBaF9HZLw1k/uUvw8fszbiwed4eAfcAOW2AJ6UrAGlGLjpqD8w1rJ4PI7HpQLAI0w81A3JOTMX/vwl5SxKbD2D/25e/TugyaC466FfIJhEgZPrqAuDHaeu+NRG5kg2P/KT9eO+sUEJkTWQ7yQv8LNceLXWUaXSYRSOdpyN2Q01LyrIhmJ3kEqwsuC0MA6PjXf0geLvccaR5pP//daLfcNAIYPGIJiiTi8n6oB1UhQrL4WrqHvOpXGvMAMPc2tTXfHahOX8iH+tQVgrOdcI9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YhD0BaWmx1JPoNtzNjNmusoP1GWwL/CDzPzsVkbdLI=;
 b=NBn8AYCItKVgSKzwXQ51q9KNMXtRd8dqmKrCMfr/AkBp/yjB3hOgKunRNqBNu5UdBA/h2SM2KufIr/Z7YOrCQdsPNkBRXVkRO8TyKbw0lwhOwcFhgqSgQPx87OIvHAfc8Wf7icBQ0Ad9Er1aJWN8c1WLMh1c78J8yMOcl01HWUZFgVnSyu81ullSruXU8bCP6ZiFX6ArkpZwBdmpBQU+y4w0Lg8ewm0+ZVIs5bTrIcoJSuitXaNtmThufDAGSodqiwaSyOn5Acg9CTirHeUgKBeygRWKPP4O0/L/ZjAjhvahFMgPl6YB2n3DJkhehaKpj0Nco0J3V+XgPtOEWCcMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YhD0BaWmx1JPoNtzNjNmusoP1GWwL/CDzPzsVkbdLI=;
 b=FSK/oHYmNCz7KJQ+d+8+b7R3GMWx8pXwI2euNUxi9/0bm74gxqibCMeECFiKt6Qehf4rp3LOycHeurVIvTWy3ua239l03xGFnhVQTahM2dokaMDvljbkkRkC2jH6QT4vr23VIUpe49jRooKcWjQfbGAW5m4s7lPJj8zJJ9Q5tmUCDN1FDHM4C2vUXsQyJ0aCskIZkcUmPiCnhCHpZxIfkvsKhY8KXSi2DhNcdnajLA4ygcI3Pt23i8TFAxf056uz2j33lZmYFWrx6mKzfbCqYhZYaLa5lfykzkWw11/4zk3k+k92BVTdNLetA36D7bwBvaP2xiRvUx+ShCe8joyHsw==
Received: from BN9PR03CA0649.namprd03.prod.outlook.com (2603:10b6:408:13b::24)
 by MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 10:12:30 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::30) by BN9PR03CA0649.outlook.office365.com
 (2603:10b6:408:13b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Wed,
 18 Jun 2025 10:12:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 10:12:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Jun
 2025 03:12:16 -0700
Received: from [10.19.164.38] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 18 Jun
 2025 03:12:14 -0700
Message-ID: <178469f2-f3ae-4de7-9d5f-b315c6fbca96@nvidia.com>
Date: Wed, 18 Jun 2025 18:12:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] xfrm: hold device only for the asynchronous
 decryption
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>, Cosmin Ratiu <cratiu@nvidia.com>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
References: <20250618092550.68847-1-jianbol@nvidia.com>
 <aFKKm1Azr5nHGZR-@gondor.apana.org.au>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <aFKKm1Azr5nHGZR-@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c963b1-a617-49cd-b900-08ddae50a1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEhQeHFDWVNvaENYUFhYUExmdnA1ay9LMGUyWGp6dFJmZThBUmo5VE1sUXlW?=
 =?utf-8?B?ZGNMVmlOMUNUZW8xRUVDcVRQbVZueW1URm4rUlprT0NSaTU3OFNhK0YweklO?=
 =?utf-8?B?WG5vQ2pYTk9PMzRlaTJzdGYzKzBJV3RUTElDdXBWUHRxeWE2Z2p6L2liUUxn?=
 =?utf-8?B?K24vZUZXNGJnbmdxWnI5bStmbkludXd0MGVBVEFVUEhkZFdwUHNpTzljY2FV?=
 =?utf-8?B?Vm45eENrU2xqWnl3dm9tY2YrZ28zM3N2aXlId3pBSFJrNldCVFp5cnhCcnNI?=
 =?utf-8?B?WDRhZytsZDkrNUhNNFBjVHdiSDY5YkVpSXhRWWFqbVF5SXNqVXZ0ZWpFeEhR?=
 =?utf-8?B?RFpPMHRWMnBPdkFzaGk5Z2RiY1pGa0NqMFY2SzNuYm9OSEhpS1o5TW1BS0s0?=
 =?utf-8?B?czVzTXdDbk54T1lPa2Q1TXZPenJ4L2pqSG1kQ2tYUXFQSXhKUWFWRzdFeUVw?=
 =?utf-8?B?OWVvT1dpbWpxc3hiWktPK082NEQzV0p6Ym5kRVBPREJiNGZFUCsyVzI2Tk5n?=
 =?utf-8?B?Q3RPNlVkTU1BOFgzcFJha1JYNU9FRCtRYm8vK0pIWmhsOGJVcHRvb0pNZERO?=
 =?utf-8?B?RFpvWm1ZaU1pdVJ5Zmc1ZmZSbFlwV3k4UXRxbGdVcUVaQnJkbHd4MU5nUER2?=
 =?utf-8?B?SzZtV3Vib3c3L2V3UENpUE1qaG9JdU1ONFkyVUVRMnNyekNSYU9TM3JucUJ1?=
 =?utf-8?B?SFEvY0VXY1hTSlc2Ti9PcTcwSHBPSmd0V0NsNHROZ2ZFbFR3L05sT0tIcklF?=
 =?utf-8?B?N2xwWUJUUXIxMWZSSFhnSjlON1ArY09Eenl4VnZZOVYyak9TWjNRSnVHL2hY?=
 =?utf-8?B?THJVbnNyemJrT1RTTDUvaEJjY0djVUhYN0dqaUFxQ0ZUT0xIa095TThnd3B1?=
 =?utf-8?B?NXROMlZzNS9MWG5hVmd4Tmk3TERQYnZ1UFVjL3puL3EvVUhMeDNvamFNek43?=
 =?utf-8?B?d3F4K3k1RVpkQnhlaktUWURudkFSdmdQeFpCN3FRbnlSMGx5cUdMcGdDR0ta?=
 =?utf-8?B?RDBvT0tWNzhrZzhnSEtlRjE5MTNPTUIxd1BUQm4zSXk0NUl0MW5TVFFOQzZL?=
 =?utf-8?B?cmlJbSt2RWQ0aUhaOXUzbFhTNS9BTmJTQVcrbXJMZmc0REhWejIwK0VSampq?=
 =?utf-8?B?OVg1Snh0ZGc2MHZlM0pibHIwNGZQYW9RSnRrN3hHbTQxSGRzOWFqUWlQRHY3?=
 =?utf-8?B?VjdxREExK0RNVXZPRWFmWmY5ZzcxU1VGK2RNVVpGUnpweDRZOXZYaFVIcExu?=
 =?utf-8?B?QklSb2d5dldkeXBidnFkeFlEUlNxOFk2NnRHV3E3QmIxbllaTno5eGp4NnVC?=
 =?utf-8?B?OXhmK05EdXZMMUFnMkpoRXRzUWt4ek83UENScHFWdnUrTFpIZ29HSTZFeEl5?=
 =?utf-8?B?UVptNitEUXJTSlF0RUVTUVNONHZjOXBlZkQ2TGN4QkVsVW5RcHZxUDFPdUt2?=
 =?utf-8?B?MkNNUnA4SFBDcERpTmtNUU93bGt2c1BXUTVaWGtoZTROT1pqQU42RlU0TzdT?=
 =?utf-8?B?TFRRN1BUSGpnOWtjMG1PUzV3SmoxckZlbXBnR3FheExCUThzRjhJRUNmazlL?=
 =?utf-8?B?aytxemNsZm82YnJ6Y1BmQ1pwano1eWZxQmNBZ0JBWXd6bWFlRXJ6akd5VEYr?=
 =?utf-8?B?ckluZHRlUFFEOXN4NjAyY0FWTkpMV0FQMEtTZXEyM0xEanNhdzBUbTBkdzRE?=
 =?utf-8?B?YTVWRnJjYXpQYzVPYnl3b3JXRmdBUk1KNWsyc1BlZCtLbEJjKzAxZzZ0WDVt?=
 =?utf-8?B?a3c4L0VVR0lmYWhwcG1LbHBDK1Q1dEVhT0ZzLzVXSXdBSkt6WU45V2tudFFV?=
 =?utf-8?B?VGtKZlpUdDR5UVZtMU5IdGlGbEh1QVIyK3E4WVJsdDZOaDN0WXQ3enJvU000?=
 =?utf-8?B?Ny8wbklxbk14MTFNbzR3ZWpvWldYdlNYTTNZN2tCUy9aNUZqK0s3Nis0b1V1?=
 =?utf-8?B?YjlqNmtwVmsxWCs3Ymh6cjJ4VzFSR3hncmZHRWlPZFFOakVVUkVnWWxDaGRF?=
 =?utf-8?B?eUR1UlN0UklXWEtCbGxUaHlmTittT0t0allPM04yZG56ODZaVmExa3JucFNN?=
 =?utf-8?Q?ha59uG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 10:12:29.1330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c963b1-a617-49cd-b900-08ddae50a1e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117



On 6/18/2025 5:44 PM, Herbert Xu wrote:
> On Wed, Jun 18, 2025 at 12:25:49PM +0300, Jianbo Liu wrote:
>>
>> @@ -649,18 +650,16 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>>   		XFRM_SKB_CB(skb)->seq.input.low = seq;
>>   		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
>>   
>> -		dev_hold(skb->dev);
>> -
>>   		if (crypto_done)
>>   			nexthdr = x->type_offload->input_tail(x, skb);
>>   		else
>>   			nexthdr = x->type->input(x, skb);
>>   
>> -		if (nexthdr == -EINPROGRESS)
>> +		if (nexthdr == -EINPROGRESS) {
>> +			dev_hold(skb->dev);
> 
> You can't do that.  The moment x->type->input is called the ref count
> can be released on another CPU.  So incrementing the refcount after
> its return is too late.
> 

OK. How about moving dev_hold before x->type->input?

@@ -503,6 +503,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, 
__be32 spi, int encap_type)
  		/* An encap_type of -1 indicates async resumption. */
  		if (encap_type == -1) {
  			async = 1;
+			dev_put(skb->dev);
  			seq = XFRM_SKB_CB(skb)->seq.input.low;
  			goto resume;
  		}
@@ -649,18 +650,18 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, 
__be32 spi, int encap_type)
  		XFRM_SKB_CB(skb)->seq.input.low = seq;
  		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;

-		dev_hold(skb->dev);
-
-		if (crypto_done)
+		if (crypto_done) {
  			nexthdr = x->type_offload->input_tail(x, skb);
-		else
+		} else {
+			dev_hold(skb->dev);
  			nexthdr = x->type->input(x, skb);
+		}

  		if (nexthdr == -EINPROGRESS)
  			return 0;
+		else if (!crypto_done)
+			dev_put(skb->dev);
  resume:
-		dev_put(skb->dev);
-
  		spin_lock(&x->lock);
  		if (nexthdr < 0) {
  			if (nexthdr == -EBADMSG) {

Thanks!
Jianbo



