Return-Path: <netdev+bounces-171467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5617A4D0A5
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 02:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA7B16F633
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB8C42052;
	Tue,  4 Mar 2025 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ofv6H1/p"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693A22092
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051239; cv=fail; b=jazh8HdnPEanNVFPN8LOJ1yA/90cYfW/skEq/TVp9lYJN2B4RCUid3HfrsDDvYSpd7gOW/vl/qvKAFJ3Kn9In/VpEbhv9yj2M8aDik04lQbMlUkoXfqAyYhn6iCzFvNWzTVd51Z4jcbaKO6CB9s9uf8vksnRAlOhWWi7lWkCY0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051239; c=relaxed/simple;
	bh=BYvcN3UDciEE9w99AcNc87atSxlcYIvHyPiqPvT81Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EJzjk19sESc5X1I5qbJ7RQKRoLhbvW9uQPCoIcR9Tav29VDUZEx9xJd3p5xsDmzvlbI0rr3J4wg8yrdc3nY1m/M5bUbNORBqn9/+z1VcVv8FXgX0ycgeiR3bPKjmOQv3cOMfZENzLN8K1FfkjMWrxc/ygOo/7YDfzGaWIlfQNRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ofv6H1/p; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mocE7S089/LkAgOchOBIwy8xrXOYgg8cXTgJD7rpKOA4TJDwQGGKxNVNNkX9PMDOuC+ThQLAuf8g46tgpcAUyuKShnCFNoPpX0V4XKTo389Qujm06eHNPDw3jfHt6EcOGHLI/dQajI6mskkzi7A35ULKGA0vOyeNNnPA99HlaoCrG6hSKAwO/0axUpBECjys/lD2Q2FU9iFM/bb9ldOaB3iejE76uns0pAnuMXhxb1SfSfqcyrbdXBgMQ1Z9f38WATPxcyPDpwV4RmrqWUhGs+eCWqXBx3L9fJwOPbsUyULBw51ydm4abHYqSFeEaLMbAbiQcAJQ8ZugrjNip+zd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6qBkganMXplOKHgWlR6Y4GTZ2/NPSjKuIX98NG6aPw=;
 b=xvaDTX4p4KQWQddlEL7TFqVUl3whGZOTBqFzJgadEmcsWhl1ypgw1zRBTz70KvQ9ge9xSIRo34+dwaPksjvMqBOCS5+Bxefxp2HeZYiAa02X6Y3KO8XD0qjzNfmYosm6iUBCFAlha3w5l2ulLmwQ6leapNFCk0vRVP2KWyxzw95nmFv7Xzndnn9ruqimJsYy6shFiNDu1Vw2hB8Q2biV++Df4xBkH1SfTB8xTXO5MtiFRsixyV1TIetuZXnEermZBaiQ5dQGEF3PhCgXyZfAVdVO49LdVyVLE9XROOBApwDpj392H05cP/OW9uDF3/sZmiwXamyk2wJf7v/oLV4zWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6qBkganMXplOKHgWlR6Y4GTZ2/NPSjKuIX98NG6aPw=;
 b=ofv6H1/pkjRtvGIx9hVHzCJs7KvWJ1iQScGZCIQy/wPt2OEGqWq/vxyaYjfttIUG4D1/zWJAi6AQQOaL/GeuMIlVvH9hyyIrt8+SHnDfMEjgs4slPGzv5Zu/0fLkG98LXuTJk0oT09C69QCEhqLRrnrFw/NuPBl0De328ZeqntSkAUFeRYZe5JO+ai0JQRCI7mrWLvtL98iN40RroPXpiE55bAjn5uwmXeQE35zIGOerjaoOnn3Eb3Lx0JrXKq5FypTtFk9PuppgW5pdOP/dnh5kmg4om9eoHQMyrqtXUPzlqrI90CIHQ4KBrqBjCmYL0XV+PFNbOX/hPbp8YHpD1w==
