Return-Path: <netdev+bounces-248593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F61D0C30E
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 21:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFF59300F1B3
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 20:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5E02DB794;
	Fri,  9 Jan 2026 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NrCfeZeR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B03126560D;
	Fri,  9 Jan 2026 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767991030; cv=fail; b=E+hiKQ8x3CuBCNRbNqe28kWqsdCquiN28T//FhrjOiLerFtZ0Voh4tY0ka27NX1k3iWu2ElMj+kSl4PHku3LLmSSf0MmE/0KLLsqeir7YEvPsiEOs7epChzQP+EmdWu8Bmlm2hjlEI+zLQouipwqL0SOCinNK0iIDDh1l5hi3lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767991030; c=relaxed/simple;
	bh=dZ1lhNPWkzVtHuWmlt5TXqiH/GNX6Nf6fX7IHXxG16M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ajqf8dQK1VWNds7jUqjaKvIyy9ysdAOmLH0KKcm2xgZxuEFn+QV+QTcxCh0Sf4Udzqpy8EhzAVW3B+aVyfqK+MYVm2HlEptykzzKf3zEJJnKRSN9RRP7FENpUxnlMjorb58Cvs88W8qFt7vnrlGx8tdtL+EDaxN5Hsxc1zTAkD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NrCfeZeR; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609HF98o234535;
	Fri, 9 Jan 2026 12:36:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=30g/bnkTrcYbJDbKECjiYxAXxHo3ZeI/sEIS1StMrq0=; b=NrCfeZeRCuMv
	/CXerAfOgHYIcLZcc/r+65z4W/fcIL0AJqBJLmoJ86VGv3WaIem9jCXNDyy7skCl
	xLetXVEz4OWKUtCvBPSfbmxEEKExYbexat/RoCYhYzATRAhTQpjHf7f/jI6VkU0q
	ibbPP9Nt1mx2SdcjJhVvJ+9WxNvyGCtsDvpuSXOhEmcyt9eHaVwxBWX63Evz0Crh
	wc5rXg86UY+23KSsqhff2udNZhNOLdHI/ex/sFOjdN6s7lF5amaJEPJaP4yTnLcf
	UV6alvI+hhO5olk4kVQMcDlsF8RMJQIzJj0TaniFe2MXjqhAb21j4h39RV9tZajj
	po6e6DsdIA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013058.outbound.protection.outlook.com [40.93.196.58])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bjvhwp1ky-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 12:36:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjauYlJ/Skkex04GX/odynarjSCpDJKbrG0WX6ypAsKSg7CIQz6u5JP8D7rDljxbUxRg4iA8uqj8kaKN1TI2iDTFjn7sty96ByoVEHifojaKJWUSOkRnRmFyH13UFBc8XzosRFlUGZdVFcZLixEX+6QL+5KNUSRQ+VkT6HnDUmR5Z9yYFpyBDLuViIpmq9qaiK6EjZalnpccL0DSQiusN8mpBsxqFHpPI6BwhYw7ORlI5eNvLle5uC//s1UTscU1R1GoQ/p55hh3nnNOb7SzvJEdy/mQVGk8zgd3JBgdcCRX9Grfz77fF6wgD62p1mIT7SWEATuHCd9ZYtXlOMSOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30g/bnkTrcYbJDbKECjiYxAXxHo3ZeI/sEIS1StMrq0=;
 b=Mui71q/K3oUb7WiCLTpwlGfFoWZ8A9Qva270neW0w+ou3U+MAi1CFSfAkTFfOwiBUdxgHL1VD191FDi2g3RAClimzjYiYlJkO6wLA0LjqSSmv2IPXYWgr3kzYl86SkMEtXdd+p/o8bHSuV2AEU4j4DiFoVaN6EWUodEtM1cp9Du3GYUup5n1eNm8T14fuYmfDgbaRvCojndiuD6Hx0XcXg4WXAwaqwHqaeQYwr/dBNtYPMt3P6bNDAnDunFvjcZ/WPqUDre0agmUXQjmPf3wN5emaoyE4mrvpa46Ncpc7CtEhUzE37QIkpQLkHeRWNgVr+Y0uy2bWvAtuC1kCTQFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by PH0PR15MB4461.namprd15.prod.outlook.com (2603:10b6:510:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 20:36:48 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9478.004; Fri, 9 Jan 2026
 20:36:47 +0000
Message-ID: <fe38f83c-25f2-4e16-945c-210ceb66b37a@meta.com>
Date: Fri, 9 Jan 2026 12:36:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio_net: add page pool support for buffer
 allocation
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        netdev@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260106221924.123856-1-vishs@meta.com>
 <20260106221924.123856-2-vishs@meta.com>
 <CACGkMEsfvG5NHd0ShC3DoQEfGH8FeUXDD7FFdb64wK_CkbgQ=g@mail.gmail.com>
 <bba34d18-6b90-4454-ab61-6769342d9114@meta.com>
 <CACGkMEuChs5WHg5916e=odvLU09r8ER-1+VXi5rp+LLo0s6UUg@mail.gmail.com>
 <20260109014836-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <20260109014836-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0077.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::22) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|PH0PR15MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: d4bdab23-9ede-40aa-0ec9-08de4fbececc
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?S1ZLblpOb2ZCN2pVL0FOMGNYYkV2V25ENVM2TmdJcWRvNE1CMTlyRXo2M0l6?=
 =?utf-8?B?bWlzZkJ0ajgrMEtKRzdiZlhrTHlwamxHbTg3UDk1UW9HcVpzV0kxMllXY1cy?=
 =?utf-8?B?aU1NU0xPdkh2VXNsZjdaWmlwRGlqN3BPOVFoamxDWUtudFVEZUNBZDl3TzNv?=
 =?utf-8?B?UmhtQXg3aHZGelAveTJpU2hiWlN3V1FGR2pnMnFkN2psSGg0T1ZQK0NjQnZ3?=
 =?utf-8?B?NlE0OVR2KytSbHpOYWdZRzhTRXJpK1MveWpLY1dxU2k1MHNKVUJXaDZwcGdM?=
 =?utf-8?B?dkZ2VDkxVVZ2UEhoSlJ3Vm9udkUxb0U3VVQ5b21COUhUME5tczBDUmU1eDVS?=
 =?utf-8?B?Y3pkWndoSGx6NUZuWXBJU0tSYmc3cUVFU0pZYmZrcFVFeGNncWlCdk0vdkQr?=
 =?utf-8?B?cnZheWJlM014OUFrL2pVT0kvS2x3T3RHS0lkeDd6MmF5MkhzYmN2S2xTYnl2?=
 =?utf-8?B?TGRPVWVYSW9IdTBHZ1R1NHl1NFg2b0ZJK09xcThDUlZ1MlhwTWJXZFo2OUpn?=
 =?utf-8?B?UzU1K00vNCtUUFJ4NWRQdTQyVDJOMCtaUkg0bXZhdDRKT1BRWG5EZHZTNzFp?=
 =?utf-8?B?N3BWN3RBNkNrd3p0VDlSSk9vSldnRmkyRGFIWnlUcGFRZWt0a0g1RXlFQnBO?=
 =?utf-8?B?MUVVTUZLTVFSM0M2aTk0YWxzWWRXN080eEd5YWRTRFRJNVQ3MTk0ZWpOcy9j?=
 =?utf-8?B?ZzNWZWZDdk1OMWhJQnJmaDZxUkZkMEp2M3lFTWl0d0hJeEh4a3dsMDJZaTdp?=
 =?utf-8?B?SnBrWmw2UkZpSWhTK1B0V1RkRERqUGN4Szg5WVdaYVNvdjZoVWRMMjc2UGR0?=
 =?utf-8?B?SCtVMWFIMHZiRE9SL1NFZUVpbnNDd3JzOVRHdnVwQnlndW5TSU5qOU5HZDlv?=
 =?utf-8?B?cStTeWJCbHc2dHBsd0JIRmJrNWJ1S2R2RmZOSkFCNUQxZWFhYUZsVUZBaTJP?=
 =?utf-8?B?Ung2aWZVM0MrdXc0TksrVHlkaEdrSFhDVFlyRjB1SGVkRmlDMjBwdlpGZDBE?=
 =?utf-8?B?SzlOWDN1eC85MnkzVlQ4Nnd6akdUOW9jZkhXRGFQOWhpYXNGZGZpRENESUNk?=
 =?utf-8?B?WHlTVFZVQnpDT2RFdzRIRUpkQ2ljZkNSbk50YXdKQ2Irc24vdFA3a0JtQ1l2?=
 =?utf-8?B?R0NRbm81dklxTGJhRnl2NnpPZ0RiQkFZbDJZY0dpZTZMZWZBSGlncGJtNHVy?=
 =?utf-8?B?Y21MN2FyRSsrQmNLejE3T283OUpTMUxOTmUzVklldW9qTGZkWUdpKzUzNGxi?=
 =?utf-8?B?T0taRTNVWXh5Rlk1V003VTcrTVpDQ0xCaitGemM4M09KT1kxQ2ZpblVvdFRD?=
 =?utf-8?B?N3dHR2JiNVkvRUJDT1RYNmpLdEFmRCtYUEtzK0ZrcmVyODRSQjBkV0s0SWFw?=
 =?utf-8?B?YlEvdUJFUDNiYU5hUkNiR3NRbHY2U1ZBWGZIUUM4Y0czRzJJZjJzQTNyVTNZ?=
 =?utf-8?B?Wk1qUFN1MmpYL1BOaG5YUlZ5U1lDS3lqRU5RVjdZUkxOWDRISVgrbHZ4U3Ns?=
 =?utf-8?B?MGFyWEFnUjlXK0JXcm9KL3ovRXFON3BTNUl2Nk0waFc5dmdpbjRyY2NTalZN?=
 =?utf-8?B?aWJpS1licFJqWHZiOWk1eVBmWFRuRXo2bkIvTmx2a1VOQkJLN0NUei9lQVpQ?=
 =?utf-8?B?d0o3MlY0bW9LN3RiUXBzQ2ZTUHpUa21tdVVSZmNOS0RmUERTNWczbXYvakhR?=
 =?utf-8?B?eFVtYkJxbzg1L2JpSys5RS9ENm4weDJNcG5VMTRGYkJjbHMvek5VRE1HaDBK?=
 =?utf-8?B?S1krVFBTejVlays1d09NZGdEbktJMU16R3p2d2UyejNaTEhoOGRhMldkTXo5?=
 =?utf-8?B?SFI2SCt2cXBsSk5RVWE2V0E1TWxhNDVXejgxWS9XYXdSM29JTUZiZXhEdjlN?=
 =?utf-8?B?MTNmWTFMWHVZZHZRTU5UZTROVStUdVhGUjkwM1YveHZKSThaODNxTldSSllv?=
 =?utf-8?Q?uhT7K4DyG+gThizvZHlFu7vA+zMRncbm?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?czFaTGM0cmU2b3NRUGNGNHpVbXIvcHRvWGhDSnJjV0k0U3JpZ3NhNDlCc1pi?=
 =?utf-8?B?b0FUMXhZQkRweGVXM3Rva0J0dlV3TlJrNWZHbFpETlh0OFM5TDJrbXJLYWhF?=
 =?utf-8?B?VzRXUk5ueVdUdnNKUm1OaHk4YUFvRG5xVmx1ZU5BWktIaUVOUmgvZ1hxSm1s?=
 =?utf-8?B?SGFaTnhNb29OVFFRQUZlci9wLy94VmYvSEdaYTRIL01vdjdJV2Qrc2ZLdDJx?=
 =?utf-8?B?VTB3U095SHp3ejN1ODBZdWQxeDRHd3I5dU5TaTVyeENmYUJNZTRBSG53WXpt?=
 =?utf-8?B?dEo2a0pxQ0U1VGphS1JHemVwUC9URnBlZCtNK1g0WEdGZE1QZGlxdDNFbzk2?=
 =?utf-8?B?bGc4OTVnaXBzN0tjSkdRT3h6NWZLTzl1aXFPYTdtMy93RXQzdFdNN3JqcFFN?=
 =?utf-8?B?UGFYcXpKQ2YyanBPc2ozUTBaV1FEVnRyU3ptY1VwT3BUWmo2emRqZ2FQQURW?=
 =?utf-8?B?b1NpdkoweStPS1BqQW13WTFlbjF0Z1N6RWN3Z2psdXlsQjFJc1duYWtXeFRl?=
 =?utf-8?B?dG5yT0ZnRElQVFE1MFpILzVRdDdzZzN3d1R1OWx2c1R4dTV1OUFSWDdtUUwr?=
 =?utf-8?B?THVta1VWQ2c2WDZzNmVFb1FvY0hjbm55Tm01d0xjUjZVWFpHSGZFV0QvNFNP?=
 =?utf-8?B?QnNwek5rT2p5SWFHbzV3T2VGcXVUZy9CK0hhNEJzWTdqckxha0pkckdiaTZo?=
 =?utf-8?B?SWhBdGpwZG52KzRWU2o0bWNEdFUrdG9TdGZYZnZTVmt2YTFpYjRBMW1ZcFpv?=
 =?utf-8?B?V3lXZnEzVW82ZUFYaUFVRTRxb1REZW02aXNlcVNmc0JSTGdYWUhrdTcrR3o2?=
 =?utf-8?B?NzNyQXdEd3lrMjlEVkhtR2hqbXRYM0g3MWRYaENqa0JZdXhDejJYWmxTQm9Z?=
 =?utf-8?B?MzZOQ1FzYkduajZ5cFU1ck41MkhCd3JrQzkrMXY4dGt2NnUxZ2krTTFsT3h3?=
 =?utf-8?B?d3FMY0JuWnNrMVcrWHhTSm13cHhhOHNhNjVRdFVXWW1FVll1d0k1QzBnYXBG?=
 =?utf-8?B?TTMwekhIdFdZL0NPa0R1SDljbTRBVFFseXJkYnB0clFsd2I5NUVmUHZzenVE?=
 =?utf-8?B?UHlXOUNxakMySUpocE5pUTM2SExwNHhQaWZyWlFhbDlNNGR0STM1TFpZUGIr?=
 =?utf-8?B?b2hqK1pWZUgvS1lyd0lsdy9XZE5yRlZqY0hoTi9ZVTJCcnFyNW1BZzJyMk5p?=
 =?utf-8?B?c1JrWUE3eFMwWW1wNDhXSEkwYk5qRVhCMDlYVzNqMDFtTk9hV0UxQVBnTFhV?=
 =?utf-8?B?V1BRVHBlNWFjTzZLNUYwWnRuVnJwZ291eUJvWWRVMlhWUkR4UmI5ZGV2MjN0?=
 =?utf-8?B?QXl5T1BXRWQwb0oxUEhmeFdrdlhZbXcyOWRvWWZhOFV1R3c3a3o5SFpFVHNB?=
 =?utf-8?B?R1F6NUpEa0wzcUluNXluMnlxTzRvRWljTS82a1VMYmRWb0dudEF2MWN4ZU1r?=
 =?utf-8?B?dFdUOXc2NHpGU1JGa0k3TUordW1iV1FLYURyVWtlbmFiVFlWZUpYLzJoMSs0?=
 =?utf-8?B?OFJub2ZhMFIwOHppRElLMnZuWnBEczBrajBIaWhBdmNESXhOanFibmMvWmpq?=
 =?utf-8?B?ZWp2SGJOanZiMEVZa0sxQWdDNmNzOFNXSzg0TGYzd3U0R3VNLzg2TDQ1SkNT?=
 =?utf-8?B?ckR3aFFFYlRyd1RDa2tKWXgwTnZPYy9zMmlmN2Uyb0s0ZW5Lb3c0aWNPd2pi?=
 =?utf-8?B?ZGQ3OTFRS0dVM2YrbXRpdE5yVnoxUTlOODV2aHhleXR0R0RUNzhrYWV5c1N0?=
 =?utf-8?B?M3lDVWxzZnN1cUlNTWVzS0o1eEtyL05VWTdVTlVMODJ1dDRFTmdBeklqSTgx?=
 =?utf-8?B?ZENtRXVBNld4U1FoWE1KYmRpR0QvTG9Qd2VvUTFPYU9lYjNDcllLMGNxVHhp?=
 =?utf-8?B?bk9xMHdaYmdHcHRpUUlaZWpVL3IxeEJ3Skc4b3ltNy8vSVpBVXRnNHBuaFJn?=
 =?utf-8?B?RURFR0VXek9ZM2Nlem84d3N3VUJ5K3E2b2VVQjk5R0tZMXdEL0dvcUpKUitv?=
 =?utf-8?B?cEZ5Z2FTZWVLMWxrblVFVkdsNVJsaUI4VlVvRThvZWNyUGJHU3AzZ0FMRENI?=
 =?utf-8?B?RXozZzlLRTlrcGRxS1QvYzRzcDR4NHA2NkRBUldPckl2QWVZZWdOTzBFQ25j?=
 =?utf-8?B?VDdwd2plUGhsZ29sd2JkNWVKc3g4bmRGYXhXZlYvZkhFZWNGTWdUVkpBVGdM?=
 =?utf-8?B?S3NhclVvVmZPOFBaZEhYSDJ6eno0dFUzSFdCT1l1TVYvTXp4dXd1YlYyUGN1?=
 =?utf-8?B?ZnZIWHkyQ3R2ZmZqWjZHbCsxUDNLSnNXNzVrTTEwWU9PN1VIaUdQVUhUaHN1?=
 =?utf-8?B?VjNGQzJ1RGIrQTVpUWFzanFSalgwZlgyQVpHeng5aldUL0JiMFEyVG8xYXhR?=
 =?utf-8?Q?WxN+TctIl4VV3HBo=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bdab23-9ede-40aa-0ec9-08de4fbececc
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 20:36:47.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvVq+7xwEKjSfofIc4XOP7tTx44XDkqnedqkTo5f/JNIjp2hSe7vsf8X+h32Yc6Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4461
X-Authority-Analysis: v=2.4 cv=Eo3fbCcA c=1 sm=1 tr=0 ts=696166e3 cx=c_pps
 a=5YU8ENXygJz5UkgxsLF+dA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=X3MPeX4CFakXC44E3DYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Rbka-HvNXJk06s86Zabr7EA5IJdh4DeX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDE1OSBTYWx0ZWRfXwM2ce6Ash2h6
 avtiMc8j4GFhQNLkrtiRt+j9nIK4NppXY0n6LI5G1jCFsmMM7BOM0fD6rUI7eb1VLnl/sDyHTPL
 c66GUYcN4cf7IRyR4Ipifnc3GPOrJyPrsR7iXrIqZoBsD4qr9UaQM8yloiNj+aizs+4GzS6NTSz
 vlRSH9/xUaLyfnFY3SBhsAzr5r4ZTTc+D9am9if53XvNAh6LdLKmeDDOOVcZli9SNRD4AD5eHyA
 dGMtpEKQcggkv1wnaPxLOGQauqd3tqWXOnRJnbv0pLSC9Pywnjm+Q3nZAt/hrnWpRSrfRDBHewQ
 857CZ8MLi2/W7EdvlF7mowUliBQpKih24FDG2ixV12BKlA/c7aNQqmwJox5wmURPRGxC3Pa4Lr7
 nWgyBcRdFYEF/ZnqL2F22BEBkZJI4Wy/t9qfgL2+JrnLDu4dnNE902KIChOaTYoRegZLLonfWmb
 AkNd66jAMDN69ulTvuw==
