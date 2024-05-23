Return-Path: <netdev+bounces-97701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555D28CCC98
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 08:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D683A1F210C3
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 06:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF82113C9A2;
	Thu, 23 May 2024 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tsy8qyxb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7113C91F
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447450; cv=fail; b=fbCe0rraSTG5pgSiJaMwx4MKSBvd/gktOmzcXnP202H/OyKgxlgNLbQ1BMG42OU+hLQYaxq8s53yEfTxZyXsJyAYUmNe+AhDF58ERIzf5ema7+KMvFLbEpLCRMzDlBNK1yXG7D1nxEX67lzpRwqb39+5QCTjmrDttvjSJ2dXYLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447450; c=relaxed/simple;
	bh=S2tupqayvNbNJTnK59ahrjrPoUF8FREduzWFoOi8sCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gm4y9LTsy25kv2ZdrEDGNF1UEglef5JI9IZWUHNLxoZV7Tyw5E/tzVZ25j1ZyE1Wk+iVeoaweYzHm6kr91hgi08vj9XsVTh6YML58R2kIpAaaC0vOTe0JUUyYnyTYAR17D/6AdpgRKpGoxa3fAnMFlEw1GmAyR/MU5/kAD6Lwdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tsy8qyxb; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzngRERR8anmDSxEQi9myr/ExTQb0ZctPf8pgJjjupgwTAHgjox4Ygp7a0ASrtUPbAQhnPgmYW1WjqQISXZRDbeEWMey2ab//+0ShiUBIO9V0fV6CW25zKxsY8XbVxceAqnWDxbZ2qCEYN8Z3SogxiXJ+OURSD+KfQc7mk+PgXssLitEjwkk+1RTXZfsyxq1Het7LZnwLbeTrNHdAeADuZ0Jt3Yl7SRGxNix6Tnrb1Qiuf8HGgKNFOBPw4+gL7iBne/tSZnG55cF+k1ERlrig/HfgDdVGSfAHrb2v5YuzO/gVbFZLkd3HtKoe2DxsVx17ltlRVeqJCazQ3W0QJG19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2tupqayvNbNJTnK59ahrjrPoUF8FREduzWFoOi8sCE=;
 b=ihfnHnE9mgKp5uXyp98SONocWFhVaKfJeh7dJfrbhTqRtTHJ1OltVstbusy04P2KQnkRDL4REstAHE/6KyQv7iZ/H8X+Z31GU5ZFbflaVscD7YTK1I5h5KBK0eDLDkHw8NzFTMCjpUwOpfojDmeyrBqpBe+jpACabfqzpPDrfreCr/qvnWMAq14CVVAQ4TbwcbROudfHc/+F1YqRHClarE9WSCg/qm8uyrsdD5vQTlQOMbvaYhBf1fF4YhS9JoGuG2CxnM+QEudPq/R7Ue2hScyim8wyTWN2TwxyRRXH4pV06/H8//L0DWsvKOo0Pj+j0HaeKlPIgfwU2umHK23S5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2tupqayvNbNJTnK59ahrjrPoUF8FREduzWFoOi8sCE=;
 b=Tsy8qyxbQ2mwT+o5Z+6Cl0Z58ZzRZXBsEWblWzkfw1Oh+OnmfEHIFknZnHYKkSbMEm/Licy3BC05MegUlblhgFjOk3RuRmtChLCijUWOkv7PEcB3CRlWbdcNV6Qd6nrHTQS7SnUByr+9gSUQCOMP69KiVJAHRMBUuxbqVdmRHmXbwba7ZuKayr13momZ54p+43H/2tTrILEfgKl+iKN3porXE0twPylJNtgPG0aZ6OK6LrFutwg3QVw6/htKnhjTUOpRWDOhAgIQPt4/+dIs2ko6nPUEnQJaolNs6fcRglcIhJTvHpq75nPNhpKu6jm5Cv0a1BXmxLi76VkYExcPlg==