Received: from CH0PR03CA0115.namprd03.prod.outlook.com (2603:10b6:610:cd::30)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 01:20:31 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::ab) by CH0PR03CA0115.outlook.office365.com
 (2603:10b6:610:cd::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 01:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 01:20:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 17:20:19 -0800
Received: from [10.19.163.138] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 17:20:16 -0800
Message-ID: <c986ed18-750f-46bc-9f52-5860d834162e@nvidia.com>
Date: Tue, 4 Mar 2025 09:20:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next] openvswitch: switch to per-action label
 counting in conntrack
To: Xin Long <lucien.xin@gmail.com>
CC: network dev <netdev@vger.kernel.org>, <dev@openvswitch.org>,
	<ovs-dev@openvswitch.org>, <davem@davemloft.net>, <kuba@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Pravin B
 Shelar" <pshelar@ovn.org>, Ilya Maximets <i.maximets@ovn.org>, Aaron Conole
	<aconole@redhat.com>, Florian Westphal <fw@strlen.de>
References: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
 <2ee4d016-5e57-4d86-9dca-e4685cb183bb@nvidia.com>
 <CADvbK_ft=B310a9dcwgnwDrPKsxhicKJ4v9wAdgPSHhG+gPjLw@mail.gmail.com>
 <5ab59f2d-1c22-4602-95ab-a247b5bf048e@nvidia.com>
 <CADvbK_draP9X9OWXEYTKrP0_ekjgNu9PYPp6GUkvu-3L24SRYg@mail.gmail.com>
 <CADvbK_cungrr_D5VAiL8C+FSJEoLFYtMxV5foU0XA9E4zrcegA@mail.gmail.com>
 <7061a416-56cb-4751-8576-8071c2205d70@nvidia.com>
 <CADvbK_faagwC4q0vNEeW7Eu7SZbXuVjULXo3kg7JS16cF+cmig@mail.gmail.com>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <CADvbK_faagwC4q0vNEeW7Eu7SZbXuVjULXo3kg7JS16cF+cmig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 314bb1cb-bd82-4165-05db-08dd5abac170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWFydWxkVFVHUnBGb2R4SStGekNRTVVDNkc4czVEVmgvTFI3RjBoQU0rNTB4?=
 =?utf-8?B?ajJRd1dGQU5yOUJpaWhOclRYVzFBanFNR0FmWTFVWm9JOWFDNDZSbVRETEVj?=
 =?utf-8?B?OE9PVTVUejUybzk2Zk1TWWhnV28yRXhxM25yRis1NWttcDYwV0lSOEhOQjln?=
 =?utf-8?B?bmdnNnRYaHFHOGIzMlRaY3RIanE2M0xKeTFINlJmcnJaVkRWV0dTemV4dUR6?=
 =?utf-8?B?MUFGY04rVFlTc1Fra0tFYmhrR3R5VVM1WDJoR2Jac1ZxckJ5b0dGclVPMVpM?=
 =?utf-8?B?UlpTalphSlI5V3VNcFd5TWNlOE9wc3Q2ajNlSW02aW5MVTQ1NDcxLzJSYzdZ?=
 =?utf-8?B?QS8yRlpWaDZzeDFuWGlmckRZL05qdklXUnd2L2tLcUg4a01rKzJlcUx2Z1ht?=
 =?utf-8?B?OUJuTzEvWW1QQ2ZGOFN6TnIzcEhSYUdlbnc0OG1DSUcvRHk2dTBhbmxiK0ZN?=
 =?utf-8?B?UHQvL1BGSmZkZ0UvKzRPM0JrdGhFa0NKbVpFVEoyVmUveUZTVVp3SHdoa3Bn?=
 =?utf-8?B?RU1vRkd6VlptS3l2SW42M0l0VWwrWXk5UWVnTHNRalVicHgzTExDQmJCZHJ1?=
 =?utf-8?B?c3BmWjZCWmplYmxPclVKa1hBbnhYNDdKT3JxWU5BUkpjaVc0OU5ZSXZ6SXJ5?=
 =?utf-8?B?N3kvMDk5Yi9JbWtTKzZsa3d1c21PM09DZzEyLzZlRW5aL0dqK0tnbFJONDN6?=
 =?utf-8?B?Q3V6VHNVWHRvYUxQOEljbURHTHNkOXluM1FDTXV4MEUzTHlCS3ppVnYzdkZU?=
 =?utf-8?B?QTdQVUVobHdJelBaUFhTV29NZ1JQWEluMmFidlNkY1Ayc0lQUUc3RmFjTmFm?=
 =?utf-8?B?cy9nWkxBTEl4YTJiclZyc2NhVFRsMHdjaVhMZFRjM3lrbHlFUlhJOHhxTFl4?=
 =?utf-8?B?Tzd4c3gzd1BGNlp3L0kzaFQvdE1ocEFLUUZFdE40S0I3VlpQRmFOY0czR0p1?=
 =?utf-8?B?WE1pbHRldWY3V3RSM1FPM0Qyem1LRWkrUjBDTTB5bzgydnF5U1pWdndaWVFO?=
 =?utf-8?B?YnRxOGwzRTBqbVFlWlRxRDNTOU96dkZHR2dxQVJSTG4ySEFuc3d1a2pUWllh?=
 =?utf-8?B?aTdPbWwvc1JMVWlKMlBqWkdzTWRUUE9yVkJSYjJyaTFmYXorVHcvbDBza1Z3?=
 =?utf-8?B?aERYTVpmL2g2VldFWTZaU21qbHVEcWlhbzBRNTRyODJYRElQMCtzbjZzSlo1?=
 =?utf-8?B?VklYbjBIUUVMcUFEcUNoSzBnZUdsMVZ6TTBiQjFLTmNnL3dzM2hPZmtZTWln?=
 =?utf-8?B?aTVqMno5NjZFakhYeEZJcjZsdGt5V1RsV0I3MUtuamVsTjFVMjRIZVZVOUJR?=
 =?utf-8?B?cXdBcDRQbUFHaUl5WURmVjNMV2ZQVHYxZ1hYOU83NXg2S3BjOE9HQzZ3ZFZK?=
 =?utf-8?B?M2FqV3NIOVdGV1BvVjJqSWQ1WWx5Z3BPUzRGUGFwNnROZ0dKSEhFL3ZLNzVK?=
 =?utf-8?B?NGR1WFJhZEtpZmtjUWNzMUVnSERkaVJMaFBHM0VzUXNQMjF4dElZOEQ2NGRt?=
 =?utf-8?B?UFBmc0RtamdoZHVEdWJabzJjdURoaEdyMllPMi9LT1JqemkrOTdWd0dhcDlQ?=
 =?utf-8?B?UXp3Q0pZamw0S3hUQjd3dFBxODJ0VWdBc0hVT2oxaFYrNk5RVUhCZC9vTDh1?=
 =?utf-8?B?UVF0Y0ZJL1B6VWRwb1pzMHlDaW84Z2YxTGZRaHc0Vmhzb1o3K2dlejIvbFh4?=
 =?utf-8?B?aXh5ZFdRWXBYYWptejRzMjM3UU81VmxkcmFNV1RCM1RqSEdZWlI1dXQ2SXVj?=
 =?utf-8?B?YnRNc0NmbkxoQjFNUC8yejRGanY2WUNUdVViTE9uQXVLZldDZlhOaTJkdUpB?=
 =?utf-8?B?UlprbmRUTnFCdHRSR001VWV0Ty9aQ053N0V3b2JwMk9HcXhmclBMU0tpUjBo?=
 =?utf-8?B?eW9xUzE3SVJaaVgzYUZSTC9GT3RXcjYyU1p2VWRPYW5uVlRKMUYzTm9Sa08y?=
 =?utf-8?B?VmxmTEU3ZU9YdTNaenVZU04xMlVCYWhCcVRvU0FnY2VuaitEcXlUbENKZFZ6?=
 =?utf-8?Q?853Po45+z78OjEMXO7FfGomvh4GphQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 01:20:30.9895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 314bb1cb-bd82-4165-05db-08dd5abac170
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565



