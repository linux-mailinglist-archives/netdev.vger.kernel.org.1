Return-Path: <netdev+bounces-165981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5491FA33D6A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6838316A1BE
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3A0214800;
	Thu, 13 Feb 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QkW7cg5P"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4B214227;
	Thu, 13 Feb 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444720; cv=fail; b=lg6IzzjK/O2KFDokRcegI+otPVRIYsFioEh+dP9JMcVfgIyVl0B56btphKz1j/76paLrmfeSQrP+ds/7a50KiD9i/ISW10wM2K8uhT82jqk83syH4fJ0iT0hmoQ+EwbcLW8nOBEz/S+UVvLjuLo0McB7BmOldVY+azYuNqpUo2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444720; c=relaxed/simple;
	bh=zmEyyqMHkqNeqn1zXcB/92BrjqGT92mOXwSLfDQ7SZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JLo4w2+SF1fx6YjGIPIH7Gu7m69bBx03btILy4BgXemigrsFAlF8BobIpeNc14JjgT41ha5lfYhKWzow6/ZObJk02l3NamqBVr2XGdCQLg2VkTaBuNNUI++gQXRZEXb87W+2zwyj7eKLu9iROVcnSIc2rAA/sJXJeSZOp9/8aAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QkW7cg5P; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qV4/EiYVYvLpM9dHCpvGAuQCV25v9RpfN9SZ1yahGm2HjIyG7llmsBv5mlcDS5pHHvI2GcySXDJ7QEzZekPw8vJTWyaoxXLrxe1HePb/sjvqRZORchd8IiG+mqxBqS2RUQvyhRircExqjiELOyxGh6hKcxI5M8WW0AWz+KciSQJFFtVX0okkkkb6SsF6F4ZjsVRs/Km99s+H2hrBChgtskVK+wDG/VaSSeWkmfpQqPds4pMai1mp5ptTRsIKYZ2DhLAg6GwjrQHsv3GxScVzoZw5XyWNEq/QUvAGjULrJ3H2Bi4ZZk0obK8qzGehQ3XuyJzVEjpipWyd+yWNHQE91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3h6hMKnZrb0Xjr2smmlfXtuC/KqrCTx9D+tgw06bCM=;
 b=Z4rBWzjvOz5JD/nIYgcahSjHXMxDIlHndKHVuacv0SZWc2EUPIL5scuTAU2w2hbdqfJnRXRu2VeNrvAEpQckg34HmrkHFQrvcAmfWFPZICyawsHyuUtMbbs+uNrCAYfBQTYfstZbkWJIvyKFtqTvVmecytzPPoxJ8xafFs+0znIPvJTFdB0t1WX1hDy9LSj5fCu88hXYcTV5Dc0tS75sxrYNEBU7ILCVjPb0Gt7PJZH6ecVNSltHW5X6F3bZDBqtYtN5vWTBAXQoVNE1bK2O71MKKs9eLhOXaoFhNX4GMH/b+TqFeP5dZqsOr+1pPALkF8Ty9mexDQlORrhrl0EGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3h6hMKnZrb0Xjr2smmlfXtuC/KqrCTx9D+tgw06bCM=;
 b=QkW7cg5PYbpugGuX3lrIUQx2288PCguPu8BOt4dqp1/hP4v6RZIIMA4Piuhk75IZ/S34IKAiidf2gSL+EJikAUMKXGDbMalPweJ7yFtaqjjPvXwMtoKQR3gYH7H2rK2W2ZVnamKv1MCVLFUBw0LiHpf2+CRb68gKuKIcKnM5YdEtJpDTT6Ag/IzvOzxfSl6d/ALuXf1j2MBRNfe58LUn68Xdwu0E3ad+emV5/oMFxeKzS9BFDgdFgUsFfde5Kv5UgAJU1ndZXDMwLR/3GzilKACzvAfCFpdZKx1jXiHc8I/2HlyKjGFh/7tSIwTt1uM2GIKF5LLIwawgmZSbTJO7RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.16; Thu, 13 Feb 2025 11:05:08 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 11:05:08 +0000
