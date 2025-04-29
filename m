Return-Path: <netdev+bounces-186686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA71DAA05E7
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 10:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CFF3B53E0
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 08:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EF3277004;
	Tue, 29 Apr 2025 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hsn+weLm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512B1F4199
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745915899; cv=fail; b=E+tETgzngPaFn6sCbhiEvbu7IzSUUykLcKKCBrHkrIkh5Hz8h4+I/hHv1RxIwnPZ3vK43NYONkl0J5g0bHpX+iv4tg6+47eCMEFWH9Ma/eqZYgGVFF57BrLB0VqCN/mRqNBWNXhr2qTwbEEyWauN0PaZ3mYwgfZRtFYFgUrpVaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745915899; c=relaxed/simple;
	bh=T5qLgVNTubjaRawMNbv2N3oXuMu/lOxlaS2lRRYnGKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VwBc9zOlpzpKnglybrl5rKGE32qdzfyRzVnihqdr1Dpx0CU2yysfkJCLrdaKpfGaGJFivPwP07slb/sPdTnf0WCP4R/V4RJctxvCRvgQG7F8sDojlYZCgYkrCWeheLRF62E6knyiCiQFRWqv32/CvxgtGxb38h/h1hnF827ZtPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hsn+weLm; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRcGj7uBWs0ed2AqVzt0AHmOBz1e5YokpJ7uxABj2vw5XFB5Mx+oZzByri7PFwzbXJZdHtOP9p+NdwlT+/Voh26AzWnh8Eg8r+3sph1EOWQujxVxTfW64pq9JFZ5lE5TUFPMZ8FoJvSXdOnbsc8lFQESfJv57TGeDF1G1NrqEFuQC6lbHXHQMaTtgHChWc80QlcdQhW5pkEIqCTmRm/HEUI/b2KYl4F+1xp1lh4HyoQox38ZSjCNB6la7us4lFDBl40nVgiZuQP/TcPKYC7AqiueaRj4XEe8pkU46vB7rw2q9BAp+qqGZQ2osQeUo6JKEsq8FIq6GoPmgj4+h1kO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbzcxFW2vPVOAfVHfe0RlRmBO13niGRyLnDBvM4Vu/M=;
 b=rkCf4rJBn4zvY0QSorw+BEHo+FSZZyMdg2hcbymxCJcrGpQS4/KhI5cJ6TKtiVxGJ3orF2mgWCYhcIyVN5o9uJhqiwqcu3IBpWbRPNAsuxO/uReMvJsn96+9+x2JWPUd7MYP/CUbFyIrUGGbE5SoLCBz/c148BICV42uAbK6f+7fx2ATMHGJily6R1v81HbD4fLI3rDZ26M3kpitVZRZwfsNOnAOGK5OcSuCO/x2SPPiGGqwRWa4Zz5up1uSqmMC3SPNLsJ/MMF4qaj7FKSflFccQ1FCw7xiswEJpZhvxHjWaAl/k+Z+z4dXYXTojb6xScanXES1xZo2wPwhWljTCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbzcxFW2vPVOAfVHfe0RlRmBO13niGRyLnDBvM4Vu/M=;
 b=hsn+weLmMRqkCy6aTrBYH3bB79htUQvWRJ+5U7q9smuMEuOJea07KobfKQ85D3LvfSbv7cqPX07pSvtafa2IxCbnL6m38NVAZ/fwtmcArf5/kGJ/ySg5+4zmODfF/wgzIf4/5RNyAhfI9Iz7dbYPn5F1dSCPxOtsNs7KXWNg2EG1hLSdpvs7ZHrYj43caTYhOGP8MqxYHu+uWHyT+I3HbM7fP1IWXxCieg7BnZ2175altLiKQXJZais+I/Fs7/FWY4lOlSd89YwK65hNpeTtw0J5HdXvqJKOa6FuG7jVsgRheSa3kq4LbMFv/x1POH1qsMzTlxI4YJataWhAD9cuJw==