On 3/4/2025 12:42 AM, Xin Long wrote:
> On Sun, Mar 2, 2025 at 9:14 PM Jianbo Liu <jianbol@nvidia.com> wrote:
>>
>>
>>
>> On 3/3/2025 2:22 AM, Xin Long wrote:
>>> On Tue, Feb 25, 2025 at 9:57 AM Xin Long <lucien.xin@gmail.com> wrote:
>>>>
>>>> On Mon, Feb 24, 2025 at 8:38 PM Jianbo Liu <jianbol@nvidia.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2/25/2025 3:55 AM, Xin Long wrote:
>>>>>> On Mon, Feb 24, 2025 at 4:01 AM Jianbo Liu <jianbol@nvidia.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 8/13/2024 1:17 AM, Xin Long wrote:
>>>>>>>> Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-action
>>>>>>>> label counting"), we should also switch to per-action label counting
>>>>>>>> in openvswitch conntrack, as Florian suggested.
>>>>>>>>
>>>>>>>> The difference is that nf_connlabels_get() is called unconditionally
>>>>>>>> when creating an ct action in ovs_ct_copy_action(). As with these
>>>>>>>> flows:
>>>>>>>>
>>>>>>>>       table=0,ip,actions=ct(commit,table=1)
>>>>>>>>       table=1,ip,actions=ct(commit,exec(set_field:0xac->ct_label),table=2)
>>>>>>>>
>>>>>>>> it needs to make sure the label ext is created in the 1st flow before
>>>>>>>> the ct is committed in ovs_ct_commit(). Otherwise, the warning in
>>>>>>>> nf_ct_ext_add() when creating the label ext in the 2nd flow will
>>>>>>>> be triggered:
>>>>>>>>
>>>>>>>>        WARN_ON(nf_ct_is_confirmed(ct));
>>>>>>>>
>>>>>>>
>>>>>>> Hi Xin Long,
>>>>>>>
>>>>>>> The ct can be committed before openvswitch handles packets with CT
>>>>>>> actions. And we can trigger the warning by creating VF and running ping
>>>>>>> over it with the following configurations:
>>>>>>>
>>>>>>> ovs-vsctl add-br br
>>>>>>> ovs-vsctl add-port br eth2
>>>>>>> ovs-vsctl add-port br eth4
>>>>>>> ovs-ofctl add-flow br "table=0, in_port=eth4,ip,ct_state=-trk
>>>>>>> actions=ct(table=1)"
>>>>>>> ovs-ofctl add-flow br "table=1, in_port=eth4,ip,ct_state=+trk+new
>>>>>>> actions=ct(exec(set_field:0xef7d->ct_label), commit), output:eth2"
>>>>>>> ovs-ofctl add-flow br "table=1, in_port=eth4,ip,ct_label=0xef7d,
>>>>>>> ct_state=+trk+est actions=output:eth2"
>>>>>>>
>>>>>>> The eth2 is PF, and eth4 is VF's representor.
>>>>>>> Would you like to fix it?
>>>>>> Hi, Jianbo,
>>>>>>
>>>>>> Sure, we have to attach a new ct to the skb in __ovs_ct_lookup() for
>>>>>> this case, and even delete the one created before ovs_ct.
>>>>>>
>>>>>> Can you check if this works on your env?
>>>>>
>>>>> Yes, it works.
>>>>> Could you please submit the formal patch? Thanks!
>>>> Great, I will post after running some of my local tests.
>>>>
>>> Hi Jianbo,
>>>
>>> I recently ran some tests and observed that the current approach cannot
>>> completely avoid the warning. If an skb enters __ovs_ct_lookup() without
>>> an attached connection tracking (ct) entry, it may still acquire an
>>> existing ct created outside of OVS (possibly by netfilter) through
>>> nf_conntrack_in(). This will trigger the warning in ovs_ct_set_labels().
>>>
>>> Deleting a ct created outside OVS and creating a new one within
>>> __ovs_ct_lookup() doesn't seem reasonable and would be difficult to
>>
>> Yes, I'm also skeptical of your temporary fix, and waiting for your
>> formal one.
> Cool.
> 
>>
>>> implement. However, since OVS is not supposed to use ct entries created
>>> externally, I believe ct zones can be used to prevent this issue.
>>> In your case, the following flows should work:
>>>
>>> ovs-ofctl add-flow br "table=0, in_port=eth4,ip,ct_state=-trk
>>> actions=ct(table=1,zone=1)"
>>> ovs-ofctl add-flow br "table=1,
>>> in_port=eth4,ip,ct_state=+trk+new,ct_zone=1
>>> actions=ct(exec(set_field:0xef7d->ct_label),commit,zone=1),
>>> output:eth2"
>>> ovs-ofctl add-flow br "table=1,
>>> in_port=eth4,ip,ct_label=0xef7d,ct_state=+trk+est,ct_zone=1
>>> actions=output:eth2"
>>>
>>> Regarding the warning triggered by externally created ct entries, I plan
>>> to remove the ovs_ct_get_conn_labels() call from ovs_ct_set_labels() and
>>> I'll let nf_connlabels_replace() return an error in such cases, similar
>>> to how tcf_ct_act_set_labels() handles this scenario in tc act_ct.
>>>
>>
>> It's a good idea to be consistent with act_ct implementation. But, would
>> you like to revert first if it takes long time to work on the fix?
> Sorry, revert which one?