Message-ID: <6ab08068-7d70-4616-8e88-b6915cbf7b1d@nvidia.com>
Date: Thu, 13 Feb 2025 11:05:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 9/9] net: stmmac: convert to phylink managed EEE
 support
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
 <E1tYAEG-0014QH-9O@rmk-PC.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <E1tYAEG-0014QH-9O@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0127.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::13) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ca038d-225a-4efe-81ff-08dd4c1e46eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDlZT3oxU0JBU1RaZVQrR2RyUGRwZ3k2UWphZU1Pd2IwSmh0TEFSdWQySG1I?=
 =?utf-8?B?RUJBZ05hdWpjaWRFbGdvNmMxditQZ0tadWNFYmNlVlVNYXdUUUtJS1lyZW9G?=
 =?utf-8?B?OWFFVlFTZmVCZVBPaWVuc2poNXdjSmppT01iSGdKbi8vNHhFdVFrN0lDdkpE?=
 =?utf-8?B?aWJKVWdWancyTEFZSDl0UzY1NkJTVEZTU2RXd010dmg3bUVVZEY0UjUyUGhB?=
 =?utf-8?B?NU9WbkJVSW14T202RHNnZ002Zi9QVGE5OTRjamZCS0ZBQ2VhaEk0Z09aNjgw?=
 =?utf-8?B?a3EzYnh6YzA3bmMxWkxpMDhTQkxLWWZnSm5kY3RqZTFuMkpQekpnd3N2Tk12?=
 =?utf-8?B?SEYwb0VCUHpFTWFnNm56SSswY0Nadm5RM1FENkZ6bUpreUU3T09ScXJFOTVp?=
 =?utf-8?B?QW0xakI4VFZNZlZ0QnZ0eGFhbHdlRkxBUDJyMTBaMlcxek9XQi9VRDdUWlVl?=
 =?utf-8?B?cUI3M1BLZ2p5eWludWRYS2J4ZVZLcWFLdmtSN240Mmx4czZ2dDNCY1kzYXFh?=
 =?utf-8?B?c1FmUWwzaDdVRHA4R2pOenBIdWExTkJTM2ZuaUxUU2h4UXdnTHZVZjdsY1Fp?=
 =?utf-8?B?eUIzdlFrOTYyZzUzbVdFMjVHV0IxWDRnSVQvN2ZES0o5Q1piT0hGRVlKb3Vl?=
 =?utf-8?B?V1VWb1BZNEEvYzFQdUx6TVJTcG5XcWlIWHovUnR0TEozRVZpNkRORk0rZ1Bs?=
 =?utf-8?B?cTYyeW5iUzJneW5VUE4xNk1EMThsbDFoaHFoczlGMVlQN0Z6RGJXOVZsWEg1?=
 =?utf-8?B?cHVJUkZ3Tnl2ZGVqd1puSlU1dFduWTRRcjlQWVBrRSt3SDZhMHBaRWl3L3Bm?=
 =?utf-8?B?cS81eE9rUk5uVnMxQm1KQ2NOMEdGWDUxNHpSOFFMVGd6S3JGSXdQNnFvN1Ja?=
 =?utf-8?B?ZXZUZlpwNExCVjZOLzZSM1QzTWFvN01HajFnTHQyWEN3SU1iSzI4NnVtOGNh?=
 =?utf-8?B?bWx3bXRmL3FxQ2dlRVI2ZHB6R1ZMKy9YbGNhRThEKzF2emU1RUhVM2tDYkYw?=
 =?utf-8?B?cmJNdnd0SmxtS0NxWjErL0I0Y1IvVkI4QmE1UjVZczlwWGFVdW5WcE1EbnhH?=
 =?utf-8?B?V0VjV1RadXYrTnRZWnQ4SFZWWHJiSnVTVnQ1Sm5lZjdqRHRYZm1Pa3BsSEZo?=
 =?utf-8?B?MlZ2dU9uTUYwYnJwWnZucmtWWlFBbmRkSzNBdU92NlMvMGpDMlRPS0NaYWM0?=
 =?utf-8?B?bDRKRW9rcWhiMXp4RTZ0TVlZc2tScUl3N2s2UVRvUndiMng3b2pPa0JlV05K?=
 =?utf-8?B?SWpGc2sxOFdMZnlGdm1DQ2d1MU80WFRyMWtBeVFTbisyeFRoNGIyRmN5bjg4?=
 =?utf-8?B?dTEyMmFIS2JXYXJONDB5ZjVpSXZyOVYvTHlDNGtZczVueGYrNnRuUk5ZZGpJ?=
 =?utf-8?B?dG5HTHRmdXY5OFp2QVlGUDRldjJ2R0JpUU11SEo1UmhzdWs1NCtSQ2NDN2Q4?=
 =?utf-8?B?czlYYUxab1R0RnQ3aEtQRmVtbFFoMTZwR1luTGxIRFNXckZrV3h1ZlpkVFNQ?=
 =?utf-8?B?UGFPZ0kycjUvKzlGUGhOeERUcDVEK0pHdFJoN05tbkcycE1MS0J6SzM0UjE4?=
 =?utf-8?B?WTZSVno2UkpKRUJRS3VXdmtodGl2aTNKMHQ2WXNCbDNHbGRHRks1bXdrTnNY?=
 =?utf-8?B?eWVKZjRSaHJtVnowUEV1aFZ4MEw3U25aN2d3Y1Q2Q0Z1MXFtTkxMRndURGZK?=
 =?utf-8?B?WDdjLzJWUDVsTWZ0VTk4d1FzYVJlQ1VwSTBTR2FqYzV1MVl0amNJaVo0Nm1k?=
 =?utf-8?B?L3NDb3d3VnJMUWYxUnlERHFqMDZNelZlUjRwWGpJdjBkT0xxYXVTblhMZ1pI?=
 =?utf-8?B?Z1VoamtobmdFckQzcWVzdERud24wODF6ZUFoVlh6U3hwZ0xBRWhMdEd5MXJM?=
 =?utf-8?Q?VMYZ3VP2yM2bk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzUzSVpQQnJGVXROWnMwQUVrTnV1dExTTHZkUkpTaGMrV29QM2ZvU0lzY2JZ?=
 =?utf-8?B?ZWtYTkxJR0QxS3hGbjlUT1Nod2FlaFBkWXVJb00xWkdWK2tyL2tQWXVhSmVs?=
 =?utf-8?B?YXVlQ2FLTE05clp2L2R5bUdRZU51YlErM3oyMHN2TzVTMkpPNExVbWlCdFVs?=
 =?utf-8?B?cFg3dGx1TmJtVk5Oa1gvUHlPbUY0TEtldnVTaEpkVHFkblNTUHZEMnc2QzZv?=
 =?utf-8?B?YlRyc2NpeXBmRWdaaS9PdlFERWZmTmorS0lRcXZMRWoyT2RZWGZaMnNUVElp?=
 =?utf-8?B?bVBYaHlTK1E5ekRSVGdCT2UwZDRCNFhOQWxYbTA5N3h2Z2pFbUN4NllLSVNs?=
 =?utf-8?B?cTQyT3g5cmdya2pXTFczeURPSWRzcUJ4bzNya1VZSVFQTjhlaHE1QUFkbXVl?=
 =?utf-8?B?bC9mdDF6N1F3KzduTVJKNmx2K00xSEpvMXl3YUNBY1V1SVd5R0pwU0hmWS9G?=
 =?utf-8?B?UE5zdXVhZWp0ZmVDSXFWV1lacS9SQnZMbDlISnRWUVZhbHhTRE5IKzJOYW9v?=
 =?utf-8?B?K2lSTUZ3SktacHc2RWtPSzYrR0sxSWRHVWEyNC9zRTFyTTRzSUdGTkpZdjlC?=
 =?utf-8?B?OXdDdTlSdDdpZG15dVN2R1ZtcFBNYjFKa3F2dTgyRWc4RzFmWjZEZVB2Qk8r?=
 =?utf-8?B?VzQ5VWNSSFNVU3F4dVZWSyszck5GZ3BEZGZEbFVWdnBYUjZiZUVjZG1Fc1FM?=
 =?utf-8?B?aDg4dDE0VHZ3NGl0YzROeXJJTCtGc3QrbnVRTDBVYVFKWHR1UUIrT1NCQ3R5?=
 =?utf-8?B?Q2JqVis2Z2tDd0wwaEhlZU1qS1pIYmNSZGZ1eVdoRXc5dFc1ak1CVGtTTElB?=
 =?utf-8?B?RGZJMWpqdVFnU21JQWtCd1BiTUdkWktFQUphT1p1cGtSaFkveExhRG1PSUVv?=
 =?utf-8?B?UVNXL3pBZ0FYSGl5c1Q0eklLVzBrbEpGWFZBMWZDZjQwbFVKSGgySDFPSC9U?=
 =?utf-8?B?MVZmMU5ISTFGVXJONGRqNmEvRTdjTkQ5aTZLeEtOa0JBa2l3anJFWTZZSisx?=
 =?utf-8?B?dzFjQVV0NEx1ZXlsWTZUWDR2bVVQaURIeURjdFZweXpwUHJubHA4QWNTeXFS?=
 =?utf-8?B?b3RZdFBZUkQyRzFmc2kzNU9BUHlOZ1RSOWdhUG00U1ZkaWtOVFVud051Y1p4?=
 =?utf-8?B?UEpTbjkzOEZxY1hxb1NwR0kwa0d5NUg1bzAyVTRvRjg1SkFwV21UL2dNei9x?=
 =?utf-8?B?V1JZV0Zsc3BJNmZFQzZnT2RjeEZUOE4zM0NYMnVhd2NNWVkzNzNVZHNPUWM2?=
 =?utf-8?B?dzNpbEU5ZTl5b1IyTTFXWVl6UzBsUnY0MXZ5TVkxZmRqczVzZGNSek43YXBj?=
 =?utf-8?B?TmxVUVFSeWgxRUtiN0FwRUxIYU1lak9NajBLcWVrQ3orQzQvMVNEanRrWmxY?=
 =?utf-8?B?MzBkQ0U1VDBXcTNyblpHblpkWG8xeldtV0NENHB2Vjk3QW4xaHF5d3Z0Y1Vn?=
 =?utf-8?B?VDNnZGwvVTJZNGZSS20xYWpzaFFVb3V1YUxjVmE1bGtTTjlTUXVCcVY2b1R0?=
 =?utf-8?B?a1R0NmpFcW9DZ3RaOFlqb1lRUUsrcHRObERMQm82dGFETHhKMW5STCtjSGV4?=
 =?utf-8?B?Rk9nVUVZaUJMWTRqRGNQanAwd0l2Ry9qV084QWI1N3pSd3lqTjRPQVh1T2Nu?=
 =?utf-8?B?bVVWcVBPTHZLam1KQTJzU3lMTmtoMWlpUnBpSmtEZHg0ZlhmSHZISkZ4clp1?=
 =?utf-8?B?YTdQR2k3L004dHNoQ1B4anplOFhpVlNpTWl5NytBZ3Rpb3RCbUhIdjZ1UDFP?=
 =?utf-8?B?bnpLQ1cyeG9MWFg2NDhiRjFienMzUkViTEtwbGxkNDlYUFYxNlFDcU9mYlk3?=
 =?utf-8?B?K3ROMWc3WXdsSkRsS3p4NmxEWHFzSXBHdmVnZjNxamhQKzBZTi9EWEtSMlR0?=
 =?utf-8?B?Vm5CUWhmMWhKKzRMbFZ0VlBncFVTVHBrSVY5OTBLYlBGRDRKSUpEaUdqZEow?=
 =?utf-8?B?dnN4Q0hmWGw2S2c0djVsOUhNblU3R2Q1RXV4YTdHc2NMYUxlZEJRakgxRVll?=
 =?utf-8?B?Rm5qb3QzZXRVbDB0dzJ0SDRhcm1SSUVhVmJ5T3N4RTFYVnA4TjUvbDN5UG9U?=
 =?utf-8?B?SEwzZEJJNnh6NVRhZkd2NlpTR1ZuRGZuNTFUUW8wZlVFbW1xblZqVWt2VUls?=
 =?utf-8?Q?yZp3Md42+7uTFHD4QKM3Vv51s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ca038d-225a-4efe-81ff-08dd4c1e46eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 11:05:08.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+ZzVHv94B2t+h51M3gHMUo1wCbt/8AaSkj3FDeWRZ8pnjdJwlZHUaKABxVqiM9hU3awlhdZhiTL5fl/APrQAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289

