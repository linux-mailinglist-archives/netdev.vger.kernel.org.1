Return-Path: <netdev+bounces-122857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68356962D3F
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C56D1C20FD6
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D30718DF8A;
	Wed, 28 Aug 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uCaVfZFq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E67E574;
	Wed, 28 Aug 2024 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861173; cv=fail; b=DwOmSuHViGwMgtAS3ELeENjsSimSkNMQvzBfPF+b2gT3ekqzk+MmMpFue4U2gsVBL/gv9T7GMJkpF6L78bxqSNQg/4mrJTqEQzJ1YA8vx8Kp9a/6RKZasXmZFJr4kmSDdgN9nzkWKz+nHsbCpH2zNjxK34BA1KofXfOIU7yujJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861173; c=relaxed/simple;
	bh=MObUOL7jaPvdgEZjukSvaGIQ56F4yYk407NJyThyAQo=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SPpdMhF7jbP1qqAQM2IRNrfudDGxUFUmYaqzqCy5VCQFx78QtF61KfKY7W7Rz0L5x8O/5LQsqQDuJQ7SktmRBL9+wkkRFUYIYTggIpWJUrqfxRG1rays/cPhVSQfRAzwsmLyePJVBUsB53R4MGpynFK/XeMSubcYHB788wr05nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uCaVfZFq; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNw1q7QhH+l4W4B3ClJFlNI9Oz+aHwjSZOeaWU1Hgz7YX+uGsuLiaHONA9JqLkbSXI3++kDkNuMhN7zl22ViTyP5dB6EUN+JHxHggCY5TCQAd7UyQm//kQFrsJYozdN/MqLNK2A49wJHw6wOUWLr807UbjmrX1YMXNvdJQpnDZ0IW2/Fof4jv3aCqMcDZz9TgAUoB4ZpCXVGgIELlY0OB2JoLk8dI8UH/KfyNQmoHasO4R54kdszlQrYHSVqGPjfOr5b6B8LuXGx9gVOANXqrfOFp9NFm+13JjXXt749CCd6aGebM3tLpCgIeNVjI4JtDQdwPH8xtySCH7j74px76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJgBU35XwpqZ7Bst2lDA4a8V61g+L6P95DOGG5QauXY=;
 b=xBL6NUIBX9NqDUSzipQo4AHs8c5PE7B/g3i6rLcM9cnKi949616K9B5BDHC5XwDWxq32T9Ydyt9vjSde9Ezc5sb7FewBK85Vz51GEmt5fb2PS/Psfh5N0Fz40yYPo1wVSu5uJB7tOjQv+y0KBJ9YtY8aeGKHvkXhkxX/KhBa/YIUfWuQ6FxmToPFEdoE/zEfN7K+P1nWN3cPTbixH2I8HnIpvqdqWS75xiRPVjO1FzfU2+7oAFxwj0RWI8JXfYhaRb3JJQA3yM4YgBvlafYp0FwSJ07U3BPax2JVPeeFo6DaaNPvS5R/HDPKad7egPiAVMiPWaYnA3XpfDUoJHH/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJgBU35XwpqZ7Bst2lDA4a8V61g+L6P95DOGG5QauXY=;
 b=uCaVfZFqCubOmKNHaraxdn6qrOVdjKEgzlw1aCjb52tlwLBRk8ucULI0aCWXieRoNhBzdm6Zs+nwFPwEEVGT4ovLHbA5awd/IVqYQII+75+iUkdFtZuC1Qacbw1tp9qLhqQ5ahJS9YFRpPY5ireJNeHwZyADbwcVoV/f3FmtoOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 16:06:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 16:06:08 +0000
Message-ID: <3d97e89e-09ec-01c3-787c-0164c611cc4c@amd.com>
Date: Wed, 28 Aug 2024 17:06:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 11/15] cxl: make region type based on endpoint type
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: "Li, Ming4" <ming4.li@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-12-alejandro.lucero-palau@amd.com>
 <1f082012-1ad6-4b12-8eb4-96bcc61704a0@intel.com>
 <1cd50929-35f5-d0f1-9a68-d22e28cdf1b6@amd.com>