Of course the one we are currently replying to - "openvswitch: switch to 
per-action label counting in conntrack".

> If you mean the fix in skb_nfct_cached(), it hasn't been posted and
> will not be posted.

No. I think we both know this is just a temporary fix, and it can help 
you to understand the issue.

> 
> Thanks.
>>
>> Thanks!
>>
>>> Thanks.
>>>>>
>>>>>>
>>>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
>>>>>> index 3bb4810234aa..c599ee013dfe 100644
>>>>>> --- a/net/openvswitch/conntrack.c
>>>>>> +++ b/net/openvswitch/conntrack.c
>>>>>> @@ -595,6 +595,11 @@ static bool skb_nfct_cached(struct net *net,
>>>>>>                 rcu_dereference(timeout_ext->timeout))
>>>>>>                 return false;
>>>>>>         }
>>>>>> +    if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) && !nf_ct_labels_find(ct)) {
>>>>>> +        if (nf_ct_is_confirmed(ct))
>>>>>> +            nf_ct_delete(ct, 0, 0);
>>>>>> +        return false;
>>>>>> +    }
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>>>
>>>>>>> Thanks!
>>>>>>> Jianbo
>>>>>>>
>>>>>>>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
>>>>>>>> ---
>>>>>>>> v2: move ovs_net into #if in ovs_ct_exit() as Jakub noticed.
>>>>>>>> ---
>>>>>>>>      net/openvswitch/conntrack.c | 30 ++++++++++++------------------
>>>>>>>>      net/openvswitch/datapath.h  |  3 ---
>>>>>>>>      2 files changed, 12 insertions(+), 21 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
>>>>>>>> index 8eb1d644b741..a3da5ee34f92 100644
>>>>>>>> --- a/net/openvswitch/conntrack.c
>>>>>>>> +++ b/net/openvswitch/conntrack.c
>>>>>>>> @@ -1368,11 +1368,8 @@ bool ovs_ct_verify(struct net *net, enum ovs_key_attr attr)
>>>>>>>>              attr == OVS_KEY_ATTR_CT_MARK)
>>>>>>>>                  return true;
>>>>>>>>          if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
>>>>>>>> -         attr == OVS_KEY_ATTR_CT_LABELS) {
>>>>>>>> -             struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>>>>>>>> -
>>>>>>>> -             return ovs_net->xt_label;
>>>>>>>> -     }
>>>>>>>> +         attr == OVS_KEY_ATTR_CT_LABELS)
>>>>>>>> +             return true;
>>>>>>>>
>>>>>>>>          return false;
>>>>>>>>      }
>>>>>>>> @@ -1381,6 +1378,7 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
>>>>>>>>                         const struct sw_flow_key *key,
>>>>>>>>                         struct sw_flow_actions **sfa,  bool log)
>>>>>>>>      {
>>>>>>>> +     unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
>>>>>>>>          struct ovs_conntrack_info ct_info;
>>>>>>>>          const char *helper = NULL;
>>>>>>>>          u16 family;
>>>>>>>> @@ -1409,6 +1407,12 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
>>>>>>>>                  return -ENOMEM;
>>>>>>>>          }
>>>>>>>>
>>>>>>>> +     if (nf_connlabels_get(net, n_bits - 1)) {
>>>>>>>> +             nf_ct_tmpl_free(ct_info.ct);
>>>>>>>> +             OVS_NLERR(log, "Failed to set connlabel length");
>>>>>>>> +             return -EOPNOTSUPP;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>>          if (ct_info.timeout[0]) {
>>>>>>>>                  if (nf_ct_set_timeout(net, ct_info.ct, family, key->ip.proto,
>>>>>>>>                                        ct_info.timeout))
>>>>>>>> @@ -1577,6 +1581,7 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
>>>>>>>>          if (ct_info->ct) {
>>>>>>>>                  if (ct_info->timeout[0])
>>>>>>>>                          nf_ct_destroy_timeout(ct_info->ct);
>>>>>>>> +             nf_connlabels_put(nf_ct_net(ct_info->ct));
>>>>>>>>                  nf_ct_tmpl_free(ct_info->ct);
>>>>>>>>          }
>>>>>>>>      }
>>>>>>>> @@ -2002,17 +2007,9 @@ struct genl_family dp_ct_limit_genl_family __ro_after_init = {
>>>>>>>>
>>>>>>>>      int ovs_ct_init(struct net *net)
>>>>>>>>      {
>>>>>>>> -     unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
>>>>>>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>>>          struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>>>>>>>>
>>>>>>>> -     if (nf_connlabels_get(net, n_bits - 1)) {
>>>>>>>> -             ovs_net->xt_label = false;
>>>>>>>> -             OVS_NLERR(true, "Failed to set connlabel length");
>>>>>>>> -     } else {
>>>>>>>> -             ovs_net->xt_label = true;
>>>>>>>> -     }
>>>>>>>> -
>>>>>>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>>>          return ovs_ct_limit_init(net, ovs_net);
>>>>>>>>      #else
>>>>>>>>          return 0;
>>>>>>>> @@ -2021,12 +2018,9 @@ int ovs_ct_init(struct net *net)
>>>>>>>>
>>>>>>>>      void ovs_ct_exit(struct net *net)
>>>>>>>>      {
>>>>>>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>>>          struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>>>>>>>>
>>>>>>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>>>          ovs_ct_limit_exit(net, ovs_net);
>>>>>>>>      #endif
>>>>>>>> -
>>>>>>>> -     if (ovs_net->xt_label)
>>>>>>>> -             nf_connlabels_put(net);
>>>>>>>>      }
>>>>>>>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
>>>>>>>> index 9ca6231ea647..365b9bb7f546 100644
>>>>>>>> --- a/net/openvswitch/datapath.h
>>>>>>>> +++ b/net/openvswitch/datapath.h
>>>>>>>> @@ -160,9 +160,6 @@ struct ovs_net {
>>>>>>>>      #if IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>>>          struct ovs_ct_limit_info *ct_limit_info;
>>>>>>>>      #endif
>>>>>>>> -
>>>>>>>> -     /* Module reference for configuring conntrack. */
>>>>>>>> -     bool xt_label;
>>>>>>>>      };
>>>>>>>>
>>>>>>>>      /**
>>>>>>>
>>>>>
>>


