Return-Path: <netdev+bounces-233049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C64C0BA30
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3877C4EDF8A
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 01:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429012BE058;
	Mon, 27 Oct 2025 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B4aYGnfL"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1673F9C1
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761529875; cv=fail; b=ZDyYeEgy5RneLHqTSJtemSqprlU+IMD9CbWIOKSCBtXmOo11yIkp7Jo2tayzrz+0A3RWArQg4VxeLr7CV4U8Mgf1zBvVHDeTdbdu9YgwOcevQvXVUWT6Lwoz0pBPmddu624BSf9A3YG7jzafS4O/LPaNF+KI7Uf2WfFEkDL7YJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761529875; c=relaxed/simple;
	bh=aET363oq0QM924KqLpiFkxEN/b2Rwo7pj7SNBfwJgRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VeGwgxOYzZ2XugcWI2061ntTeXZ0Lwc2PezhDD+Hr1P8KLaG3omtjzU8qjoiKh7p7+xkcQ+5wymcItmsZ/6e061oVzutQ6BzJu4ArIucFTuBedJXkeWjuAgjmCkdB8mxb4iScAKmjmR45X/wbHYNGd/v/20BEhDNZOi6h77yOv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B4aYGnfL; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3bLwLR4gq4uiY6lI/zuLvQd9SOPbY+MlXDOcAgOlpay1icBgP4HSD2e1K2EEkyKV05K9V2c7QHdtUJ7hQSK48SQe8hnT9PItB/JGDaHZhURHm4ZDlxIf/wyP0PnoDKTbNLA8ueIkmoL4fgngATLXQCoObJNaSB5BDbnqDZH/ni5PNNVI4yXMajjHCMAdjbrU4UFUOGx9X6pRoAhgMM+vNk5URfGdR0cNncFr97G7rmxva1RK76ujBZ9XGq4Kbsc+27Gd+ChMwkiBGZtFBZxkqmKWF7c7MCrVsnMujvHG4DzWdGtAVjWbih6zF9A+LpfONHT4pDphFtpJJi0dniLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shZy9fShuqX2a94BbCja07a6t0eg2uPnJKojr8VFK/U=;
 b=mJHju9eaIMqtjWtnrFAdX3dB65BxSBCCKOiBkfhxf3+knogE4KwJ9Y0uT7ElyiXcjfSf3Eeiw2CKYRTe8zfSFNyG9ZOy6slQ4BE4ACb42PNpj+eTsi6TrRzCI4sOpJKYwh9DFXO4V4B33UbHqq9nboqp3TnimgGNmVfhPJwwauRPYwfkmWLBHZVcicCjJoj5v3Rxz4ZyIP8ZbGMzHrHrKWnc9ujdIZffz9+akDCMycbc2quf2CRffb+D5qr3bLGbxC9ceiU9DjAVVBiYupP7D/kulAnPaBo2hpXMAwBo+VLVhxVwySvPQzUTEJh7J6AtPHkE8jctXvx5VGCMwL+d7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shZy9fShuqX2a94BbCja07a6t0eg2uPnJKojr8VFK/U=;
 b=B4aYGnfLmGa3t+qVfbhwxhvk01NygN2h3ChjQxXQAMHKRZJhsfgFX1xRPl6eNEX0JLt+vsrVPoMUrfN1NUx9EAnTrgCF0iceUQ9ucsnxhoY48/W7+cDPjXxvAiGPj92v1FHaEkupfGqsQZgbcvjGHPhl8qFT2PIPIenlxXYPmVuI0vFoaCsOfYrTz++3LnpUNLKi5fYzDje8Z7jRK/NRhqAk2fcKNmRlOtwjMrAvCgzpF9vOiw9SivWiaeqC8z/q6TsmxvDVu501N62L3YdukI/kZAKwATcnU8uf5MRswIe8bFQ6aBhwdsjDDiQAjm6rqsUZ2XecXQH1SShvPAgv2g==