Received: from SA0PR11CA0021.namprd11.prod.outlook.com (2603:10b6:806:d3::26)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Tue, 29 Apr
 2025 08:38:12 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::a4) by SA0PR11CA0021.outlook.office365.com
 (2603:10b6:806:d3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Tue,
 29 Apr 2025 08:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Tue, 29 Apr 2025 08:38:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Apr
 2025 01:37:56 -0700
Received: from [10.223.2.16] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 29 Apr
 2025 01:37:52 -0700
Message-ID: <507c9e1f-f31a-489c-8161-3e61ae425615@nvidia.com>
Date: Tue, 29 Apr 2025 11:37:51 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink port
 function
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
 <20250424162425.1c0b46d1@kernel.org>
 <95888476-26e8-425b-b6ae-c2576125f484@nvidia.com>
 <20250428111909.16dd7488@kernel.org>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20250428111909.16dd7488@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb94692-6c18-469e-4902-08dd86f92d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R21GdGkwbEZFOU12a0hsRERTUU1pb2R0UnNGRGZxTERoR2RQeHROZ1NGMWF5?=
 =?utf-8?B?RnhrWW1zS0M1MlVqY1FKdUxIcjJrMWZadHZyandRR0xGUWw0TE5YS0Q0aUxx?=
 =?utf-8?B?OXBLdjBIN1lWL25jb2xGTk5xeHZud0NPR0w5Q04xdXJjOTZuOEZ0d0xVbVRX?=
 =?utf-8?B?cVpZelFrVVQ4Q1RjZnE0cW5JcmxXckk5SGVNOC9wNzZWQnQyZjRHdE94aFRu?=
 =?utf-8?B?aDhSMVk3U0tNTm9lZXlaYXZ3aExRcW9yemZOL3JTVU5YZU5Qam10NDYyc2Vi?=
 =?utf-8?B?dGtHWkFnLzU3bkZGcWdDVzdUSXZ3ZWJVUTdsYXVQQlBBdERxY1B3eTdMbUZU?=
 =?utf-8?B?aldmandXaWQ3eHJOTkZZR1VrenVmUDV2K3pGTzdQYlMxMW5JUWExR05uTmJF?=
 =?utf-8?B?a2pFcktTRzlGbU5VN0tXRmpyd1JkS3Zlb0JSYlYwQnE1ejRuNHcrUjRnNmJ1?=
 =?utf-8?B?UXpPK1cwUWtyMXRGeWVWTEx4VkZVT1VVYVM3T0RLM3lLRFdwTGZScHlJQmYw?=
 =?utf-8?B?YlJ2ZlRuRy9QejNaM29IZm5CWFdHMGZLc3JRc3ZxaXNzcFJpRnBEeXV3eFB3?=
 =?utf-8?B?cmYxbVoxb2xDdFprdmx5NDBvTUtkYnp4aXFVa0M0ZW1paGI1anJhYjFZalBV?=
 =?utf-8?B?V2VBd2xBa0dXd3Njd1dKNVdtLzZoYUZMWEpBMkV0OFB1Tlh1V0RUYTNCZEVX?=
 =?utf-8?B?YXB4aTJvR0JqZi81Vy9PZUJpQWIxa0RlNVo5TmZXSHRwelpFb0FqNlFTdFVS?=
 =?utf-8?B?YWJkRm9oNHZFQjVYR09ZTnY0dVJkNEx1RHkwcUpKd3BzY2NGSjdNWnpIdkZx?=
 =?utf-8?B?ekV3OERIb2J3N2VvN2V3R3BOMSsyUXNkdDMyakN1bHcwbkxSV2p0bktFVWo0?=
 =?utf-8?B?YVNiZmdtaVBOWm4xdXdtaFhVbS92ZlFHMnErKysvQWlTVmNDR3VPRVVxbkQw?=
 =?utf-8?B?ZFQxTk1IeGZ4Sm8yR0NUS0ZhN2xwNkQvUmJSazluNFoyVWhaVWpVZ3M0YnRm?=
 =?utf-8?B?S0QvQ2c4ZEtuUWhEazQ1ZWdmazdZQVI4bXRVcWxIczEvWlpRS056REp1WlFv?=
 =?utf-8?B?ek9QTFhIekVQbTZNMWJwek1taldJNDMwWUdpVlBvYVl0RkxBc01vdGVnRmxN?=
 =?utf-8?B?WlJERlZUbFk1VVdlR1pwNXJPWnlnMnAzbmtnL2VCMnpNam5XZ1AvdHk3WmdD?=
 =?utf-8?B?MGNZck5DbC9wNzljTWhKVE9kN1FFRDlpY1pVQ3RQYmpEV3NKZTNTeWJTb1c5?=
 =?utf-8?B?dndnOEVnVDV6YVV1SElMRXEyRDVTZUFZL09RRXVXVWVzcUdYQmdKcm5KRWhZ?=
 =?utf-8?B?ckdDRnIzblluQ0dGa1FKSmR3bnJxMDYvZm1JeWRRa0tXQXJ6UGFTVU1nVzQ5?=
 =?utf-8?B?RklhMmtUYXVDdzJHQXdRaFpXQU1NWnJMUFZBMmRXV2kraHJETVA3OUhTSzVI?=
 =?utf-8?B?KzhqNGdoY25ERThoZXR1WERZWmJkSG1uazl2dTEzU0JSTUFoWmR6a2I1ZVY3?=
 =?utf-8?B?UDk5WWQ3a3lidllFaWZabXdSeTM4Q3JMbHJuNUs5dCtva2JDcDdEVUhzUGx0?=
 =?utf-8?B?UU1CSUxKMGs0RTRuT1ZBUStZendKYnZQdTV5SnhJRTFCSUh5ZkF4N2lPb04y?=
 =?utf-8?B?RzJiemxPWDllODhQc3RwalVtVjBFem40VWZpR2lHYTJpQ3dQWUdWM0JwcFRh?=
 =?utf-8?B?aUE3U1FOSlRna2UzbHgzSmMwVWxMbC9VdU5WcUYrKytkeWE5TFdweTRVNkVP?=
 =?utf-8?B?Q004a1Nwc0sreit2c29RTG1kanFFK3lXdkpWcTdEVVZpY2dFQ1hSRFhpaEFE?=
 =?utf-8?B?R2hSYis3dE9uTmlsS0VCa1VuMlRxWUl4QTl0UEZ0UTd1R213OTBLNW8xeEdu?=
 =?utf-8?B?NE9QdVVoYmtRTWp6S1RvWGZIM2RlVm9yUlE2ZGxIUUlEV1FiZ3l5NkhaZmNN?=
 =?utf-8?B?T3JSM0w1VUMrMFU4REZiUzZqczkzNEpNTWZyMTZwUHlqWjVmT2REd0pQL040?=
 =?utf-8?B?b3R6Q282aGVQQ2VQT2wxeFg0Ymh6cVk2OStnS0RXc3VFeVZZaWpnOEkzeUpU?=
 =?utf-8?Q?+A+Pki?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 08:38:12.1733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb94692-6c18-469e-4902-08dd86f92d66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668



On 4/28/2025 9:19 PM, Jakub Kicinski wrote:
> 
> On Mon, 28 Apr 2025 15:11:04 +0300 Moshe Shemesh wrote:
>>> Makes sense, tho, could you please use UUID?
>>> Let's use industry standards when possible, not "arbitrary strings".
>>
>> UUID is limited, like it has to be 128 bits, while here it is variable
>> length up to the vendor.
>> We would like to keep it flexible per vendor. If vendor wants to use
>> UUID here, it will work too.
> 
> Could you please provide at least one clear user scenario for
> the discussion? Matching up the ports to function is presumably
> a means to an end for the user.

Sure. Multi-host system with smart-NIC, on the smart-NIC internal host 
we will see a representor for each PF on each of the external hosts.
However, we can't tell which representor belongs to which host. 
Actually, each host doesn't know about the others or where it is in the 
topology. The function uid can help the user match the host PF to the 
representor on the smart-NIC internal host and use the right representor 
to config the required host function.