Received: from IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.21; Thu, 23 May
 2024 06:57:26 +0000
Received: from IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4]) by IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4%6]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 06:57:26 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>
CC: Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Thread-Topic: [PATCH net] net: drop secpath extension before skb deferral free
Thread-Index:
 AQHapRztf+XVv59L3kGimcbRJBg/jrGU9qgAgAFhhICAABVtAIAJgugAgAMbzACAARmhgIAASUoAgAADfAA=
Date: Thu, 23 May 2024 06:57:25 +0000
Message-ID: <d81de210f0f4a37f07cc5b990c41c11eb5281780.camel@nvidia.com>
References: <20240513100246.85173-1-jianbol@nvidia.com>
	 <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
	 <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
	 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
	 <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com>
	 <Zk28Lg9/n59Kdsp1@gauss3.secunet.de>
	 <4d6e7b9c11c24eb4d9df593a9cab825549dd02c2.camel@nvidia.com>
	 <Zk7l6MChwKkjbTJx@gauss3.secunet.de>
In-Reply-To: <Zk7l6MChwKkjbTJx@gauss3.secunet.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6235:EE_|PH7PR12MB5688:EE_
x-ms-office365-filtering-correlation-id: 131b13f5-6b23-4ec2-eeda-08dc7af59ab0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXdXd1lNdVRCRmRTdk1PZXN1N1lXU2hjczR4Smh3MXdxSHFiSFJGc3dPZkhm?=
 =?utf-8?B?YlZvUnhKa3MxTkhsZEFKNkRzUXhaUUF5YnlkOFp4WFJSMkZhOWlpZ29mZkRv?=
 =?utf-8?B?ajdnZGkxU0ptK2R4RGl1a2VwaEt0RHB5T1dQcExyM3dxa2dkZFlSR1NQckh0?=
 =?utf-8?B?TTRGbE9lK1hCVHlPWGRhak1zNS81SS80NDRHS2dEUVphOENrZmxsdVYzQVZR?=
 =?utf-8?B?RHJSNTZDbCtCWUZVZmk5YXFqS0wrcFhUWUx3OG9ER1NEVzZZWTVnQjNKRnhp?=
 =?utf-8?B?Y0lNVW1qcmJtMzR4YVF4UldodHZ6dnVpdVFpaGppMUlOZlVYU1MxSzVaRWNU?=
 =?utf-8?B?bDdncDNxb0Z4SFEzNloxSk91OHM5QThKdUM1UkhESVFHbHV2eXZGTHJ3bnBm?=
 =?utf-8?B?eERkbDVQd3d4UmJlb01ERHppeFptajFpSFB5amJxWm1YZEhhNXRPMlpuVWRT?=
 =?utf-8?B?c2xYbkwySDNDaVpaWHVaMXNST3ZpTFQwUVJWZWlidzZ5NW50eUxOWW11Y2VL?=
 =?utf-8?B?dDNNWXZNeERmVEhUb1p2TkxGT3RUM0JjSXczeEJkWDB3c0dvcVgzZG5heTNW?=
 =?utf-8?B?VkNEd1R5VEdGK0RUdTAxVWdNL1BnNU9kdDRBOE56cndmM3R1OU1kMU1jeVBp?=
 =?utf-8?B?cWl0NjlVQVlOTVpoaTNpNms3RHdxQmtjcVZVNFpkUzA5RTZTczV0NitTbmFz?=
 =?utf-8?B?M0Q2emxFczlpVE1xWHlPVmd1RjdnVUxuTXkrYVlMYXNoV083RHQ1VTR4aDBC?=
 =?utf-8?B?Z2xlZkxnTVMvcFdnZEZkWU1rWlFLQjlmZEdBUStod2ZDYTR6eVhnMzJ4ZEh6?=
 =?utf-8?B?bjFHelVLeU8vVy8rdTRHUU5EU1FmajNKOXcyQndKS09idlZuMFFlU3NaNmd3?=
 =?utf-8?B?dlZnMVg2V21CdytnaUk3VVpST0F6OEhRcXBVQWVqbktaMjc5Y2tKelJiVDJr?=
 =?utf-8?B?VlI3bC9sQ2pFYWZWMjhOTDhjUzZEVDJiUVQ0NDcvUzhjUVV6RGhBYnprL2l3?=
 =?utf-8?B?bm12TjN6bkNSTUtQQkk5QTJIemNJQUNQMGlBYUM3Z0N1aC96ZFNoWDBUaHlp?=
 =?utf-8?B?bTdRZVpmOERYRkc2VXF6L2dZY1lRTStyeXdNZlhlUjRDSWlGc1lqd2R6WmRK?=
 =?utf-8?B?aFNxRCtZdE9UWlZQWkpmWEhkZ01YeUZPcURTM2ltSWRmZ1JRWksvcWRYbWhv?=
 =?utf-8?B?Z3FQeEVoS0psNjlqRSt0bjdmSXlmSDN5bGJMUEFsUHZRb0w5MUVtQ2ltSUtt?=
 =?utf-8?B?RTJqNnJraHpmOEgyUm1TaGhGZHZEVTdBa1d6UWRBdDYyZXBmRVZlaDR3cHVz?=
 =?utf-8?B?eXpDUzdyalNFQjVqMWJaN2JNZHhOdkUyTWZFRnhRZDJNVFN5RlYzUENvTW9O?=
 =?utf-8?B?YzMxT0ZCUkw5c3R3VVg4aWRTbTBqZ0svYzlsbDFNU0FSanNkbTEvVkxwa1hk?=
 =?utf-8?B?MU9wV3g5RnJXTGVWMUIvRjBGUDlBWm9oM0NFb2ZMaWgvRUsrMi9sUElobGxj?=
 =?utf-8?B?bWVGSWcySHNMZDVtZCtURG5MU2VUcVBQVWlwZ3VYZU4vZFBVMjZ3bm00U2dt?=
 =?utf-8?B?YWtKMTk2RExtczFzTHZybHJBUFRFenVnc3JVTVlBWVgrd1JtNmhIRlNpYUln?=
 =?utf-8?B?dTZHN1BuY1MyME1NQ0JZOU9mSFUzcktacklnQmR5QnVkQ0VIUlJIRzFyUTUz?=
 =?utf-8?B?KzRYZHdCQTJ2ZnkwVlgvejZYZ3VRd3VNcW5USjh6SmY2UU56MkZ6T1d3YnFr?=
 =?utf-8?B?REUxTGhOWHZEVHBkQ2t0QjBkSlF3ZS83elk0KzA5MzE0OUw3czJLVmh1czBZ?=
 =?utf-8?B?VUQyUWovQTNud0Ixd0V6Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6235.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b280alE2aGpiUUcrOU5TbWRHSzdTYlhXeXkvNDJqbk50Vyt4OWczUkN2SUVF?=
 =?utf-8?B?YTdSVENPb2MzVEUyZEV3QXJJaHFncStEUW9Fb0MzL0VGd010MnJvc2grMjlp?=
 =?utf-8?B?NWNwMGtlQjNQbldkU09NNXhxc05Bei9CZjlPd0dKcHIwb3BxZnBWaTZ0T3d1?=
 =?utf-8?B?NEtON05YcnZYbFRTZ1lmY0lCYXpwSml2a0M5b0gxcnhMOTBTbjZLWW9paTVV?=
 =?utf-8?B?bHlYOTRUYzZYdDJ4YmFadHpYM0hzNTJGRkk5WWpyWklJd0x4MEt1Q1poWEVB?=
 =?utf-8?B?cEFwTUxUSTVpVXFjUTl4NUpnWXdMK2pTRzdPS21tRWd5SW4yaHo5ZjVLcWZ5?=
 =?utf-8?B?N2VlNzVwRmhYdDIwNjRKR002L2VaV2F0ejBPZjZSZ2N0L21WWmRBeGJNM1NF?=
 =?utf-8?B?TkN3UVc4cktRaHJrS0V1SzRTZnVzSGxDVVZhdHVYNXNFNURqUkxONit4ekRz?=
 =?utf-8?B?UE1uK0NaclFsSmNYc3pZQ0dJblRzb3FYZHVHQ0dabEFaRzBMV3BFaGhLL1Ny?=
 =?utf-8?B?NnR3Y3JIcEZTU1ZtZEovZGt0QzU4OW9odjg1TE90VnRjWmRzKytEeTRROEx2?=
 =?utf-8?B?cFdMY3B3VjVLaW9PUTVCekZRbVZvV05LUUN0SEdvWDBxZUFIWHloQm85WVZY?=
 =?utf-8?B?NjVvc2ZZTUV4SVJwTWhOdk1YT0RHMXg0ZzNSa1dnVXQvSnNlRHc1bThPNWdZ?=
 =?utf-8?B?cUdINDNwVExRZnZML1F4Q0JjdEg5cm50Y1BmU2pOUjVsY0hQQ0l3ZjBsZlVk?=
 =?utf-8?B?blJzdUhUdk1wclRtdGpUdWNoeDR4elR0OVIxazN0R2E5SzB2bUkzakVwL0Jq?=
 =?utf-8?B?bnVIOSsyTkpTTUZyU0ZCdmtBY0grRTUvOG9rZExDTldRWm84TmMxUUdQY1pE?=
 =?utf-8?B?VWlEMGF0ejhMTm1Ka2ZScm4wQlAyOUFuMmlNa0pncloxWU1oUzFlWEdGNG9q?=
 =?utf-8?B?NUhFRm5zOWhuOGNMMndtVDB4ZWRsOVFncDU1a0pJQ3RhTlRHL0pudGNpS1R0?=
 =?utf-8?B?eFp5NCtTaDgzaklwNHpFK08zMVo2eXNKSWE1WTVGMURGUEFXenp1QUNlM0NB?=
 =?utf-8?B?VTZEa0VHVXYxS0VjaU8rYTJXOHpLemk4OHBiZlVZNHN6dFF0QkRKVnZDNTdE?=
 =?utf-8?B?emdpV0xkNVlqUS8vaUZxWXZYbVhzOGRTQmxYVTY4ZnJNb1o0eHdyUHhheFFE?=
 =?utf-8?B?WW9CVGEzYUtxa1Z4ZHJOTkZER3RFMmMyMWk0cnl0RzhYdlZjSTBBYkExcnRC?=
 =?utf-8?B?V1B2bi81a1Iyb1RmYmJMUDRBYnFsdUpmUlJ6RDRwMGVkbnBwbTBDRlV6VTFN?=
 =?utf-8?B?emdWb1BCMG93Z1N4K0lNZVJ2N1Y1OEY2b3dBTGRIT0p0RFA0UnJYSVBsYkVw?=
 =?utf-8?B?ZWY5eVhEMFc0U3dIMmRDVCthbWcwdi91T0IySENjTzkyeFhSZnFXZXozWXF6?=
 =?utf-8?B?MEU2MCsxM2NDd2VGaHZXRFJoQzh0VW5ldjJRUlFiakdmNUd4Rlp3RjdWS25J?=
 =?utf-8?B?Q0FpQTVUQUQ3c0k3Wk5XbnZDVnFicmJEc0srN2NpaVAyWUZKVWxBQ2JZWWtD?=
 =?utf-8?B?c0tWQnRLak4rbEpBeFU4a0pmdDdKSzBzYWZqeVh6b29hNGNaemcrQmVMSUdB?=
 =?utf-8?B?amNvTWluVGRUelJWdGdRQjBuaE51SEM3NzJxQnhaNm5BOTdNbDh6TVBIVFlB?=
 =?utf-8?B?MkNEdHNDc0FGeG9EcDhBYlNGR2pNR2hicEJFYWhVNlZNNmpITFJ5aEJvcTlL?=
 =?utf-8?B?WmY0eVI2UFFtSjNLaXpyQmsyeWVRMEFqVHRHbXZxaklDbGIwR0tjY3kxcmw3?=
 =?utf-8?B?ZlAwMzJGelFGSDcwNjNIU2loYkVXMUp3UFJkOFJaVzROTFhDK3BOaENaTzFD?=
 =?utf-8?B?RHJPQXFOT2lSbzJ2QytSZ0dtbVN1Wkppb1gxbmVwcUNxVjlWNUJBRUpjK3hU?=
 =?utf-8?B?V2NuY3A5U2dVczdMRXFjWk1wREZrb0VMZ1JNVzk0L0U0akhBN3JZcVhvMGpm?=
 =?utf-8?B?K0hrZ2hnb2NXeG5kRUcyMHN2TXB0M2MxdnhHc1BkRlkzL2ZCd2hvdmJDN2p3?=
 =?utf-8?B?b2JOd0lrMkVjL0NUbWxqZ0RMdzVkelk5T3lXdTRkR0czTXVHNWM4czl0TnlX?=
 =?utf-8?Q?M+cQ3PJNylK5GaHsQO0zBsV6J?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD2B108634A11247A794A2FE1DC2CA44@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131b13f5-6b23-4ec2-eeda-08dc7af59ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 06:57:26.0127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cHqCjbcAUUvSCjUSGGjnpycTB6ZEiazuQxd/x3yhKvCcgFDjJNo1t+28/tLS2VDm0Cge/9sOPsqd6MYeItd4WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688