Received: from CH2PR19CA0022.namprd19.prod.outlook.com (2603:10b6:610:4d::32)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 01:51:08 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:4d:cafe::93) by CH2PR19CA0022.outlook.office365.com
 (2603:10b6:610:4d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 01:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Mon, 27 Oct 2025 01:51:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 26 Oct
 2025 18:50:56 -0700
Received: from [172.29.226.209] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Oct
 2025 18:50:53 -0700
Message-ID: <c71f734b-d215-497c-bd65-dfb7ab3159ee@nvidia.com>
Date: Mon, 27 Oct 2025 09:50:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] xfrm: Check inner packet family directly
 from skb_dst
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>, Cosmin Ratiu <cratiu@nvidia.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20251024023931.65002-1-jianbol@nvidia.com>
 <20251024023931.65002-3-jianbol@nvidia.com> <aPticHQQSugMGgs1@krikkit>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <aPticHQQSugMGgs1@krikkit>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de17698-1306-447c-4ef3-08de14fb4bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXBDZHd5SzAvSk9FMlJiV014aHovOXArKzR1MW5NWkdUK094WlpOYVFMa3Mx?=
 =?utf-8?B?Y21vWHMvc0E5TFJNTUh3NTFzVzVma1ptSWdIN05VR2s2cWVRd1NJTzFVYXA1?=
 =?utf-8?B?VVJhTWpHYkRJTkxnMzNkS1FPdVlONmpnUWowWk8zYzlQWFU3N2RqL0VOaXdS?=
 =?utf-8?B?bXMxK3BEenlqSWpoZkE0UE1kNEJGRTVCY2VWbXAxTWk0Mk1kS2tuSEE2cFRq?=
 =?utf-8?B?MVpDeDBRQlJkcW02cEI2WFV2cVNWOTFYNVRadXR3ZjlnL3NkWFFWeTNIVHo0?=
 =?utf-8?B?YTdSMzBuZ2VydmUzTWtUd2xkcVRxZTFZZHgzVVpsNWpTUWR5Y0dGTkc4ZDhJ?=
 =?utf-8?B?R29pMFhVaWhVejBNNEdBOFRFOVV4aWd2SWNxeno3TGdNeWx6Q2VsQkpGa0RF?=
 =?utf-8?B?VWJLMlRHMkFjZ1ZwTytlMkp3RUdLbmNpR2MrRUlQbFdXQXNCbjhOMlBaWDcr?=
 =?utf-8?B?bHpSaGd6Y2w0UytaVWI4R3lkMUU2Q1JRWXBra2dFK3JxaGVTOTgzMzJjYUlW?=
 =?utf-8?B?QndVSTdKTFVKajc1YkIzOE92cXh4L1NoeUsyOWVwaXh4TmtmQUkraDBmWk0r?=
 =?utf-8?B?TkZkc0ZjVm14OWVyajAwZUFCaVdJa29Gd2wzLzRXY0J3Qlp6ZVNCNDFUQzRi?=
 =?utf-8?B?NTNnaGp1YjFmSXV1ZGRDdCtQZ1N3MHBiWE0vMWlUZlhpVXl3NkFnS0gwdjdY?=
 =?utf-8?B?ZllHeHZIM1gzWFlMRnhWdHJEbVhzY2cwWThQVkF3WnRUWjhsOFhXdFNybjhM?=
 =?utf-8?B?YWhDS3FUK0NMV0RvSjk2RXlXWUlrQ2tNb3E2TnFyQk1LYUpYSDVSbGZuekp6?=
 =?utf-8?B?b09MMDgyY0ZZM2d4N1VEMUpxcC9VeTJ6YjBoSUxJa2xGRHNrS25lTGpmemdn?=
 =?utf-8?B?UnJSdEo4QTlzZGhtemlDYjZ6SXRPRmlibDJMYmN1Umh5bGFERnh5R0E5QjY4?=
 =?utf-8?B?MHM0bmpWaHFrMUo3V20wQXk3Wm1jZVVtQUFsMlNuUlBaS1BMaklZYkNLS295?=
 =?utf-8?B?emNpRm5nOUdPN21qQi9VR1JpZFRzMmpoQmlJbDduc1dpS3lsWnh4bEZpaEtj?=
 =?utf-8?B?NmNzMVp6Z3VDOEtuSUJ2SGg3K0ZWYjVIaUYrVE9Ud0JUbmU5SUJ5Wm9LMEJz?=
 =?utf-8?B?dE5aYUdCL0ZES0ROMlUwdkJ3OWpwdXVVc0F2WW9ya1duT3hUMDJ1YTdVYkxK?=
 =?utf-8?B?cGNSeXl6NUtYMllJWjA3dTBRVlkxOEcwRWVDWFFtZ2NSbFBMc2xFcDVyc2ZN?=
 =?utf-8?B?VnZkaVU5OUZHU09LZnNwWi8wMW8xQTQxNWtVekd6cEw0UVVIZ055RVhDYkNi?=
 =?utf-8?B?amY1a1ZqS1ZRMnV0dzNSc2t4dHZxNWJxTDlUbGp3Y2hHQUdFQlRrRFcwdWc3?=
 =?utf-8?B?blNhRUhuTXNHK0FnT1RCK3RFaFdhNDFHc2Zubmh6bXF5Q0ZRZmpvUlRrZCtl?=
 =?utf-8?B?WjJPaE9YZlp3eTB3ZG9URU00ZDJWdGczZnlENG5DOXI4WVE0TFpLREJsY3VP?=
 =?utf-8?B?V0lBbWpldHlwYVlZK0UwaDNTdmxDZDRJM3QrT0RCVmpMdHNWQXl3eHhFaW9U?=
 =?utf-8?B?b20yY2dDQzNJVVlGNEsvbXhmOG1BajBGNnNZRjkweFZsTnhqVENWNUVPOFkz?=
 =?utf-8?B?OTVld1ZpNG9VNXRyZTFTSjM0L2piZGUwa0RTNjJtaWJmMXpvam1YcjBROURN?=
 =?utf-8?B?NmhYVnc3QmNQcncrSW4vT3lYRzNxR2ZyUjc3Y0o4OUhIY1M0UHRSbWpGaHM3?=
 =?utf-8?B?TnlrQnk4Y0JYM3VHQTZqWktXcUFrNWMrdjZ4S0xmVUpsRFIxZXdYSWlHdFFu?=
 =?utf-8?B?Ym9pT0VlTSsrdHRVbFhWVEIwMi92bG1IeDNvZy9JUHMzTDlHNW9BcGp1VCtQ?=
 =?utf-8?B?RmZaSGJ3b1l3bXhkOHRBTnFFKzMrM0UxOXVZR2phMWcybkpzQUVaL3duTTV3?=
 =?utf-8?B?eHVLSUZkcGc1SkJIVXN5Vys2VmtoVlJLSGxiWWp2ZjBNb2J1V3Nhbmc4UEpI?=
 =?utf-8?B?Z0xoR00yUHN3VWczTVg4Z1VpUUtNQjVyVlA3REVjQ0NkYkdWWDdoZm1Wa01P?=
 =?utf-8?B?VWc4bXJUOGRTcC9kRXdFeExNNlB6OE1FWTRnR3cwR0pGeHk1SzlJT3NoOS9D?=
 =?utf-8?Q?KHWk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 01:51:07.3890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de17698-1306-447c-4ef3-08de14fb4bde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415



