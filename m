Return-Path: <netdev+bounces-132704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D6992DCC
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90ABE28112B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1341D27BA;
	Mon,  7 Oct 2024 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uoV2dFmf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D117B4E9;
	Mon,  7 Oct 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309068; cv=fail; b=DMK2LosNRGqmlHcLYEn0fS2oHE5+mS9IWjdTTs/pUJ1TgH20JiygT3srIGoy61KBbwEvRzpsDc9wuTh2LS7CjmC+9Pcu3LWOS5TEg85JUji7iYTVDGYJ+9UUxN6PsdWL27YO1WxBVXgunp+XkTdbdwWFZ02d6/xK57r2eOWxkxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309068; c=relaxed/simple;
	bh=vfr/rN6AI/m2/ijTYJTM6MmxRHeJlyRdyOJMsgWVeuM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RO6r6RPPt7iDcmXP8IUxyhdSYTNc1uZ7lWnyGKbfqfZm9cacdEUuLezte6Wd6NXiaJDGa2La5Bv4xo/JvqWe+L0Vy7S1LCBpPEIA+h+HOi0pHpP0Ya2L8DVVaGiF3BZN3aMFySrixXpfuQCAOUAJQ/LRrFme14Y0BoKPGWaJNO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uoV2dFmf; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgWEMYT/scc8HZiimquDRXfvs/1Iy2rQfX9xZvZjLzoevvdLCB6csYfokMsyS+ydUuYnOzP20ct74iwau6zn06XM5Ax4tHYS7OafdUGVnOcEBw6Ys6NJs8AaI6A0Gl6T1uvqzpjA47ymZe9+qNsrY5HzhbUzNraEt2xJeFmYlIh08Jz2OZMhskkF5in4wz5LwMRQNcBLOa1dPuUTGTl4+MgI2Yn8bQjzNXGL5ds86Bw6kFZLlvfFo2vNLyfOP80cijHVHCCqP3y7DJppEsWtdfMLqBj73ljQnuitOD8kl+MJdQczZEd0d670rolTsRWtrFGMHFLXhX955AvgrT9RUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vacQsq2/QhnwmZIHgMPtvni7bWNPSGn0QtCXZYTCsoM=;
 b=Rkoi7WaTwhBwLlI0iduNGc/nWNAoOjVEPzvn6o4JBCGd/mWzNdhGAnVJo3VONffHUCPcYiBHe3YUqwwcidEcfK7Q9EX0IcqhWZA7TwYSFn/LQKV15Uq34crilYOfyaOmrKJeIyxMhpyw7rkewFGolKRku7FPZtZFwqHpADbmQzSHXZpyHUzaM0uAo5uYMqKhQ57NH0CadiCtU9zLpWxafftc9KFtqTqugAjvuheFgFp8Bic5xnrgGcDLSqxhZ1OG7BDPbem3Nij+zbGGVh2IDnHGgwES7vKac8C3DmLOPpuotPCk8GBo9q6QxXV6h3FJDmXRs3WKteZqOHv4QqvdiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vacQsq2/QhnwmZIHgMPtvni7bWNPSGn0QtCXZYTCsoM=;
 b=uoV2dFmfT+BqK5OQbpFKxe5AobydRvc+CCYWPjWzXihToptW+8IICL+TTc4/YloQiMDpTrnJn8pP8lcEASCnmo7yCyQgbL2sWVREI+Th8HHSKWEDYWNOTEPYUAe4ujI585F9cRs8B5WYU30q4v9iaRVzzxHPnc+1ifoyEYPe0DMC71xSYzgtxOwzcgK+VXJexILZro9fR4k7AY0/iViVQlFRILPndNuJCGRN6rZj1L0VpoC1tyLx/UEjVKIeVy0r9VBbA9R64YbAUDyTqyqd+BK11NH1XmGzp8MI9qg6P7usna7X4FRnrmbomTJ/6VkeVFCJZCalrR/c4wKYBqWa6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 13:51:04 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 13:51:04 +0000