X-Proofpoint-ORIG-GUID: Rbka-HvNXJk06s86Zabr7EA5IJdh4DeX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-09_02,2025-10-01_01



On 1/8/26 10:50 PM, Michael S. Tsirkin wrote:
> On Fri, Jan 09, 2026 at 11:16:39AM +0800, Jason Wang wrote:
>>> My concern was that virtio has its own DMA abstraction
>>> vdev->map->map_page() (used by VDUSE), and I wasn't sure if page_pool's
>>> standard dma_map_page() would be compatible with all virtio backends.
>>
>> You are right, DMA is unware about virtio mappings, so we can't use that.
> 
> Or maybe we could add an API saying whether virtio mappings are DMA ones
> and then enable that conditionally? Because on some platforms, mapping
> in the pool can save *a lot* of cycles.
> 

I think virtqueue_dma_dev() alread serves this purpose? It returns the
DMA device when virtio uses standard DMA API and NULL when custom
mappings (VDUSE) or direct physical addressing.

This is the same check used by XDP in virtnet_xsk_pool_enable(), which
calls xsk_pool_dma_map(pool, dma_dev, 0) only when virtqueue_dma_dev()
returns non-NULL.

For v2, I'll use this to conditionally enable the PP_FLAG_DMA_MAP at 
probe to give us pool-managed DMA on most systems while falling back
to manual mapping for VDUSE.