On 10/24/2025 7:26 PM, Sabrina Dubroca wrote:
> Some general notes:
> 
>   - ipsec patches should go through the ipsec/ipsec-next trees
>     maintained by Steffen, not net/net-next directly, and use
>     ipsec/ipsec-next in the subject prefix
> 
>   - this patch looks more like a bugfix, so it should target the ipsec
>     tree and have a Fixes tag, instead of -next
> 

Thanks for pointing that. I'll send a v2 addressing these:

Patch 1/3 will be sent separately to the ipsec-next tree.

Patches 2/3 will target the ipsec tree and include appropriate Fixes tags.

> 
> 2025-10-24, 05:31:36 +0300, Jianbo Liu wrote:
>> In the output path, xfrm_dev_offload_ok and xfrm_get_inner_ipproto
>> need to determine the protocol family of the inner packet (skb) before
>> it gets encapsulated.
>>
>> In xfrm_dev_offload_ok, the code checked x->inner_mode.family. This is
>> incorrect because the state's true inner family might be specified in
>> x->inner_mode_iaf.family (e.g., for tunnel mode).
> 
> I wouldn't say inner_mode_iaf.family is the "true" inner family. AFAIU
> it's the other possible inner family for states that accept both
> (I got that wrong in 91d8a53db219 ("xfrm: fix offloading of
> cross-family tunnels")).

You're right, my wording wasn't precise. My intention was to highlight 
that relying only on inner_mode_iaf.family is insufficient. I'll correct 
the commit message in v2 to reflect this accurately.

> 
>> In xfrm_get_inner_ipproto, the code checked x->outer_mode.family. This
>> is also incorrect for tunnel mode, as the inner packet's family can be
>> different from the outer header's family.
>>
>> At both of these call sites, the skb variable holds the original inner
>> packet. The most direct and reliable source of truth for its protocol
>> family is its destination entry.
> 
> (the IP version would also work since it's in the same place for both
> v4 and v6, but we have other uses of dst family in xfrm_output so it
> should be fine)

My initial version did check the IP version field directly. I changed it 
because I noticed skb_dst being used in other parts of xfrm_output.c and 
aimed for consistency, but I agree either approach works here.

> 
>> This patch fixes the issue by using
>> skb_dst(skb)->ops->family to ensure protocol-specific headers are only
>> accessed for the correct packet type.
> 
> Do you have an example of problematic setup? I didn't run into that
> when I wrote 91d8a53db219.

The issue was found during standard validation testing. There wasn't a 
complex configuration involved, simply setting up tunnel mode 
connections where the inner and outer protocol families differed (e.g., 
IPv4-in-IPv6 or vice-versa).

> 