Message-ID: <27e70746-ffdf-40fa-a335-bc6e59e7266f@nvidia.com>
Date: Mon, 7 Oct 2024 14:50:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: dwmac-tegra: Fix link bring-up sequence
To: Paolo Abeni <pabeni@redhat.com>, Thierry Reding
 <thierry.reding@gmail.com>, Paritosh Dixit <paritoshd@nvidia.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Bhadram Varka <vbhadram@nvidia.com>,
 Revanth Kumar Uppala <ruppala@nvidia.com>, netdev@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20240923134410.2111640-1-paritoshd@nvidia.com>
 <qcdec6h776mb5vms54wksqmkoterxj4vt7tndtfppck2ao733t@nlhyy7yhwfgf>
 <6fdc8e96-0535-460f-a2da-cd698cff8324@nvidia.com>
 <7485182b-797d-4476-b65c-7b1311d99442@redhat.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <7485182b-797d-4476-b65c-7b1311d99442@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0004.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::9) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e28b816-3b4a-4938-a9e6-08dce6d7159b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnVjV2xLcU9hMDMwQ1EzTU9kT1grZHQ0dFpLdnVDVWdieUJyd2lsazFaUEtC?=
 =?utf-8?B?ODNpVWh6aDVvdy9FT1RWY2R1U254dCtOdnVUWWlGcXozbERkTjY4V2R0eElE?=
 =?utf-8?B?cUF4ZHFGS1pydnphVWpubkZIZ3RVaktmejg0VWdSQkNLaTlCaGpXNkIyTlQy?=
 =?utf-8?B?QzA4U1Z3Uk5KU3JYdTR1WXJURHVzS2tMbnBDdGdlSWtCaVYrRm5rRGQ1aEFK?=
 =?utf-8?B?SXRTZXYya1IwMCt5Tmd0YXREanpKRWE5dFNxTkxENW95VHZpSFkvR0pCZTh4?=
 =?utf-8?B?OW9LV2ZodzJyOWt4NkhUZk15MjdkSWFoaFo4c1NSNVh5cUNqZHAxb3lvbG1s?=
 =?utf-8?B?U1pFaEl0dlB6cThHdFdqaWVsMWhiV01tcFk3VmVKUEdic2U4ckoybnJNUExK?=
 =?utf-8?B?Zmw2WmZuMjdqLzEwTTJTVEgxQkxuODh5Z3VLeWVKS09sajcrcTFBQ2FyK3ht?=
 =?utf-8?B?N2VvNzdyalh5UFhDVGQ3RWs1MXZrWVV4ZVZCcWtEM3RDNDdkS0RWOFh4bmxN?=
 =?utf-8?B?ZFpJZDZOVC9SQUJMRWhUMkV2TnUwOEh3RXowM010ajFWOFpCS1ZIc05UM2Z4?=
 =?utf-8?B?RTFMaHVMT3I3dlV3d0JXUVByZ1dOMzhXUzl4NFhvZE9BN016d2tnR2dsMFI3?=
 =?utf-8?B?YmpQTm12TEFUamlIVUFrYStnQkVldkxmSDlFeDBsWGRuMERpNFh2SlhjVFpI?=
 =?utf-8?B?VFVycEdOVEROV2VUWDBvOTVuaURiU3ZQQ0JPenp1WFhhVUtDZTMrbDlQNEMx?=
 =?utf-8?B?RWNIK0d1R2pnTGQ2ZlQ4MFlyUXBQZTUybmxEUi9yMUgrMnVyeVUybFhKdFhI?=
 =?utf-8?B?cENZdnFweGE1S1FCMVRuMk55TnJRRTN1czk4Q3k1Vm5rOXp6RFdESGVOYVNH?=
 =?utf-8?B?THNwWE4yNmMvdXYxK0lIdVptUjdXWFZEbWVYUTg3amw1eVAvQ0cwb2hnWEdh?=
 =?utf-8?B?ZTN2ZVVoT1hHT1JQc1QxOHB6dENwUHQ3UWQ0QTFMMEZFY1k3RWlNMGx1SWNj?=
 =?utf-8?B?NU1WMFMvZVh4Q3FUQzREWmNaMmJ6b3diU2F2dFErWXRTL1RRR2o2VTl6TGQz?=
 =?utf-8?B?em9xWHQ2WmU2TTZFanFWQXpyVnFyTTh2RGFJVk9GRXAwQ1Q3OU1qdWtxd3hV?=
 =?utf-8?B?UmV1ODU3RzZ4WnpyTGI5Q1BGUWhJK2tOcHAxYmRGMk9tOHY4VGJJeVJ1cG0w?=
 =?utf-8?B?aU52UldUYVNCOU51dEtMaUdxdHJ4TFh5YjdLcENVZ1Ixa1g5R1EyeUpTUEc2?=
 =?utf-8?B?NlpYVWZmZ1ZBQlVQclVqUVhCNkpYeTNza1g1QmJibFRTNXM5andpZG51QTNY?=
 =?utf-8?B?bEplcmNlS2JWamJKci9XWFBsbmpkN2JreWQ5NUZTYUloRG5IcVdVTGQrMTQ0?=
 =?utf-8?B?WGdwNUdwSkZ4MkxKZUY0SUQ4WXA5dG9rckRGNWpnakpVSTM3OEZFNzdUS3BF?=
 =?utf-8?B?eTZRZ0pPUnFEMDZIQWdOakYxd3hzSzdSOHlZS0VlY0FwZWRybzQwOTFDclJk?=
 =?utf-8?B?MVdncDhkK0llb29EY3FLSHBoQmlsSkw1NFZoL2hSVWIyTnVNN3VxNFlUQUhq?=
 =?utf-8?B?SGxBbEpuckJnUU56Q2MvQ0dMdTRSRlFRUWVUSWd2dFdTWFJSSWZtSWdFbER0?=
 =?utf-8?B?dGhXd3FjRXQya0VXelAyQzhuWko4WjY4a2tzUHRuUFFqcXo5czF0OTc5MFI3?=
 =?utf-8?B?a3RTdEVuaDZlTGpicy9qb3czVTJFQTZtK0JlbjM4VzNpNmkzSjJzR0lnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkovenR0MXVxY3lsbm1MWWVESEZnZnd1Q05TMkZRWGFiS3BwQzZxQUkrUEY4?=
 =?utf-8?B?OVJnT0pxQ0VzaVoxRkU4OXFuYmtmZitXdk1jck54c1N2NnVGNlZ5cHU5M21F?=
 =?utf-8?B?SytMWU5QcTFsTEZEMGNJaHp1dGNLdlM1WkZFMElicVZTUnl1U1lFNFNKVEdJ?=
 =?utf-8?B?bExDTFpTS2llOHdIbnpPaGVSZzhoeW8zSlNjVGQ5bDIvT3VxamFqMmtkSHdh?=
 =?utf-8?B?OEI1RFdwY21waXBGaFEwMTR3UXFiS3pFN2dTb1NqdmhoemNXUGRoYkQyM0xH?=
 =?utf-8?B?RmpLZVlaMXVLclkzM3NFMllGYmZKK3RSWjBFMW5uaGRONEs4MzJYckxkV05I?=
 =?utf-8?B?S3BsR1B2L2NqMTBMTFZBdFBaSkF6Wk1sYTAzV3RNRHc1QmFyYWVHaEhUSGIr?=
 =?utf-8?B?bndHRFp2MkNLTzVtTWxTZjRTYVNFKzREYUdFa2dJQTdOOVN6REczTGQ4T3Fh?=
 =?utf-8?B?NVVCZWZZOHRaRVV1Y2N5WkRwNVRYWkRsY1RFK1Z3UnhydWhkV09jNGFWSlJY?=
 =?utf-8?B?YTlHR25xQjdhMU9JZW5XaHBvalFrTmdod1J4TnlrZU9YTnVWU1o2Q0pYejBv?=
 =?utf-8?B?bUZMU0dNSXk5M01ySFBGeW1VNlk5cDdGVmpjeHJzU3ZGOWFFMEpJUUY5WXBu?=
 =?utf-8?B?MHIrdmo5QS9zajhVVTR6bnlvbjBlamxxWTM4RllmdmZEb1RScWRuODlSWVMy?=
 =?utf-8?B?QmJQVFpqUG5BWWtQcWJab24wakpGTFZkbnlUYkJVdDZKYi9PNSt4aFV4Y21o?=
 =?utf-8?B?ZVpEcXk1RlFnM2hmeXhKTjAyek5wdEZQeTh4bHFUeXpDb3JSVGl5WEdSWkIz?=
 =?utf-8?B?cHdtclZtejRveHNTcXhST0UwRFRBSmRndmFjNzRSMUxpZGU2QlBwZi9kemVu?=
 =?utf-8?B?UjlRazUrYnNCYTNWNDhMZHU3SFp4MFI4NWJzOFlRRnpLZTRkbEE3UndKYVl0?=
 =?utf-8?B?VGdCNEdxYVpsdVNmekU5eXhEQmczNnVvenBqcDZwcElDUjZ4N20vOEZ5aTdp?=
 =?utf-8?B?Sk8rbEFQUHhsaEVZMzR5YkQrSzR1Nm9uSmxTdjZvWGp1TmZvR2orQzhVb09h?=
 =?utf-8?B?VUhBMi9XbnBVYVN3Y3pjUjFPTEJDR1ovODkvbU9ycCtJTWI1TmFKemV2S2lW?=
 =?utf-8?B?QzArZGpSQ1F4WHhFNnZTMGo4K0FUajVmYk9IWjkya2s0MUdiSHlpVHNHNU1D?=
 =?utf-8?B?UmxOdU5hdWFvc1J6T0pvakZkK094dHBxZkE3enpRQm1LMFdMbHNOWEdCTGFQ?=
 =?utf-8?B?UHRwVElJcVNwMVpnRGlJOHhyWk8vZVd0LzRENFp5SXBTZ1l0bWpsSUlUODFp?=
 =?utf-8?B?Q3dUMTY5a2VZSWNGbERoSnFJYVpMZW5qM2JuVEtBUjdtN1hjK3lVeUNpbklF?=
 =?utf-8?B?NytPSWNKKzNubnNtT1U2QXNpdEJmWUpDSXFVS2UyK1Nra1hMd3dXNWVya0ly?=
 =?utf-8?B?M0l2WVgycXBnYzliWlRvbXF4ajVLUEVxUGJOS3BMNE9seVc2MEJKK0xTSGZ2?=
 =?utf-8?B?ZkVSdUNOMkdsRHphcDJLalpaNE1LOEROWitmWWRrTDhKc1VqbDVWYmRQcEMz?=
 =?utf-8?B?MCt6Q3BSNlFlcjkrRk9FZzBiY2RzTy9HZkJFU0s2djc3UktYNGdQOVZWQ1I2?=
 =?utf-8?B?Z0dvcnNVUEVzbWJxT25mSW5vL2F0ajcxN2ZWemFzM0FYL3V0OWxPcm5PTDVI?=
 =?utf-8?B?UkJ6Unl0V1YvN3pGSkY3aDZzdnlJdlYwbWErbFltcGV0T3VtVzBqdHdzYzVV?=
 =?utf-8?B?eWR2MUNHaGN4M3FKL295b29hOUp2QkhPZ2xPd0FtUnZySENoRmRjNVQ5anVF?=
 =?utf-8?B?WnpUZ1czTmJlUjdBY3krYW1ZVmxuQlV4VlZ2cVhGODVuemlYbVU1NWpoQ3B6?=
 =?utf-8?B?eXQwYTNnQW5BQWNMYWRwQ3NMd3B3TVZDdE16UnYwd3lrZ09hZmo2N3QxdWs2?=
 =?utf-8?B?bXFHWVdieUFMVFpKZEwrZTFibnFzbVl5WHpOYnFCQTQ3dHA4TVhJV2pUZWRI?=
 =?utf-8?B?a2k3cFF4VFNCOUN3ajZOQkZOQW56WkFHWGIwNG5pR0cvOFM2M1J1cTlncXow?=
 =?utf-8?B?TnNBQys5WXk4WjhYUW5OdndzM0pLT1ZyVGw3WGtBS0tKNG15aVQ1NjE0NlZH?=
 =?utf-8?B?T0lERnBRVkhHVmNFb3pmZUtsSnBJTnNFaGo4MG9wS0syYjVldnJ3Mndudngx?=
 =?utf-8?Q?3NVAo2J5uGR6gW/vQwvSDErGaYoaT8wxCdE6k3ENxy0S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e28b816-3b4a-4938-a9e6-08dce6d7159b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:51:03.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSKHvgsDSZTyzERFbyqOCvw0aQieITV5q4AsYdeyf4/+e/rkM3RvvFMlagkHWF76U15q1TZtgWCwZvsRUrHJTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414


On 01/10/2024 09:43, Paolo Abeni wrote:
> On 9/27/24 17:28, Jon Hunter wrote:
>> On 25/09/2024 14:40, Thierry Reding wrote:
>>> All in all, I wonder if we wouldn't be better off increasing these
>>> delays to the point where we can use usleep_range(). That will make
>>> the overall lane bringup slightly longer (though it should still be well
>>> below 1ms, so hardly noticeable from a user's perspective) but has the
>>> benefit of not blocking the CPU during this time.
>>
>> Yes we can certainly increase the delay and use usleep_range() as you
>> prefer. Let us know what you would recommend here.
> 
> Use of usleep_range() would be definitely preferrable.

Thanks for the feedback.

Thierry, let us know whether we should keep the 50/500ns ndelay() or 
switch to 10-20us usleep_range() as per the kernel documentation for 
less than 10us it says the typical guidance is to use udelay.

> Additionally, please replace c99 comments '// ...' with ansi ones:
> '/* ... */'

Paritosh, please make the above change for the comment style.

Thanks
Jon

-- 
nvpublic