In-Reply-To: <1cd50929-35f5-d0f1-9a68-d22e28cdf1b6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b23269-e131-4bc0-9f36-08dcc77b5409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXE3WTlFSXQ5U0IrQlk5K2tkQ1BERW5YUk9hUzVDdStpZ2pOc2lNa1NwcXFG?=
 =?utf-8?B?aUhRTDhVdWtwa3ZWcGptTjExUmVkeEprL2hRcFlGTEJ3c3hzS0FGMjdVQk0v?=
 =?utf-8?B?VXJMZGE2eXI0ZStxZjhscEZacTFUQ2dKaGxsblQ2UlZ6STc0TmhHRXZvZXFF?=
 =?utf-8?B?MUplR1ZZczhaSkJSK1pJa296VkNobXJrM2JnelJ1ZjBwODE3emlOWlh6UDhu?=
 =?utf-8?B?b2JQNXRoV1JTUmxHQkZ4V0llemZoTWcxVkRQSG9oOE5oZUdFM1ZIb1AyVDd0?=
 =?utf-8?B?ZGNxelNrZ2Nodk5USWJhb3RkeitCeUZkRHBTQXN0M3lRc1laa3hmNklhR1Yv?=
 =?utf-8?B?bGpKanVyYUFCWVd2dWJEYUhqMTB4OXBxMDlZNjZFbWhpVnAyYXJZeEphZmNm?=
 =?utf-8?B?VFhEb2lKbDM3L0tCeGRMS1QyZGF5cUViYkR5ZXhSazUwZG9TTGY3aVlMTXFD?=
 =?utf-8?B?NUlZQngwY2ZpVVVETkdBVjdLYkU2SUI5dndkcjBNU0ZPWkt0eUZxY1RCSmRI?=
 =?utf-8?B?VXpFVXNXb1BQR1lySms2aTNidG5wV0liRzhwNzRkdU4zaTR2WEZDcHlyemJZ?=
 =?utf-8?B?N3pQYU1ndUVPUWIwY0tkelhKSWNRUjlPUnBBSm1jcm1QMXpJanF0VzFCQTd0?=
 =?utf-8?B?WHg3QWRjdnpEb3A2dHBNWUgyN1VpUWZ2a0RtL1NocHVmcHNZR0hpbXhpU1Zu?=
 =?utf-8?B?UnVSUXlvdnFwenNMdVNkSHhzOUtKY1NVTWlEenRWeERVTFRiZk9UTUNPYnUv?=
 =?utf-8?B?QXZINHZpYzVqdTFzL3p3VzRQQUFsdFhpU3JuOFEyWFVXVmk1Zi9rblJsZk1G?=
 =?utf-8?B?NGhFZFFQU0phQUNuRDUybjNDQW93SDNPcVUrVFlzOXMxNjl6eUVqem9JTTZl?=
 =?utf-8?B?SWdIMjdqVEpKZS9nR2l3d2ZiSWxuRFl6QmhzTUxjSEg0QythZC8vMFNTeTE3?=
 =?utf-8?B?VjJBdHhlcC9zM1BQUCs5TUF4NDZrdHN4bSt3STVNZjV2Sm51RmY1WlNNZ0Q3?=
 =?utf-8?B?b2ZadVdvTTZIcmkyNWdFVGdhQzZQVjdIUGVZRHV3SnlKdEQ4TGU5RnVUTjMr?=
 =?utf-8?B?WHg0TFllMmhZYjRuRjdJdGl3aC81K0dUSE9hcFFLTlIvaTFDNWNvVVFIY3Jm?=
 =?utf-8?B?U3o3RUcxczdhR2R3Nk9VODJVSy9NUHliTTZKTzkxN1hVSGtNZ0hITEdhd25w?=
 =?utf-8?B?Q295eEl3K0RjRFJhZC84L3kvM01YNzkxeXhXT0d4c2RXUUx4WmYvMGxFdndU?=
 =?utf-8?B?YVg5UjFwc0FKbmdSbE90QTU1OUJISnRQYktBcWpDRUlRaGIxQzhKeE1maEpj?=
 =?utf-8?B?ZG9GczB1NVVQSzZHd0MyQ0dGSnVsWndGRTdQeGkyOStQVjFpSzVpRVBOYlBh?=
 =?utf-8?B?VkFwT2xhdmxtTXVwZHNBbUt4bGFEMm9Eeml2dWRDc1lDcmNsWnNwbFF1a1pK?=
 =?utf-8?B?NExsTktibnk1NzlxVnNGL0tTT2NOcjhhUzNhb2J4YU5UUk1VS3U5NFk1SlY3?=
 =?utf-8?B?VmNEaXFseXRNTElaUkNXTFk5OFV6SStZVEtaaUdmY1hxYng3SlVLZ2J5bFAy?=
 =?utf-8?B?VExheUtNR01lTmoyMEk4dWV4NmEwSEpCdWhOR1BDWDB2ZFV1OWg3ZExlUnhY?=
 =?utf-8?B?OGxQYUZORUVlcGRYWGdLcHhPVG45a2ZsMStDR1VraE5xS1Q3QTdPRlhiQjN0?=
 =?utf-8?B?UFRNbEp1UG1oTGF5c0V3aE5JTTBtZHhySzZEbmdZZHRtTXB0YmRsNkNBWEtZ?=
 =?utf-8?B?MGtUOTBOQjdUK3haS1FvMVdublpTQ1VkamRCbG5sMkd2SzFKWVhBQXlPSkxv?=
 =?utf-8?B?K1lCemdJdXA0L0g1VFlBWTNJL3JnMFFSVlVCVjZYQ0xqazNnclJmYlRRQ0Jw?=
 =?utf-8?Q?mxEIs/oCMUXzA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGFBVURjdktYc3dHM2lFWWZjNXVGaFE0Tk5KYklBckdzMHFDUmtNME80czNl?=
 =?utf-8?B?YU8wcHE1NnNmMEZYaHhlYTFBNjhNME43NDdNdDVwbWhDQ1R3MjB0KzBLTFNw?=
 =?utf-8?B?ZW9RYXJJTktRVE5yM1N2UytXVnpIRGhOclk0SmZSVGRYVUN6UG1mbUpYWHpS?=
 =?utf-8?B?SHhVTUFGUHUvVU8yUnJ0bFdKaitYUm5LclpySFEwRTB0TDAzV2tMUjNCWXNk?=
 =?utf-8?B?ZjdxR1o2MWFBMkFKTEVZQjZRVjAxcjY0cyt3ZzJYcnFYNGNtUDlaQ0RnNlQ4?=
 =?utf-8?B?RUM1T01BUTRoczl1WFNqQzU5VDk3eTNOTHVMazU3NTZReVZxeU44aGpaTnJQ?=
 =?utf-8?B?Qk9weXNraG1qVDV1LzAwbzZtU3RMNG5rZk9McVlFOHpIcnFNOXBuRVgzVm1O?=
 =?utf-8?B?aHNMNzVoNXF0akpPWk52YXp6My8rR3NkanlmaFR4bzhLOGk4VkZXTytvMkNq?=
 =?utf-8?B?WmpvRGZKbXh4ODJjR25nR0tINEl6RzNSZVNkcDExRHhJR0JXQWVOa1d3Szg4?=
 =?utf-8?B?TWFQSy9XLzNsajUwaU9WTW5Yd0xNclh3MGpqNDlSQ0x5OGRpTkMzSTFFOGVR?=
 =?utf-8?B?aXhPQ01yVGE2b3oxMnAvcGhwaHlPVmVxeU91TVA1MG9jL0oxekF5M25FaG1D?=
 =?utf-8?B?dEtpdWxlNDVGeHhOWkp2ZEJycWhxM2xPU2dtN284YWJleWxhOEd1b0cvUFE2?=
 =?utf-8?B?MUJEeVk5ZWR2YnFLY2ZodVA4WlB2MDNlVzdVcDUrL1VRREJnOElDcC9FL0tQ?=
 =?utf-8?B?ZkRQY2ZqV0duZGpBSS9ySkNaMDF3VzVFbFJMNC9KMm9xSjdlRUtMcFFZTGto?=
 =?utf-8?B?TDZFencxRW5weFJTakR6cmRnbi9FTzZNRkorK1FlSGVEQTBlSDhycTFOM2E3?=
 =?utf-8?B?TFdZM3RmaVRJNXJQSVFaZ25rVGdjYXR3bDNHSkp1RElCVTdMYjBQZ3RLVlk2?=
 =?utf-8?B?ZXpPY0ZhWXVWZjhhaUhPN1d2SkJuSFBPeERTSGFITFcwSkR6NVVHbm91OWlo?=
 =?utf-8?B?WmJSblhCaG1FaGV2TTFmZTVDVVRxaGZud1VHVWs4S2Y5N2U2MFh4NWpLY0Zx?=
 =?utf-8?B?NkZ5NmJrUkdXY01zcStKMC9PV2R3VnRQMWR5WnlvQkRRTWYxelArZU5FeEl0?=
 =?utf-8?B?eWdjUlJKYXBXRW5QVUp0UkxYY0NQM1R2S0NLWUMxdW51QkVHZ2V4QXgyZkpt?=
 =?utf-8?B?RnpRNlBPMW5BZGxrdzVNSjZjdzF4bThFdUEyMU1Oa0M3cjRobGFEdUltVkFI?=
 =?utf-8?B?RGZHTnZWc0FTOFhzeSsxT1lSYkhuQWZTU1kvV1o4TDNDbjQ0S1NOUVRLa3lT?=
 =?utf-8?B?emUweHZ6Uk8wSkY3MzZJZVZoZ29LTFhOeFByWGdIcWdvcUJzVGhYUUJMN1lF?=
 =?utf-8?B?SlA1OGhXZjVza2d0N3FvcXQrd3dCamQreDlHY1BQV1YvV0JoamtBV3l6VjhF?=
 =?utf-8?B?VHVyZEk5WjQ5Q3M3MU96OFZoM05xODNOOTd5cG1zK25CNWdxcjZBZ2pBS08z?=
 =?utf-8?B?L1NOU3lKaWNhZDc1QStyYVRqbnpXYk9HWThwTHdoNG9oejMvcFEwQ2tsTXN2?=
 =?utf-8?B?blVQSEMvZTFNeVRhdHdiSkxBYmFmMVJjK0ZwWHhXZXhPZnMycU1YODFDQURE?=
 =?utf-8?B?anRPZ1pVanhkOWowQUJzZDJpU2RFVmtvdFF1aURYR09ZUC9WSkZnbFpCWDZ6?=
 =?utf-8?B?MUVCL0JUckRWUG1EcmRiL3NFNUNLSGRNRkhaZkd3ck9wSGNwZHMxb1NWVWI0?=
 =?utf-8?B?d09KRTBDVmM0MmM2Smk2YmxGTmZpK3ZPYlZwcGI3VDJ1RzBjQldmbXdNTDEy?=
 =?utf-8?B?YXA0VjNuY252QUxoS2ExRjBNR0JDZVNBUGIzTjZiaGYveTFKeU0xcWVpSnV3?=
 =?utf-8?B?MGR0eWFnMERLdk5uekprME45bndpYTYzaFlCR3ZDV2FTcys1V3dpc3JCQnRD?=
 =?utf-8?B?L0F2aXBKcjk1MFRYSHhmTTd5amo2TDhaQTNoVi9rYjREZDg3SDhUanc3WE5F?=
 =?utf-8?B?aTh4UjRkclM5TjJDVTVCTkxscUtyNW5rS2FaeFVCbjBDdVp6TGN6U3F3ek9I?=
 =?utf-8?B?RkQzOFViMHZnWWJMb1h4Tis4UzhCTXpBMC96TTVzZ1pla0lKUFZXK1RyK2ha?=
 =?utf-8?Q?YrRT7fsrxG8Duciu45Zw+M0bb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b23269-e131-4bc0-9f36-08dcc77b5409
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 16:06:08.6793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+Zwol1up9t0WOZvnidgUx/sNAUsqngkVlxxWaWRLazkHIg8LU4RM1cTkQnDsDGADBe0jEQWgKhawSf32/Se6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705


