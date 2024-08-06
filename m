Return-Path: <netdev+bounces-115955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B14C94895E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 08:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B7528526F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 06:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D491BC9F7;
	Tue,  6 Aug 2024 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="B5uhy+ZC"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C011BBBEB;
	Tue,  6 Aug 2024 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722925662; cv=fail; b=O9OWsCD3SOQFu00SK4JlbD+f6azBasUs5o0pxICzdKHu7HSUNfu6vazbFBPn21BE8IpuKSzLyHDaEkW0uipVC0S2DYHP9B+ODOuBxhQjL+YiKrgL37kucmi4Jjavg8riwqMm2/hoIxajNXq7fL8GDm//fHZdLZkABP8ViYSM0Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722925662; c=relaxed/simple;
	bh=QdMcW56cZM834bzJK33O6GJdxXP4Ou+V/IW21tKcePU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c+Ui4C0OTa383qxroRCmhDB6FOFryBPevlSVICd1nKBErQWMhKE/0McMsoMHdJKYJpy08G9jhwwWK+vnMjKOvtQ5HUHvztsPUGlLAvpvgX3mLFSh2Tu8hor3OcOyD5byNthy+NoOtm+Y21+WWnuNdb/qsnfIiVipdyFU7XCWsDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=B5uhy+ZC; arc=fail smtp.client-ip=40.107.215.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIEUfjP1gHSmhbNQAmfdEhFtnQDq8098QRZ8bNvHh6ZryjStQZIN/MIPhozdfiYMWNVtMLoBBmCkQCLbd5k/f6AWc5e/k3CpWGKAU8DXmQixP0/SxzqcQCfJB1r9oo8nR/sg+NHyj4oGR9CQwhUUqTI+w96r4amMRQbKmh9Mj7L6d0kfqeyHr4DlMP8QDGwTEgw82bQ8S7hTYoGFO1F4Tbihv21ozv68yZzkeMZh5QlY8P0oGQq0fRQ7DDihbrYqVB0QX6l+iyh0KPFDqVT8wnl34iCZOwIRYY/ZML0ISM3ZGs8OIr5ZqtYVYZY9LsiaJk1mnjVLxsP0KuGPD13JfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztyUhxn9J26wYcNsZ0X7HhMWoEEbOjiH2NX1wgsb1QM=;
 b=N9x34VAOZ2oVx4D+LMnW0pkfGvqS2DYTHu3z7Ow19PIXKg/8ICnaTBzKOpUso6cxpNUACo3DWWlc1WKRPspVLfs0ycHsaURk8DdIRwd29ZuwRdG7y73/FX1Ekm3NlWLIBU9+zVP+72XoG77OYUvd1ZqR83zruI0/Ivp7dBflCgiWCbmdFH/nXC3HTMp5ulciOL1c1bHqPAa4ro4Y/Ij13quo9nJ3dJapTn3QXIcYzLrpAbviiGUtUoOXAo6mxIDYLBrt26V1alIDL0JKR67sXy+H+1nXLSL+KwQL0BQZ2zKJeqJtOuq3qIJdZwWQ1u+eQS++y49drfLcjv19I652ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztyUhxn9J26wYcNsZ0X7HhMWoEEbOjiH2NX1wgsb1QM=;
 b=B5uhy+ZCSfA0DSrokQ6Th82PQ3ayMiulTNfwE7zrdUdoyWrAooEPfD2CYAIsQFZcLF2AQ+HF56wfBkrGCg+/FFwCILBbAdLeSl1krx502c3x5a/zx3KFgQnrjAQLV9vXFjySShl39LgkLpXQ5unp4CzvWKd2fw4m83sZJDxAx4U4cCaz7jAVUh7Y2DD7VG6bA6SDmZRE8353DWKCwUHCegDHDsqUEuw2OV5qw75+MqLnjL8uA0uozsi+r8WjBW28Bw8rPpF2ZEewpbDKV6NazwaaHfxUWC/8o8unh4aP9L/H0OCT/YrNBIdy3N6uLEjPJ9dMJnr66J0ErVV4TZKt6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SEZPR03MB7472.apcprd03.prod.outlook.com (2603:1096:101:12b::12)
 by TYSPR03MB8517.apcprd03.prod.outlook.com (2603:1096:405:5a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 06:27:37 +0000
Received: from SEZPR03MB7472.apcprd03.prod.outlook.com
 ([fe80::914c:d8f6:2700:2749]) by SEZPR03MB7472.apcprd03.prod.outlook.com
 ([fe80::914c:d8f6:2700:2749%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 06:27:36 +0000
Message-ID: <124d5788-11ea-4bb1-a7ad-d4aa81bc86b1@amlogic.com>
Date: Tue, 6 Aug 2024 14:27:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] Bluetooth: hci_uart: Add support for Amlogic HCI
 UART
To: Paul Menzel <pmenzel@molgen.mpg.de>, Ye He <ye.he@amlogic.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240802-btaml-v3-0-d8110bf9963f@amlogic.com>
 <20240802-btaml-v3-2-d8110bf9963f@amlogic.com>
 <a23140d2-1e82-4cfc-9659-97333ef011b5@molgen.mpg.de>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <a23140d2-1e82-4cfc-9659-97333ef011b5@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0008.jpnprd01.prod.outlook.com (2603:1096:404::20)
 To SEZPR03MB7472.apcprd03.prod.outlook.com (2603:1096:101:12b::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR03MB7472:EE_|TYSPR03MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b68bb7-149d-4ca9-f7a3-08dcb5e0dcf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Znc4by9sNm16Q3gwTUpBNTNlQUpicGxPMUk2dmMwUHdmRmt1SWpnZXFFSE9E?=
 =?utf-8?B?WXBiVk5ob29DejhIY1JNYU5xbFNvck9UbHl4YXdvWHhCZjg0d0lQNEd1U0I0?=
 =?utf-8?B?bnFBVHpjN0RBWGZVQWw2K2FKVHczY2t6QUJkYmtMdXF4bUVxV3grRzErTmF3?=
 =?utf-8?B?NjdGSHN1L3IwVThpTVJ6b2wvWDFOS2k2VWZlR05teGF0U2I2MWlLbHl0QWFw?=
 =?utf-8?B?SzMvT0dJQmZYWm5wWVhkMm1JOWVlQ3U0dll2cS9meEI0T3BPTVNld1NrZ2x6?=
 =?utf-8?B?TGxTMzlnM2ZKTzRwdlJockgrRjZVNWVhZk1QN1FKRTlqbGRGRGloSnp3eDF6?=
 =?utf-8?B?WXZ0T2ZjZnVGMFhIeWZ6YU5kMTJnNnZ3RVpOcnlpbzRuVVMvODZYVVhtdEVZ?=
 =?utf-8?B?YlJ4ajFMMzBrWCtZdFU2a2sxWC9lL3NLL1pJWU5WZW5UUjVZVXRDWXJ6TkNw?=
 =?utf-8?B?K011bnE5U2FkZ0t2TlJ5eWt2bG1xTnYyM1JTNFRZNzl3NnMyZEZtVktwMWVE?=
 =?utf-8?B?bWJxYXZycmMyY2gvdjlyVVcwUm12NlA1K3lCdGlVTCtPbHdTL0ozbU5JQXdm?=
 =?utf-8?B?Sit3Qmw4a0EyODhBM0JvVjh3RDFac2RuV0Z5VEU3M0FCSytTR3pNUlNFNTFa?=
 =?utf-8?B?TGN6U1JURnBQc0NLd3Y4TUlwQ3JPVUtML3VhMWxpb1NNWkdWUFBFVlB0Zm5E?=
 =?utf-8?B?WlpML0RGMkc3S3RiQlZNcXBxeWtZM0Vqaks2U0N4a1hrVG9uTHVwN21IN1BT?=
 =?utf-8?B?ZVNBaTNVbDFHU3hxVWZldHMyMmQ1M2lzUEk5dDA4WDEydUJmdHQrS2Y4Qkpp?=
 =?utf-8?B?M29qRm5rdGZWVDRZb0txaDRuL25yUDF5UDFvT2g2dno2bXNIZ1hpcGRva1Np?=
 =?utf-8?B?MlF6NThJeFgvZFZmazQ5ZGVvOW96Qyszd0crZFZsdStlL0czZElVQmN3Nk93?=
 =?utf-8?B?VXBFeDNPVGxlRzdLRkd0TExVa3drTTJPV0k2d0hqTjE1UTJTTDVlWFRqVWdD?=
 =?utf-8?B?K3dSTU15RmhyRm1MVjRMV2dtdW9HeCt2TllCQ1l5ZjVDM1B6YkFwMHl6Si9Z?=
 =?utf-8?B?OXVwWklGVTF3QlQ1VTA3dHIrZys2TzcwSXNGK0pUVjBlbkNnaWVDd3YvRXU4?=
 =?utf-8?B?dml5ZExZaHF3anpwTlFyUDl1SGF6UWZNTTRYNkVsa1N2L01zVk5RSE10ajNm?=
 =?utf-8?B?ZUhMNzRHZldST0UyRVAxcURUOUZWMTRmSlB0UDBhUmttcjhYVURiRDgrTUdI?=
 =?utf-8?B?eTFNUWZCQ1U0Q29XVTNYQS80WE5XL1BKZnlTbVhkU3llVkRIeE0yeFBRVjRH?=
 =?utf-8?B?MGhVTlo0a2JzTUhKZjREWVBCNjMxM09DeG03SFpFVDNQMHFpUkYyZzFGeTdM?=
 =?utf-8?B?cDJYRERvN3BJYTNqOGR1UERTZzcyNWlYOUlPZTlpSmhNUzB4c0d6RG9EUnFs?=
 =?utf-8?B?WWR3TnJnamNhNDBCNzZjZU5taGhaV080YzhkWFFEYVU2anZ4Z3ZKemFVMkpz?=
 =?utf-8?B?ZTBXbkZXQjkwc2NOUGNacWdtVUdIZ0VNbkYrU25ER1FTcU84ODNZVlRHYnND?=
 =?utf-8?B?UlZkVU5qaTRsTytOTnRNZFUwdUVZb1luSTh3RitPNGlkalJkUU1pNFBBTnE1?=
 =?utf-8?B?UEpRbGV2UERremhZcnhtT3FCR3NUN3NXa3BnSk5NVVBYR0RGYkRGR1NsendB?=
 =?utf-8?B?TXY4QXludGFKUnR6Ukw3RDVFSnhQSHVNN1ZCbTJSODErdkNObDZPRmdQQVhF?=
 =?utf-8?B?OCs3ZmZhTzVMdGhUMHlXS00yVlFhQmFQNFFRQVdibHhrbEMzUFpOQjJMUGFv?=
 =?utf-8?B?RzVuaXl6S1ZnNFoxZnRoQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7472.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STBRdjc2TWwyTis5b21UNTBOdlI0cjlCRG1hMnAxTEJWSHhUbEJtbzhtTGZF?=
 =?utf-8?B?Z2hpNjFwdy9adVhqVDdqVUZyYWI5a3BROVdrOEFDMjkrS1EzOTdvVFdsak5Q?=
 =?utf-8?B?WnB4NC9xb2ZZcU5JVGp0d0QyMC9ZWmh4KzR0eWN2TGF3NTdSMUh1WHFMdDZj?=
 =?utf-8?B?NktPNFFrQ0xPc2xuUTBXL0MxYUpQY1VxVS9la0lVelRwalROYURuOGpXNldS?=
 =?utf-8?B?SWlSRElzV0RFbVNSZ25vSkRHaHdWbnFBNllDVCtnVm1SWDc0ZTNkd2dKOGRv?=
 =?utf-8?B?Z2g3L1JlZ2dlVkd4TmVCNkJuR1BXQkczbXNETEJFNUZBckh6dXFhRnh2SGoy?=
 =?utf-8?B?WHcrVHE5T2libXRibFE3RERjcTc1QWt0WnBGZVBTenZVcDNMVjJ5WFlaU0hm?=
 =?utf-8?B?VXhRckkxZysrbzk2MUJzTWxaL1Y0NDg5QW04UmFTSEd3c3R5a1pQczFaOU5P?=
 =?utf-8?B?OTJxR1NpS3VQekkwWmlpalBuY1U2aDNQRDRlMDNCTkljVnZCNEhuVktZb2dD?=
 =?utf-8?B?UlFmQjZBUHhOVVRQdW1YUEFoVFp4eDNZaG9rYUd0S3lrQmtZOWZSdy9WZG4r?=
 =?utf-8?B?UmZtdlRIMGV3eXR2UktsOCtYK0EyT0JBa0Z5cGVTNTR0bjB2Y0Rqd2VDVTFn?=
 =?utf-8?B?QlFXSWg1TTUrdktCNlhHdzBPZGRQZHRQU3V4RTdCMUtMbzZBd0l2SFhJM0oz?=
 =?utf-8?B?SjhuZmNQVDNYMTQvRnhUV1QrRzFGM1B6KzI2dFVjY1dIZ1FJNndwTE1ZN2la?=
 =?utf-8?B?TThNeGptQnQ4ckZIbWlKYVhPTWFzWEh5UnhLWDkyMVhPUFBBMkVnSnRRbHNn?=
 =?utf-8?B?bFdPYmc1UmtKamFTTG56SXdRZmhvRlVlemhhNTh0QUZhRHpQMFNSSi91bWJ4?=
 =?utf-8?B?elBub2lWV29ZMUtjbklSOEJOYUNrZ2NhdWpjdFp4NXJHdG83R2ZoNFFHeXpp?=
 =?utf-8?B?SllsbUI3cWRJSFdtbFZ2Qmk0RTNnYTA2R1B2UU1vS1Fmd280WFJ4UjM1OFFq?=
 =?utf-8?B?alF5a1VRNDluNVBiK0JFazEzSGU2VUFUY1pxamFpQVovWGZ2UWpVYWhsU3FK?=
 =?utf-8?B?SmhZcERCL1o2THBSLzUwVmpJeUpDVW9tNGJETG8vOWF5QzNmUmVObGRvRkNa?=
 =?utf-8?B?SzRROWppOFI4Zm1ENFdFZHloUGtDTkI2U25iK09keWJDU3NrU25ITzJhWFZG?=
 =?utf-8?B?M2JhZi9Na3RDeVNHb0ZSRjRndVdsZnVNbmViTjFpVXo4U3NERWJpNzhzelZl?=
 =?utf-8?B?MktqdUtzWHhua0xFVERkc3pNMEl2Lzl3c2VudWs5Rm5KdGlyUGlUcHdzSGRZ?=
 =?utf-8?B?YmFLU01tNG5kUzBBdU5GTUJpd2FON3RuWk9weTJUak05MTVvaFRkVmdCaC85?=
 =?utf-8?B?NXJaSEcwZXhsVEpTc25odTNndW1WYzN5TUlMSFZmODhJdWlubGlubzFLcE5a?=
 =?utf-8?B?UWJMSjZuWDh6dytRTnJ3eVl6RWY0Z3BDN01xNzB0ZWFzYldyUkorYWtyLzQ1?=
 =?utf-8?B?ZjFmRXF2d2FBMnFaQVoxWThDRlNoMld5dmxoY3E3ZzVqTDZwWlV3QlRDWDR4?=
 =?utf-8?B?QWxIYXVhWEVhY1FHcVdNdG9MN2hqNE5GZjhjNGF3WFRTeStpYTBsR0NJWjRi?=
 =?utf-8?B?QXJnejQvNTV6MlFjM2RlZzVkVXN5MWdRWldCRXdyOVcxaklVTERGN3o0N3B2?=
 =?utf-8?B?RXFBa05wT0VWcjZISFV3L3VXUmhZSnRoNmdFMmVrU0dUbVk2U0s4ZUJ0RHhh?=
 =?utf-8?B?c2xxYzRabEF3WFcrUkswMDZwYndkdy9kVFdTaXdRQ3B4OVpnVkpXMGxWbXpv?=
 =?utf-8?B?MWZ2L2Ivbm1Ybzl0eXBQQjhBYmxTL1NRcW1FMytDZVlyMjNKQ3VHNnUrLy9m?=
 =?utf-8?B?eDB5WWhkSmdiSUVDdkdwMmZDdkZRS0FtUCtHVnNXaXBRUXVFa3BOQUJIZHRt?=
 =?utf-8?B?YnFiTSsyc3BiWi9aWW1UTlljS1FOelRCdytleW1GclMwLzRSV0VDc3kzVTJr?=
 =?utf-8?B?SkFoWFJWTEpQaXcvOUczUDhkNHZ2Z2lYUUNldm9zcDRvZjNZR0E2bTNQL25q?=
 =?utf-8?B?NjM5UXpjMmtCaGxaWHVERjhiZW05cHpiRXlsbS9tMkdoQkdHVDVkTytEYnhM?=
 =?utf-8?Q?d+cDDa4qzIzJMyKOBRtU2rklo?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b68bb7-149d-4ca9-f7a3-08dcb5e0dcf2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7472.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 06:27:36.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdD7L22BfRnttMSnZ3DfLALYW0rYby9SyUBwJs3940o+55trmubsDcKWShUJ7ucHgxkaS/xsU5bF/Z/endfkgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8517

Dear Paul

Thank you for the review.

On 2024/8/2 19:02, Paul Menzel wrote:
>
> Dear Yang,
>
>
> Thank you for the patch. Some nits and formal things.
>
> Am 02.08.24 um 11:39 schrieb Yang Li via B4 Relay:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Add support for Amlogic Bluetooth controller over HCI UART.
>> In order to send the final firmware at full speed(4Mbps).
>
> I’d add a space before (. What is the current speed without the patch?
> Maybe also document, what firmware file took how lang.
>
> I’d welcome a more elaborate commit message for a diffstat with almost
> 800 lines. What datasheet did you use? Maybe paste the new log messages
> and document your test system.
>
Well, I will provide additional details in the next version.
>> Co-developed-by: Ye He <ye.he@amlogic.com>
>> Signed-off-by: Ye He <ye.he@amlogic.com>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   drivers/bluetooth/Kconfig     |  12 +
>>   drivers/bluetooth/Makefile    |   1 +
>>   drivers/bluetooth/hci_aml.c   | 756 
>> ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/bluetooth/hci_ldisc.c |   8 +-
>>   drivers/bluetooth/hci_uart.h  |   8 +-
>>   5 files changed, 782 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>> index 769fa288179d..18767b54df35 100644
>> --- a/drivers/bluetooth/Kconfig
>> +++ b/drivers/bluetooth/Kconfig
>> @@ -274,6 +274,18 @@ config BT_HCIUART_MRVL
>>
>>         Say Y here to compile support for HCI MRVL protocol.
>>
>> +config BT_HCIUART_AML
>> +     bool "Amlogic protocol support"
>> +     depends on BT_HCIUART
>> +     depends on BT_HCIUART_SERDEV
>> +     select BT_HCIUART_H4
>> +     select FW_LOADER
>> +     help
>> +       The Amlogic protocol support enables Bluetooth HCI over serial
>> +       port interface for Amlogic Bluetooth controllers.
>> +
>> +       Say Y here to compile support for HCI AML protocol.
>> +
>>   config BT_HCIBCM203X
>>       tristate "HCI BCM203x USB driver"
>>       depends on USB
>> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
>> index 0730d6684d1a..81856512ddd0 100644
>> --- a/drivers/bluetooth/Makefile
>> +++ b/drivers/bluetooth/Makefile
>> @@ -51,4 +51,5 @@ hci_uart-$(CONFIG_BT_HCIUART_BCM)   += hci_bcm.o
>>   hci_uart-$(CONFIG_BT_HCIUART_QCA)   += hci_qca.o
>>   hci_uart-$(CONFIG_BT_HCIUART_AG6XX) += hci_ag6xx.o
>>   hci_uart-$(CONFIG_BT_HCIUART_MRVL)  += hci_mrvl.o
>> +hci_uart-$(CONFIG_BT_HCIUART_AML)    += hci_aml.o
>>   hci_uart-objs                               := $(hci_uart-y)
>> diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
>> new file mode 100644
>> index 000000000000..cc6627788611
>> --- /dev/null
>> +++ b/drivers/bluetooth/hci_aml.c
>> @@ -0,0 +1,756 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
>> +/*
>> + * Copyright (C) 2024 Amlogic, Inc. All rights reserved
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/property.h>
>> +#include <linux/of.h>
>> +#include <linux/serdev.h>
>> +#include <linux/clk.h>
>> +#include <linux/firmware.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <net/bluetooth/bluetooth.h>
>> +#include <net/bluetooth/hci_core.h>
>> +#include <net/bluetooth/hci.h>
>> +
>> +#include "hci_uart.h"
>
> […]
>
>> +/* The TCI command is private command, which is used to configure 
>> before BT
>
> Used to configure what? Maybe:
>
> … is *a* private, executed(?) before BT chip startup …
>
>> + * chip startup, contains update baudrate, update firmware, set 
>> public addr.
>
> s/, contains/ to/
>
Okay, I got it.
>> + *
>> + * op_code |      op_len           | op_addr | parameter   |
>> + * --------|-----------------------|---------|-------------|
>> + *   2B    | 1B len(addr+param)    |    4B   |  len(param) |
>> + */
>> +static int aml_send_tci_cmd(struct hci_dev *hdev, u16 op_code, u32 
>> op_addr,
>> +                         u32 *param, u32 param_len)
>> +{
>> +     struct aml_tci_rsp *rsp = NULL;
>> +     struct sk_buff *skb = NULL;
>> +     u32 buf_len = 0;
>
> size_t?
Will do.
>
>> +     u8 *buf = NULL;
>> +     int err = 0;
>> +
>> +     buf_len = sizeof(op_addr) + param_len;
>> +     buf = kmalloc(buf_len, GFP_KERNEL);
>> +     if (!buf)
>> +             return -ENOMEM;
>> +
>> +     memcpy(buf, &op_addr, sizeof(op_addr));
>> +     if (param && param_len > 0)
>> +             memcpy(buf + sizeof(op_addr), param, param_len);
>> +
>> +     skb = __hci_cmd_sync_ev(hdev, op_code, buf_len, buf,
>> +                             HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
>> +     if (IS_ERR(skb)) {
>> +             err = PTR_ERR(skb);
>> +             bt_dev_err(hdev, "Failed to send TCI cmd:(%d)", err);
>> +             goto exit;
>> +     }
>> +
>> +     rsp = skb_pull_data(skb, sizeof(struct aml_tci_rsp));
>> +     if (!rsp)
>> +             goto skb_free;
>> +
>> +     if (rsp->opcode != op_code || rsp->status != 0x00) {
>> +             bt_dev_err(hdev, "send TCI cmd(0x%04X), 
>> response(0x%04X):(%d)",
>> +                    op_code, rsp->opcode, rsp->status);
>> +             err = -EINVAL;
>> +             goto skb_free;
>> +     }
>> +
>> +skb_free:
>> +     kfree_skb(skb);
>> +
>> +exit:
>> +     kfree(buf);
>> +     return err;
>> +}
>> +
>> +static int aml_update_chip_baudrate(struct hci_dev *hdev, u32 baud)
>> +{
>> +     u32 value;
>> +
>> +     value = ((AML_UART_CLK_SOURCE / baud) - 1) & 0x0FFF;
>> +     value |= AML_UART_XMIT_EN | AML_UART_RECV_EN | 
>> AML_UART_TIMEOUT_INT_EN;
>> +
>> +     return aml_send_tci_cmd(hdev, AML_TCI_CMD_UPDATE_BAUDRATE,
>> +                               AML_OP_UART_MODE, &value, 
>> sizeof(value));
>> +}
>> +
>> +static int aml_start_chip(struct hci_dev *hdev)
>> +{
>> +     u32 value = 0;
>> +     int ret;
>> +
>> +     value = AML_MM_CTR_HARD_TRAS_EN;
>> +     ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
>> +                            AML_OP_MEM_HARD_TRANS_EN,
>> +                            &value, sizeof(value));
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* controller hardware reset. */
>> +     value = AML_CTR_CPU_RESET | AML_CTR_MAC_RESET | AML_CTR_PHY_RESET;
>> +     ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_HARDWARE_RESET,
>> +                            AML_OP_HARDWARE_RST,
>> +                            &value, sizeof(value));
>> +     return ret;
>> +}
>> +
>> +static int aml_send_firmware_segment(struct hci_dev *hdev,
>> +                                  u8 fw_type,
>> +                                  u8 *seg,
>> +                                  u32 seg_size,
>> +                                  u32 offset)
>> +{
>> +     u32 op_addr = 0;
>> +
>> +     if (fw_type == FW_ICCM)
>> +             op_addr = AML_OP_ICCM_RAM_BASE  + offset;
>> +     else if (fw_type == FW_DCCM)
>> +             op_addr = AML_OP_DCCM_RAM_BASE + offset;
>> +
>> +     return aml_send_tci_cmd(hdev, AML_TCI_CMD_DOWNLOAD_BT_FW,
>> +                          op_addr, (u32 *)seg, seg_size);
>> +}
>> +
>> +static int aml_send_firmware(struct hci_dev *hdev, u8 fw_type,
>> +                          u8 *fw, u32 fw_size, u32 offset)
>> +{
>> +     u32 seg_size = 0;
>> +     u32 seg_off = 0;
>> +
>> +     if (fw_size > AML_FIRMWARE_MAX_SIZE) {
>> +             bt_dev_err(hdev, "fw_size error, fw_size:%d, max_size: 
>> 512K",
>
> I’d add a space after the colon. Maybe more presize:
>
> Firmware size %d kB is larger than the maximum of 512 kB. Aborting.
>
I will do.
>> +                    fw_size);
>> +             return -EINVAL;
>> +     }
>> +     while (fw_size > 0) {
>> +             seg_size = (fw_size > AML_FIRMWARE_OPERATION_SIZE) ?
>> +                        AML_FIRMWARE_OPERATION_SIZE : fw_size;
>> +             if (aml_send_firmware_segment(hdev, fw_type, (fw + 
>> seg_off),
>> +                                           seg_size, offset)) {
>> +                     bt_dev_err(hdev, "Failed send firmware, 
>> type:%d, offset:0x%x",
>
> I’d add spaces after the colons.
>
I will do.
>> +                            fw_type, offset);
>> +                     return -EINVAL;
>> +             }
>> +             seg_off += seg_size;
>> +             fw_size -= seg_size;
>> +             offset += seg_size;
>> +     }
>> +     return 0;
>> +}
>> +
>> +static int aml_download_firmware(struct hci_dev *hdev, const char 
>> *fw_name)
>> +{
>> +     struct hci_uart *hu = hci_get_drvdata(hdev);
>> +     struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
>> +     const struct firmware *firmware = NULL;
>> +     struct aml_fw_len *fw_len = NULL;
>> +     u8 *iccm_start = NULL, *dccm_start = NULL;
>> +     u32 iccm_len, dccm_len;
>> +     u32 value = 0;
>> +     int ret = 0;
>> +
>> +     /* Enable firmware download event. */
>> +     value = AML_EVT_EN;
>> +     ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
>> +                            AML_OP_EVT_ENABLE,
>> +                            &value, sizeof(value));
>> +     if (ret)
>> +             goto exit;
>> +
>> +     /* RAM power on */
>> +     value = AML_RAM_POWER_ON;
>> +     ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
>> +                            AML_OP_RAM_POWER_CTR,
>> +                            &value, sizeof(value));
>> +     if (ret)
>> +             goto exit;
>> +
>> +     /* Check RAM power status */
>> +     ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_READ,
>> +                            AML_OP_RAM_POWER_CTR, NULL, 0);
>> +     if (ret)
>> +             goto exit;
>> +
>> +     ret = request_firmware(&firmware, fw_name, &hdev->dev);
>> +     if (ret < 0) {
>> +             bt_dev_err(hdev, "Failed to load <%s>:(%d)", fw_name, 
>> ret);
>> +             goto exit;
>> +     }
>> +
>> +     fw_len = (struct aml_fw_len *)firmware->data;
>> +
>> +     /* Download ICCM */
>> +     iccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len)
>> +                     + amldev->aml_dev_data->iccm_offset;
>> +     iccm_len = fw_len->iccm_len - amldev->aml_dev_data->iccm_offset;
>> +     ret = aml_send_firmware(hdev, FW_ICCM, iccm_start, iccm_len,
>> + amldev->aml_dev_data->iccm_offset);
>> +     if (ret) {
>> +             bt_dev_err(hdev, "Failed to send FW_ICCM (%d)", ret);
>> +             goto exit;
>> +     }
>> +
>> +     /* Download DCCM */
>> +     dccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len) 
>> + fw_len->iccm_len;
>> +     dccm_len = fw_len->dccm_len;
>> +     ret = aml_send_firmware(hdev, FW_DCCM, dccm_start, dccm_len,
>> + amldev->aml_dev_data->dccm_offset);
>> +     if (ret) {
>> +             bt_dev_err(hdev, "Failed to send FW_DCCM (%d)", ret);
>> +             goto exit;
>> +     }
>> +
>> +     /* Disable firmware download event. */
>
> I’d remove the dot and the end.
>
I will do.
>> +     value = 0;
>> +     ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
>> +                            AML_OP_EVT_ENABLE,
>> +                            &value, sizeof(value));
>> +     if (ret)
>> +             goto exit;
>> +
>> +exit:
>> +     if (firmware)
>> +             release_firmware(firmware);
>> +     return ret;
>> +}
>> +
>> +static int aml_send_reset(struct hci_dev *hdev)
>> +{
>> +     struct sk_buff *skb;
>> +     int err;
>> +
>> +     skb = __hci_cmd_sync_ev(hdev, HCI_OP_RESET, 0, NULL,
>> +                             HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
>> +     if (IS_ERR(skb)) {
>> +             err = PTR_ERR(skb);
>> +             bt_dev_err(hdev, "Failed to send hci reset cmd(%d)", err);
>> +             return err;
>> +     }
>> +
>> +     kfree_skb(skb);
>> +     return 0;
>> +}
>> +
>> +static int aml_dump_fw_version(struct hci_dev *hdev)
>> +{
>> +     struct aml_tci_rsp *rsp = NULL;
>> +     struct sk_buff *skb;
>> +     u8 value[6] = {0};
>> +     u8 *fw_ver = NULL;
>> +     int err = 0;
>> +
>> +     skb = __hci_cmd_sync_ev(hdev, AML_BT_HCI_VENDOR_CMD, 
>> sizeof(value), value,
>> +                             HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
>> +     if (IS_ERR(skb)) {
>> +             err = PTR_ERR(skb);
>> +             bt_dev_err(hdev, "Failed get fw version:(%d)", err);
>
> 1.  Failed *to* get …
> 2.  I’d add a space after the colon, but would remove the colon, and
> maybe do:
>
>         Failed to get fw version (error: %d)
>
  I will do.
>> +             return err;
>> +     }
>> +
>> +     rsp = skb_pull_data(skb, sizeof(struct aml_tci_rsp));
>> +     if (!rsp)
>> +             goto exit;
>> +
>> +     if (rsp->opcode != AML_BT_HCI_VENDOR_CMD || rsp->status != 0x00) {
>> +             bt_dev_err(hdev, "dump version, error response 
>> (0x%04X):(%d)",
>> +                    rsp->opcode, rsp->status);
>> +             err = -EINVAL;
>> +             goto exit;
>> +     }
>> +
>> +     fw_ver = (u8 *)rsp + AML_EVT_HEAD_SIZE;
>> +     bt_dev_info(hdev, "fw_version: date = %02x.%02x, number = 
>> 0x%02x%02x",
>> +             *(fw_ver + 1), *fw_ver, *(fw_ver + 3), *(fw_ver + 2));
>> +
>> +exit:
>> +     kfree_skb(skb);
>> +     return err;
>> +}
>> +
>> +static int aml_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>> +{
>> +     struct aml_tci_rsp *rsp = NULL;
>> +     struct sk_buff *skb;
>> +     int err = 0;
>> +
>> +     bt_dev_info(hdev, "set bdaddr (%pM)", bdaddr);
>> +     skb = __hci_cmd_sync_ev(hdev, AML_BT_HCI_VENDOR_CMD,
>> +                             sizeof(bdaddr_t), bdaddr,
>> +                             HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
>> +     if (IS_ERR(skb)) {
>> +             err = PTR_ERR(skb);
>> +             bt_dev_err(hdev, "Failed to set bdaddr:(%d)", err);
>> +             return err;
>> +     }
>> +
>> +     rsp = skb_pull_data(skb, sizeof(struct aml_tci_rsp));
>> +     if (!rsp)
>> +             goto exit;
>> +
>> +     if (rsp->opcode != AML_BT_HCI_VENDOR_CMD || rsp->status != 0x00) {
>> +             bt_dev_err(hdev, "error response (0x%x):(%d)", 
>> rsp->opcode, rsp->status);
>> +             err = -EINVAL;
>> +             goto exit;
>> +     }
>> +
>> +exit:
>> +     kfree_skb(skb);
>> +     return err;
>> +}
>> +
>> +static int aml_check_bdaddr(struct hci_dev *hdev)
>> +{
>> +     struct hci_rp_read_bd_addr *paddr;
>> +     struct sk_buff *skb;
>> +     int err;
>> +
>> +     if (bacmp(&hdev->public_addr, BDADDR_ANY))
>> +             return 0;
>> +
>> +     skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
>> +                          HCI_INIT_TIMEOUT);
>> +     if (IS_ERR(skb)) {
>> +             err = PTR_ERR(skb);
>> +             bt_dev_err(hdev, "Failed to read bdaddr:(%d)", err);
>> +             return err;
>> +     }
>> +
>> +     paddr = skb_pull_data(skb, sizeof(struct hci_rp_read_bd_addr));
>> +     if (!paddr)
>> +             goto exit;
>> +
>> +     if (!bacmp(&paddr->bdaddr, AML_BDADDR_DEFAULT)) {
>> +             bt_dev_info(hdev, "amlbt using default bdaddr (%pM)", 
>> &paddr->bdaddr);
>> +             set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
>> +     }
>> +
>> +exit:
>> +     kfree_skb(skb);
>> +     return 0;
>> +}
>> +
>> +static int aml_config_rf(struct hci_dev *hdev, bool is_coex)
>> +{
>> +     u32 value = AML_RF_ANT_DOUBLE;
>> +
>> +     /* Use a single antenna when co-existing with wifi. */
>> +     if (is_coex)
>> +             value = AML_RF_ANT_SINGLE;
>> +
>> +     return aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
>> +                             AML_OP_RF_CFG,
>> +                             &value, sizeof(value));
>> +}
>> +
>> +static int aml_parse_dt(struct aml_serdev *amldev)
>> +{
>> +     struct device *pdev = amldev->dev;
>> +
>> +     amldev->bt_en_gpio = devm_gpiod_get(pdev, "enable",
>> +                                     GPIOD_OUT_LOW);
>> +     if (IS_ERR(amldev->bt_en_gpio)) {
>> +             dev_err(pdev, "Failed to acquire enable gpios");
>> +             return PTR_ERR(amldev->bt_en_gpio);
>> +     }
>> +
>> +     if (device_property_read_string(pdev, "firmware-name",
>> + &amldev->firmware_name)) {
>> +             dev_err(pdev, "Failed to acquire firmware path");
>> +             return -ENODEV;
>> +     }
>> +
>> +     amldev->bt_supply = devm_regulator_get(pdev, "vddio");
>> +     if (IS_ERR(amldev->bt_supply)) {
>> +             dev_err(pdev, "Failed to acquire regulator");
>> +             return PTR_ERR(amldev->bt_supply);
>> +     }
>> +
>> +     amldev->lpo_clk = devm_clk_get(pdev, NULL);
>> +     if (IS_ERR(amldev->lpo_clk)) {
>> +             dev_err(pdev, "Failed to acquire clock source");
>> +             return PTR_ERR(amldev->lpo_clk);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int aml_power_on(struct aml_serdev *amldev)
>> +{
>> +     int err;
>> +
>> +     err = regulator_enable(amldev->bt_supply);
>> +     if (err) {
>> +             dev_err(amldev->dev, "Failed to enable regulator: 
>> (%d)", err);
>> +             return err;
>> +     }
>> +
>> +     err = clk_prepare_enable(amldev->lpo_clk);
>> +     if (err) {
>> +             dev_err(amldev->dev, "Failed to enable lpo clock: 
>> (%d)", err);
>> +             return err;
>> +     }
>> +
>> +     gpiod_set_value_cansleep(amldev->bt_en_gpio, 1);
>> +
>> +     /* wait 100ms for bluetooth controller power on  */
>> +     msleep(100);
>> +     return 0;
>> +}
>> +
>> +static int aml_power_off(struct aml_serdev *amldev)
>> +{
>> +     gpiod_set_value_cansleep(amldev->bt_en_gpio, 0);
>> +
>> +     clk_disable_unprepare(amldev->lpo_clk);
>> +
>> +     regulator_disable(amldev->bt_supply);
>> +
>> +     return 0;
>> +}
>> +
>> +static int aml_set_baudrate(struct hci_uart *hu, unsigned int speed)
>> +{
>> +     /* update controller baudrate*/
>> +     if (aml_update_chip_baudrate(hu->hdev, speed) != 0) {
>> +             bt_dev_err(hu->hdev, "Failed to update baud rate");
>> +             return -EINVAL;
>> +     }
>> +
>> +     /* update local baudrate*/
>> +     serdev_device_set_baudrate(hu->serdev, speed);
>> +
>> +     return 0;
>> +}
>> +
>> +/* Initialize protocol */
>> +static int aml_open(struct hci_uart *hu)
>> +{
>> +     struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
>> +     struct aml_data *aml_data;
>> +     int err;
>> +
>> +     err = aml_parse_dt(amldev);
>> +     if (err)
>> +             return err;
>> +
>> +     if (!hci_uart_has_flow_control(hu)) {
>> +             bt_dev_err(hu->hdev, "no flow control");
>> +             return -EOPNOTSUPP;
>> +     }
>> +
>> +     aml_data = kzalloc(sizeof(*aml_data), GFP_KERNEL);
>> +     if (!aml_data)
>> +             return -ENOMEM;
>> +
>> +     skb_queue_head_init(&aml_data->txq);
>> +
>> +     hu->priv = aml_data;
>> +
>> +     return 0;
>> +}
>> +
>> +static int aml_close(struct hci_uart *hu)
>> +{
>> +     struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
>> +     struct aml_data *aml_data = hu->priv;
>> +
>> +     if (hu->serdev)
>> +             serdev_device_close(hu->serdev);
>> +
>> +     skb_queue_purge(&aml_data->txq);
>> +     kfree_skb(aml_data->rx_skb);
>> +     kfree(aml_data);
>> +
>> +     hu->priv = NULL;
>> +
>> +     return aml_power_off(amldev);
>> +}
>> +
>> +static int aml_flush(struct hci_uart *hu)
>> +{
>> +     struct aml_data *aml_data = hu->priv;
>> +
>> +     skb_queue_purge(&aml_data->txq);
>> +
>> +     return 0;
>> +}
>> +
>> +static int aml_setup(struct hci_uart *hu)
>> +{
>> +     struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
>> +     struct hci_dev *hdev = amldev->serdev_hu.hdev;
>> +     int err;
>> +
>> +     /* Setup bdaddr */
>> +     hdev->set_bdaddr = aml_set_bdaddr;
>> +
>> +     err = aml_power_on(amldev);
>> +     if (err)
>> +             return err;
>> +
>> +     err = aml_set_baudrate(hu, amldev->serdev_hu.proto->oper_speed);
>> +     if (err)
>> +             return err;
>> +
>> +     err = aml_download_firmware(hdev, amldev->firmware_name);
>> +     if (err)
>> +             return err;
>> +
>> +     err = aml_config_rf(hdev, amldev->aml_dev_data->is_coex);
>> +     if (err)
>> +             return err;
>> +
>> +     err = aml_start_chip(hdev);
>> +     if (err)
>> +             return err;
>> +
>> +     /* wait 350ms for controller start up*/
>
> Missing space at the end.
>
> Also, why 350 ms? That is pretty long.

Yes, we conducted some experiments and tests, and the delay can be 
reduced to 60 milliseconds.

Thanks a lot.

>
>> +     msleep(350);
>> +
>> +     err = aml_dump_fw_version(hdev);
>> +     if (err)
>> +             return err;
>> +
>> +     err = aml_send_reset(hdev);
>> +     if (err)
>> +             return err;
>> +
>> +     err = aml_check_bdaddr(hdev);
>> +     if (err)
>> +             return err;
>> +
>> +     return 0;
>> +}
>
> […]
>
>
> Kind regards,
>
> Paul