T24gVGh1LCAyMDI0LTA1LTIzIGF0IDA4OjQ0ICswMjAwLCBTdGVmZmVuIEtsYXNzZXJ0IHdyb3Rl
Og0KPiBPbiBUaHUsIE1heSAyMywgMjAyNCBhdCAwMjoyMjozOEFNICswMDAwLCBKaWFuYm8gTGl1
IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyNC0wNS0yMiBhdCAxMTozNCArMDIwMCwgU3RlZmZlbiBL
bGFzc2VydCB3cm90ZToNCj4gPiA+IA0KPiA+ID4gTWF5YmUgd2Ugc2hvdWxkIGRpcmVjdGx5IHJl
bW92ZSB0aGUgZGV2aWNlIGZyb20gdGhlIHhmcm1fc3RhdGUNCj4gPiA+IHdoZW4gdGhlIGRlY2lj
ZSBnb2VzIGRvd24sIHRoaXMgc2hvdWxkIGNhdGNoIGFsbCB0aGUgY2FzZXMuDQo+ID4gPiANCj4g
PiA+IEkgdGhpbmsgYWJvdXQgc29tZXRoaW5nIGxpa2UgdGhpcyAodW50ZXN0ZWQpIHBhdGNoOg0K
PiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvbmV0L3hmcm0veGZybV9zdGF0ZS5jIGIvbmV0L3hm
cm0veGZybV9zdGF0ZS5jDQo+ID4gPiBpbmRleCAwYzMwNjQ3M2E3OWQuLmJhNDAyMjc1YWI1NyAx
MDA2NDQNCj4gPiA+IC0tLSBhL25ldC94ZnJtL3hmcm1fc3RhdGUuYw0KPiA+ID4gKysrIGIvbmV0
L3hmcm0veGZybV9zdGF0ZS5jDQo+ID4gPiBAQCAtODY3LDcgKzg2NywxMSBAQCBpbnQgeGZybV9k
ZXZfc3RhdGVfZmx1c2goc3RydWN0IG5ldCAqbmV0LA0KPiA+ID4gc3RydWN0DQo+ID4gPiBuZXRf
ZGV2aWNlICpkZXYsIGJvb2wgdGFza192YWxpDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeGZybV9zdGF0ZV9ob2xk
KHgpOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHNwaW5fdW5sb2NrX2JoKCZuZXQtDQo+ID4gPiA+IHhmcm0ueGZy
bV9zdGF0ZV9sb2NrKTsNCj4gPiA+IMKgDQo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlcnIgPSB4ZnJtX3N0YXRlX2Rl
bGV0ZSh4KTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwaW5fbG9ja19iaCgmeC0+bG9jayk7DQo+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBlcnIgPSBfX3hmcm1fc3RhdGVfZGVsZXRlKHgpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeGZybV9kZXZfc3Rh
dGVfZnJlZSh4KTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwaW5fdW5sb2NrX2JoKCZ4LT5sb2NrKTsNCj4gPiA+
ICsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB4ZnJtX2F1ZGl0X3N0YXRlX2RlbGV0ZSh4LCBlcnIgPyAwDQo+ID4g
PiA6DQo+ID4gPiAxLA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHRhc2tfdmFsaWQpDQo+ID4gPiA7DQo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgeGZy
bV9zdGF0ZV9wdXQoeCk7DQo+ID4gPiANCj4gPiA+IFRoZSBzZWNwYXRoIGlzIHN0aWxsIGF0dGFj
aGVkIHRvIGFsbCBza2JzLCBidXQgdGhlIGhhbmcgb24gZGV2aWNlDQo+ID4gPiB1bnJlZ2lzdGVy
IHNob3VsZCBnbyBhd2F5Lg0KPiA+IA0KPiA+IEl0IGRpZG4ndCBmaXggdGhlIGlzc3VlLg0KPiAN
Cj4gRG8geW91IGhhdmUgYSBiYWNrdHJhY2Ugb2YgdGhlIHJlZl90cmFja2VyPw0KPiANCj4gSXMg
dGhhdCB3aXRoIHBhY2tldCBvZmZsb2FkPw0KPiANCg0KWWVzLiBBbmQgaXQncyB0aGUgc2FtZSB0
cmFjZSBJIHBvc3RlZCBiZWZvcmUuDQoNCiByZWZfdHJhY2tlcjogZXRoJWRAMDAwMDAwMDA3NDIx
NDI0YiBoYXMgMS8xIHVzZXJzIGF0DQogICAgICB4ZnJtX2Rldl9zdGF0ZV9hZGQrMHhlNS8weDRk
MA0KICAgICAgeGZybV9hZGRfc2ErMHhjNWMvMHgxMWUwDQogICAgICB4ZnJtX3VzZXJfcmN2X21z
ZysweGZhLzB4MjQwDQogICAgICBuZXRsaW5rX3Jjdl9za2IrMHg1NC8weDEwMA0KICAgICAgeGZy
bV9uZXRsaW5rX3JjdisweDMxLzB4NDANCiAgICAgIG5ldGxpbmtfdW5pY2FzdCsweDFmYy8weDJj
MA0KICAgICAgbmV0bGlua19zZW5kbXNnKzB4MjMyLzB4NGEwDQogICAgICBfX3NvY2tfc2VuZG1z
ZysweDM4LzB4NjANCiAgICAgIF9fX19zeXNfc2VuZG1zZysweDFlMy8weDIwMA0KICAgICAgX19f
c3lzX3NlbmRtc2crMHg4MC8weGMwDQogICAgICBfX3N5c19zZW5kbXNnKzB4NTEvMHg5MA0KICAg
ICAgZG9fc3lzY2FsbF82NCsweDQwLzB4ZTANCiAgICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJf
aHdmcmFtZSsweDQ2LzB4NGUNCg0KDQo+IExvb2tzIGxpa2Ugd2UgbmVlZCB0byByZW1vdmUgdGhl
IGRldmljZSBmcm9tIHRoZSB4ZnJtX3BvbGljeQ0KPiB0b28gaWYgcGFja2V0IG9mZmxvYWQgaXMg
dXNlZC4NCg0K