On 7/16/24 09:13, Alejandro Lucero Palau wrote:
>
> On 7/16/24 08:14, Li, Ming4 wrote:
>> On 7/16/2024 1:28 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices 
>>> only.
>>> Suport for Type2 implies region type needs to be based on the endpoint
>>> type instead.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/region.c | 14 +++++++++-----
>>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index ca464bfef77b..5cc71b8868bc 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -2645,7 +2645,8 @@ static ssize_t create_ram_region_show(struct 
>>> device *dev,
>>>   }
>>>     static struct cxl_region *__create_region(struct 
>>> cxl_root_decoder *cxlrd,
>>> -                      enum cxl_decoder_mode mode, int id)
>>> +                      enum cxl_decoder_mode mode, int id,
>>> +                      enum cxl_decoder_type target_type)
>>>   {
>>>       int rc;
>>>   @@ -2667,7 +2668,7 @@ static struct cxl_region 
>>> *__create_region(struct cxl_root_decoder *cxlrd,
>>>           return ERR_PTR(-EBUSY);
>>>       }
>>>   -    return devm_cxl_add_region(cxlrd, id, mode, 
>>> CXL_DECODER_HOSTONLYMEM);
>>> +    return devm_cxl_add_region(cxlrd, id, mode, target_type);
>>>   }
>>>     static ssize_t create_pmem_region_store(struct device *dev,
>>> @@ -2682,7 +2683,8 @@ static ssize_t create_pmem_region_store(struct 
>>> device *dev,
>>>       if (rc != 1)
>>>           return -EINVAL;
>>>   -    cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
>>> +    cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id,
>>> +                   CXL_DECODER_HOSTONLYMEM);
>>>       if (IS_ERR(cxlr))
>>>           return PTR_ERR(cxlr);
>>>   @@ -2702,7 +2704,8 @@ static ssize_t 
>>> create_ram_region_store(struct device *dev,
>>>       if (rc != 1)
>>>           return -EINVAL;
>>>   -    cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
>>> +    cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id,
>>> +                   CXL_DECODER_HOSTONLYMEM);
>>>       if (IS_ERR(cxlr))
>>>           return PTR_ERR(cxlr);
>>>   @@ -3364,7 +3367,8 @@ static struct cxl_region 
>>> *construct_region(struct cxl_root_decoder *cxlrd,
>>>         do {
>>>           cxlr = __create_region(cxlrd, cxled->mode,
>>> - atomic_read(&cxlrd->region_id));
>>> +                       atomic_read(&cxlrd->region_id),
>>> +                       cxled->cxld.target_type);
>>>       } while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>>         if (IS_ERR(cxlr)) {
>> I think that one more check between the type of root decoder and 
>> endpoint decoder is necessary in this case. Currently, root decoder 
>> type is hard coded to CXL_DECODER_HOSTONLYMEM, but it should be 
>> CXL_DECODER_DEVMEM or CXL_DECODER_HOSTONLYMEM based on 
>> cfmws->restrictions.
>>
>
> I think you are completely right.
>
> I will work on this looking also for other implications.
>
> Thanks
>
>
>>

I think the check could be performed inside cxl_attach_region where the 
region type is already matched against the endpoint type. That is the 
check triggering a failure for my Type2 support and the reason behind 
this patch.

However, I think the way encoder type is managed requires a refactoring. 
From the cedt cfmw restrictions I assume a decoder can support different 
types and not restricted to just one, what is what the code does now 
using a enumeration for the encoder type. With no restrictions, what is 
the current implementation with qemu, I would say a root decoder should 
be fine for a Type3 or a Type2. Adding that check for matching the root 
decoder type with the region type is therefore not possible without 
major changes. Because other potential restrictions like only supporting 
RAM and no PMEM is not currently being managed, I think this initial 
type2 support should be fine without the checking you propose, but a 
following patch should address this problem, of course, assuming I'm not 
wrong with all this.