Hi Russell,

On 15/01/2025 20:43, Russell King (Oracle) wrote:
> Convert stmmac to use phylink managed EEE support rather than delving
> into phylib:
> 
> 1. Move the stmmac_eee_init() calls out of mac_link_down() and
>     mac_link_up() methods into the new mac_{enable,disable}_lpi()
>     methods. We leave the calls to stmmac_set_eee_pls() in place as
>     these change bits which tell the EEE hardware when the link came
>     up or down, and is used for a separate hardware timer. However,
>     symmetrically conditionalise this with priv->dma_cap.eee.
> 
> 2. Update the current LPI timer each time LPI is enabled - which we
>     need for software-timed LPI.
> 
> 3. With phylink managed EEE, phylink manages the receive clock stop
>     configuration via phylink_config.eee_rx_clk_stop_enable. Set this
>     appropriately which makes the call to phy_eee_rx_clock_stop()
>     redundant.
> 
> 4. From what I can work out, all supported interfaces support LPI
>     signalling on stmmac (there's no restriction implemented.) It
>     also appears to support LPI at all full duplex speeds at or over
>     100M. Set these capabilities.
> 
> 5. The default timer appears to be derived from a module parameter.
>     Set this the same, although we keep code that reconfigures the
>     timer in stmmac_init_phy().
> 
> 6. Remove the direct call to phy_support_eee(), which phylink will do
>     on the drivers behalf if phylink_config.eee_enabled_default is set.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 57 +++++++++++++++----
>   1 file changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index acd6994c1764..c5d293be8ab9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -988,8 +988,8 @@ static void stmmac_mac_link_down(struct phylink_config *config,
>   	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
>   
>   	stmmac_mac_set(priv, priv->ioaddr, false);
> -	stmmac_eee_init(priv, false);
> -	stmmac_set_eee_pls(priv, priv->hw, false);
> +	if (priv->dma_cap.eee)
> +		stmmac_set_eee_pls(priv, priv->hw, false);
>   
>   	if (stmmac_fpe_supported(priv))
>   		stmmac_fpe_link_state_handle(priv, false);
> @@ -1096,13 +1096,8 @@ static void stmmac_mac_link_up(struct phylink_config *config,
>   		writel(ctrl, priv->ioaddr + MAC_CTRL_REG);
>   
>   	stmmac_mac_set(priv, priv->ioaddr, true);
> -	if (phy && priv->dma_cap.eee) {
> -		phy_eee_rx_clock_stop(phy, !(priv->plat->flags &
> -					     STMMAC_FLAG_RX_CLK_RUNS_IN_LPI));
> -		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
> -		stmmac_eee_init(priv, phy->enable_tx_lpi);
> +	if (priv->dma_cap.eee)
>   		stmmac_set_eee_pls(priv, priv->hw, true);
> -	}
>   
>   	if (stmmac_fpe_supported(priv))
>   		stmmac_fpe_link_state_handle(priv, true);
> @@ -1111,12 +1106,32 @@ static void stmmac_mac_link_up(struct phylink_config *config,
>   		stmmac_hwtstamp_correct_latency(priv, priv);
>   }
>   
> +static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
> +{
> +	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> +
> +	stmmac_eee_init(priv, false);
> +}
> +
> +static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
> +				    bool tx_clk_stop)
> +{
> +	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> +
> +	priv->tx_lpi_timer = timer;
> +	stmmac_eee_init(priv, true);
> +
> +	return 0;
> +}
> +
>   static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
>   	.mac_get_caps = stmmac_mac_get_caps,
>   	.mac_select_pcs = stmmac_mac_select_pcs,
>   	.mac_config = stmmac_mac_config,
>   	.mac_link_down = stmmac_mac_link_down,
>   	.mac_link_up = stmmac_mac_link_up,
> +	.mac_disable_tx_lpi = stmmac_mac_disable_tx_lpi,
> +	.mac_enable_tx_lpi = stmmac_mac_enable_tx_lpi,
>   };
>   
>   /**
> @@ -1189,9 +1204,6 @@ static int stmmac_init_phy(struct net_device *dev)
>   			return -ENODEV;
>   		}
>   
> -		if (priv->dma_cap.eee)
> -			phy_support_eee(phydev);
> -
>   		ret = phylink_connect_phy(priv->phylink, phydev);
>   	} else {
>   		fwnode_handle_put(phy_fwnode);
> @@ -1201,7 +1213,12 @@ static int stmmac_init_phy(struct net_device *dev)
>   	if (ret == 0) {
>   		struct ethtool_keee eee;
>   
> -		/* Configure phylib's copy of the LPI timer */
> +		/* Configure phylib's copy of the LPI timer. Normally,
> +		 * phylink_config.lpi_timer_default would do this, but there is
> +		 * a chance that userspace could change the eee_timer setting
> +		 * via sysfs before the first open. Thus, preserve existing
> +		 * behaviour.
> +		 */
>   		if (!phylink_ethtool_get_eee(priv->phylink, &eee)) {
>   			eee.tx_lpi_timer = priv->tx_lpi_timer;
>   			phylink_ethtool_set_eee(priv->phylink, &eee);
> @@ -1234,6 +1251,9 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>   	/* Stmmac always requires an RX clock for hardware initialization */
>   	priv->phylink_config.mac_requires_rxc = true;
>   
> +	if (!(priv->plat->flags & STMMAC_FLAG_RX_CLK_RUNS_IN_LPI))
> +		priv->phylink_config.eee_rx_clk_stop_enable = true;
> +
>   	mdio_bus_data = priv->plat->mdio_bus_data;
>   	if (mdio_bus_data)
>   		priv->phylink_config.default_an_inband =
> @@ -1255,6 +1275,19 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>   				 priv->phylink_config.supported_interfaces,
>   				 pcs->supported_interfaces);
>   
> +	if (priv->dma_cap.eee) {
> +		/* Assume all supported interfaces also support LPI */
> +		memcpy(priv->phylink_config.lpi_interfaces,
> +		       priv->phylink_config.supported_interfaces,
> +		       sizeof(priv->phylink_config.lpi_interfaces));
> +
> +		/* All full duplex speeds above 100Mbps are supported */
> +		priv->phylink_config.lpi_capabilities = ~(MAC_1000FD - 1) |
> +							MAC_100FD;
> +		priv->phylink_config.lpi_timer_default = eee_timer * 1000;
> +		priv->phylink_config.eee_enabled_default = true;
> +	}
> +
>   	fwnode = priv->plat->port_node;
>   	if (!fwnode)
>   		fwnode = dev_fwnode(priv->device);


I have been tracking down a suspend regression on Tegra186 and bisect is
pointing to this change. If I revert this on top of v6.14-rc2 then
suspend is working again. This is observed on the Jetson TX2 board
(specifically tegra186-p2771-0000.dts).

This device is using NFS for testing. So it appears that for this board
networking does not restart and the board hangs. Looking at the logs I
do see this on resume ...

[   64.129079] dwc-eth-dwmac 2490000.ethernet: Failed to reset the dma
[   64.133125] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed

My first thought was if 'dma_cap.eee' is not supported for this device,
but from what I can see it is and 'dma_cap.eee' is true. Here are some
more details on this device regarding the ethernet controller.

[    4.221837] dwc-eth-dwmac 2490000.ethernet: Adding to iommu group 3
[    4.239289] dwc-eth-dwmac 2490000.ethernet: User ID: 0x10, Synopsys ID: 0x41
[    4.244020] dwc-eth-dwmac 2490000.ethernet: 	DWMAC4/5
[    4.249042] dwc-eth-dwmac 2490000.ethernet: DMA HW capability register supported
[    4.256406] dwc-eth-dwmac 2490000.ethernet: RX Checksum Offload Engine supported
[    4.263768] dwc-eth-dwmac 2490000.ethernet: TX Checksum insertion supported
[    4.270700] dwc-eth-dwmac 2490000.ethernet: Wake-Up On Lan supported
[    4.277063] dwc-eth-dwmac 2490000.ethernet: TSO supported
[    4.282401] dwc-eth-dwmac 2490000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[    4.290293] dwc-eth-dwmac 2490000.ethernet: Enabled L3L4 Flow TC (entries=8)
[    4.297309] dwc-eth-dwmac 2490000.ethernet: Enabled RFS Flow TC (entries=10)
[    4.304327] dwc-eth-dwmac 2490000.ethernet: TSO feature enabled
[    4.310220] dwc-eth-dwmac 2490000.ethernet: Using 40/40 bits DMA host/device width

Let me know if you have any thoughts.

Thanks!
Jon

-- 
nvpublic


