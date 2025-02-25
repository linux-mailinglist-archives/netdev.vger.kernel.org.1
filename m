Return-Path: <netdev+bounces-169264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BE5A43284
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 02:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E898B188D269
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 01:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84363199B8;
	Tue, 25 Feb 2025 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TNePHxPz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B064C76
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 01:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740447538; cv=fail; b=oRCdRMjbDIcSnYnQObjqiMt/FHAoUiueahxAaQLospazSkHYk9az2c9s2PGDgR8kFk2Rtaa0QtaeiQU/5ZhRG/d0DCTrE+BnSu6SOXDinU4ln+p26Nuq5pKKJka/BV9j+qyAW6v8uAwqg+B8+LBuIeft7HxhS876zyxr+cdEQyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740447538; c=relaxed/simple;
	bh=sfaUORTETIB0t7MqZaWeAjtqFblMZOvRW9ddy34XHxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G3fKIp/O17BUB9iWnC+ARPkrx5zLqhTx2Ub4EX+BSFcbk4FhkbaFa3zWvn+Bdgt6/3t8pJRE+LoltPJDZ1BLEXX3orZaIaf4hw7m/5UBGX9XbhPtOZ1MK2/aW9FMUhVgQ3yI+NpICItMSJxj+CGGHZiS7gSn9RhKVbDTrfnYN20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TNePHxPz; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrGmC23Dfq3DP9NUdcYE3QJVQBg1d0+MhNIoW2/9FDn2LScrylPdt9MmWRU7QIHdjYFE+46PR0iuoaJGIGppfzlci4AVT4jz/XA/TiEBCXA3JcE4vZpSiLnp/MY+9MKaoxObRyh3JnfQWCA9ZBz+4OiK7Yj3klmIofF6/lVn6vXFkDhHVNXkSwM+/fI3dRAWKGgg8SISAn6rOaE2BFDl5GDFcljC2g4yoDpyrJGObozXklvoSiKCDbQ8DDMMaR6rL4E5v6QsCQELRHXwHTjDYds2vhN3SoiVFykpa6nn3rENfpRUcTNyarpAoO9jMNlrEgjM1cxqMih1f/fw0qXxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHqOunIlFuui8+JRUgNShoIFo+Av5zRT3540Qx0j5eI=;
 b=D+7wZxUqolVlRCJc1n5LwviuDsl0lrytAe3/2l8H99IKlXYo+7cdnUu75nHa0NHUWlD27l8uXLqiM8EuZzeJ4jWEmX7HQFO4IuobZq0tOfrM8Gjdqi9icx4huO68+Ux2nDFIrQNIjnx0cuRBSXYXq9JZWH5v0EZ2n3uARN4FuZGSqSD3piM87kdgG6/PwahW3l2u5rPy+uxXSBXhWCrhRkfrt8FMjgugIujdl7B9oKAvGBDz334+1EydHZd4jy+yICvYe1R8vGPx/oWA2OtAyRPAY13Umz5MA6IbtrACLEx86oMdN/YvpyDV/cCzHCoEJB0rqFh9MXhYEf6ga3TrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHqOunIlFuui8+JRUgNShoIFo+Av5zRT3540Qx0j5eI=;
 b=TNePHxPzso8BhMifDBgRZa6sc+eBG2EXiePr/wwI0PGTuiJtavcMP1JapRF3H8MjkZzO8teA4yw0cDQ0Pr4jZC9TuEZg9OR8UQvkY8mOy7d4Tk8HrzMYiuXLum4nPEbQndfDf5kGwgs1YVBScoeFjaVpbKz74j2yvTmQFa5St+WQc3RmaZm4fcxsTwkt1g2OReO2aSKdVfZrruan9GjJnu1kwkgfGM2Dj3mZJs2R9YVsLcde8l+ge0Nanphy3gkiwTjwEhFMVr7s+5nWbsdlcConCE9jOEumLIeHZ0+/af/n84vVPm2Ftw4fbWVjiiNqOLWmEdSGHf6Ud6u2Tew/Bw==
Received: from CH0PR08CA0001.namprd08.prod.outlook.com (2603:10b6:610:33::6)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 01:38:47 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::56) by CH0PR08CA0001.outlook.office365.com
 (2603:10b6:610:33::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 01:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 01:38:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 17:38:37 -0800
Received: from [10.19.165.106] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 17:38:33 -0800
Message-ID: <5ab59f2d-1c22-4602-95ab-a247b5bf048e@nvidia.com>
Date: Tue, 25 Feb 2025 09:38:33 +0800
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
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <CADvbK_ft=B310a9dcwgnwDrPKsxhicKJ4v9wAdgPSHhG+gPjLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 34802199-b8f9-41e8-b514-08dd553d25f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zmc5Q2hwUW0yQVF1NTVzb2ZCZnhhZnF6QmtNNnVXTGtEOUxKOWw4akNKNW1Q?=
 =?utf-8?B?MkFiUFhqQ3VSOEJMOFF3VjZuMjRjMlJrcFovSkZsVDlQQkJsQVJyUlVjK1NI?=
 =?utf-8?B?bFBkZDI4TVV6VUFsck4vUjE4akoyaTVtQ3VmSFRHYTNoT0hXaStyem9IK3NZ?=
 =?utf-8?B?djBuUkFJbWhFcGlQMXpERy9vSkVHSXVmS1VNV2MxbUxGeVNqN2FaN0F4N3dk?=
 =?utf-8?B?cXpnTm5GNys5NVYyWDMrMjhjMjZIUGxaOUx6Sk44Q2JTZmtkZzhxbDcwRUZW?=
 =?utf-8?B?NVErdExnd1ZMOUNuWk9aOHZVSkxUSFVMdUNjU2dVNW9XbzZHdTg0cUtZWUwz?=
 =?utf-8?B?RERiOGFqSDBPQXZINGswaEl5aUtxTDNGekpuUnZCWGlHN1dEQTR4Q0NJYXlE?=
 =?utf-8?B?Zk12OTc3V3FNa0tWYmErbWp6ZmlmMTNFM2R5K05CSHRjSFI5MHJLM2FMVHlX?=
 =?utf-8?B?RDM4SzNWWmV3b0huamxBT0NiMXExc2lmV3dNd1NZd2hlZUNlTWsrdGhiMkc1?=
 =?utf-8?B?eUR5VHo4ai9sUjdKUktGQnh1ZFgyUU1hRkF4SzdtMFZKeFgyeTVRaW1RWHZy?=
 =?utf-8?B?ZDRTeTd5N0Y1YTBqVjFnaVVYZmRlVDlPQ1ByeXhNNHlCaVB5WXNEK3RQSy80?=
 =?utf-8?B?ZzdLbEhHVmhNTWI3QmNnd3JjNEE3V2l6M25MaVBlSXJRTjU0aCt5MUtyQVJj?=
 =?utf-8?B?OVgrMXB4WHc1WGtXMlNsQ3cyYjFwbks2RXlCUU1rN0dKMjBydGhhWGVvOEFi?=
 =?utf-8?B?NG0xVEVRWktpWmhQN21rUXNYR1pGMmIrWlFCcUJ6UUNsdHZadmhZc2tIczBl?=
 =?utf-8?B?VnBnN2U0QUJXeHZwdnkwTXl4ZGY2NFhJeDJERHlTVUpSUEtwOXZtVUdTditO?=
 =?utf-8?B?RVd3Sm5EeTA1Um8yRU9kOG54L3FTYkN1dUJYQ20wK1pUUnh2ZURoNzlEUXlN?=
 =?utf-8?B?OG5BaDJhKzdpckRpSlVYSUNsT1Y3M29EWFRrUmRPeHZVRjNrcUVEQUhPdEhx?=
 =?utf-8?B?OEFmaGJJUzRTNVlTSjBlWnl1WmcwUmxFZXpsZ0JvWEREeG1jc3ZpaVJpK3Vq?=
 =?utf-8?B?aFhlcU0xczArSFlxQVhhL0UxS3d5a2p1dUt3VHl5OS9iOXlyY0o4MWtUWjRM?=
 =?utf-8?B?UmJJQUZnSGRtY2VWSG9kMWlDZExiWEdCOFdhOEpja3FnbUtyelhLVTF4U2ZN?=
 =?utf-8?B?YTNFZ3MxdnJvSWxIR3BPVFptc2E2OGpIZW82b04vQjR5K2dBbjJzajZTam1L?=
 =?utf-8?B?NHZHbzd0UGRUSDVTMDdQbldjaENtZzBjQjkxTlBLUG9OZEIwdDFmbW1tOGtU?=
 =?utf-8?B?aHJ0TzMxcWNkODBkYlRwWjRtTUhLRVE5VHQwYm1PV2pKOUV6UUtVd08zbXZ2?=
 =?utf-8?B?REpXellOYWRzV2gvelR3dTZtOGR2MVNSaHNlYjk2TzdzUnVXckRBcml0VEFN?=
 =?utf-8?B?Y00wOXNqdllqT1hDN0ZQckYyanhOY3E4enJZeWJaOWFQbzZWRzhFYjgyS25J?=
 =?utf-8?B?WHJrMk0xS3pjSzdkQ3BQeWRLRjl2cDZNVGVCMktyeEhuY3grWkxUUEhpU1FB?=
 =?utf-8?B?YzNTeXpnV1drSHMwKytJOExVZ1UyU2Z5LzRCb2g5K1lhY0pOT3Q0c3ZLaUEy?=
 =?utf-8?B?ckZhT2t5TFg2WGNkRjBXV1B3OWV0Zkw4TzRWNHV1RUpHZmk3TTArZkJJK0tT?=
 =?utf-8?B?T2ZVRnhlUVBGbWdURjBDZjk5M0w5TDh1eG9IVlRPT0lKR3lrdGViUEo1clhS?=
 =?utf-8?B?YWNFaFlBYmZ1MGRSZTQ1RTJ1a2Y0cHVEMVhNU3pOQTM4a2x5Rmg1czJLVlRI?=
 =?utf-8?B?S2d4cGVGREE5NHdZTFkxcXAxeExZWkhoTFNkREJ4eGl4bUR1Wks1ZTRiOCtM?=
 =?utf-8?B?TFA0ZzVXdnF3cWZ2cUhzWXpvVmoxRWpmd1A1Z0lremdaNkRHN05obFQvVitT?=
 =?utf-8?B?TS9aaVJ2MVZQdm9nakw0TU13VFJ1eXA3SUpjZ2JUVitRMkl6T3o3bWtrdXFB?=
 =?utf-8?Q?GeX+EXLAUHFNMBs7uVmEoiVGnsTzCs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 01:38:47.2945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34802199-b8f9-41e8-b514-08dd553d25f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676



On 2/25/2025 3:55 AM, Xin Long wrote:
> On Mon, Feb 24, 2025 at 4:01 AM Jianbo Liu <jianbol@nvidia.com> wrote:
>>
>>
>>
>> On 8/13/2024 1:17 AM, Xin Long wrote:
>>> Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-action
>>> label counting"), we should also switch to per-action label counting
>>> in openvswitch conntrack, as Florian suggested.
>>>
>>> The difference is that nf_connlabels_get() is called unconditionally
>>> when creating an ct action in ovs_ct_copy_action(). As with these
>>> flows:
>>>
>>>     table=0,ip,actions=ct(commit,table=1)
>>>     table=1,ip,actions=ct(commit,exec(set_field:0xac->ct_label),table=2)
>>>
>>> it needs to make sure the label ext is created in the 1st flow before
>>> the ct is committed in ovs_ct_commit(). Otherwise, the warning in
>>> nf_ct_ext_add() when creating the label ext in the 2nd flow will
>>> be triggered:
>>>
>>>      WARN_ON(nf_ct_is_confirmed(ct));
>>>
>>
>> Hi Xin Long,
>>
>> The ct can be committed before openvswitch handles packets with CT
>> actions. And we can trigger the warning by creating VF and running ping
>> over it with the following configurations:
>>
>> ovs-vsctl add-br br
>> ovs-vsctl add-port br eth2
>> ovs-vsctl add-port br eth4
>> ovs-ofctl add-flow br "table=0, in_port=eth4,ip,ct_state=-trk
>> actions=ct(table=1)"
>> ovs-ofctl add-flow br "table=1, in_port=eth4,ip,ct_state=+trk+new
>> actions=ct(exec(set_field:0xef7d->ct_label), commit), output:eth2"
>> ovs-ofctl add-flow br "table=1, in_port=eth4,ip,ct_label=0xef7d,
>> ct_state=+trk+est actions=output:eth2"
>>
>> The eth2 is PF, and eth4 is VF's representor.
>> Would you like to fix it?
> Hi, Jianbo,
> 
> Sure, we have to attach a new ct to the skb in __ovs_ct_lookup() for
> this case, and even delete the one created before ovs_ct.
> 
> Can you check if this works on your env?

Yes, it works.
Could you please submit the formal patch? Thanks!

> 
> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> index 3bb4810234aa..c599ee013dfe 100644
> --- a/net/openvswitch/conntrack.c
> +++ b/net/openvswitch/conntrack.c
> @@ -595,6 +595,11 @@ static bool skb_nfct_cached(struct net *net,
>               rcu_dereference(timeout_ext->timeout))
>               return false;
>       }
> +    if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) && !nf_ct_labels_find(ct)) {
> +        if (nf_ct_is_confirmed(ct))
> +            nf_ct_delete(ct, 0, 0);
> +        return false;
> +    }
> 
> Thanks.
> 
>>
>> Thanks!
>> Jianbo
>>
>>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
>>> ---
>>> v2: move ovs_net into #if in ovs_ct_exit() as Jakub noticed.
>>> ---
>>>    net/openvswitch/conntrack.c | 30 ++++++++++++------------------
>>>    net/openvswitch/datapath.h  |  3 ---
>>>    2 files changed, 12 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
>>> index 8eb1d644b741..a3da5ee34f92 100644
>>> --- a/net/openvswitch/conntrack.c
>>> +++ b/net/openvswitch/conntrack.c
>>> @@ -1368,11 +1368,8 @@ bool ovs_ct_verify(struct net *net, enum ovs_key_attr attr)
>>>            attr == OVS_KEY_ATTR_CT_MARK)
>>>                return true;
>>>        if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
>>> -         attr == OVS_KEY_ATTR_CT_LABELS) {
>>> -             struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>>> -
>>> -             return ovs_net->xt_label;
>>> -     }
>>> +         attr == OVS_KEY_ATTR_CT_LABELS)
>>> +             return true;
>>>
>>>        return false;
>>>    }
>>> @@ -1381,6 +1378,7 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
>>>                       const struct sw_flow_key *key,
>>>                       struct sw_flow_actions **sfa,  bool log)
>>>    {
>>> +     unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
>>>        struct ovs_conntrack_info ct_info;
>>>        const char *helper = NULL;
>>>        u16 family;
>>> @@ -1409,6 +1407,12 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
>>>                return -ENOMEM;
>>>        }
>>>
>>> +     if (nf_connlabels_get(net, n_bits - 1)) {
>>> +             nf_ct_tmpl_free(ct_info.ct);
>>> +             OVS_NLERR(log, "Failed to set connlabel length");
>>> +             return -EOPNOTSUPP;
>>> +     }
>>> +
>>>        if (ct_info.timeout[0]) {
>>>                if (nf_ct_set_timeout(net, ct_info.ct, family, key->ip.proto,
>>>                                      ct_info.timeout))
>>> @@ -1577,6 +1581,7 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
>>>        if (ct_info->ct) {
>>>                if (ct_info->timeout[0])
>>>                        nf_ct_destroy_timeout(ct_info->ct);
>>> +             nf_connlabels_put(nf_ct_net(ct_info->ct));
>>>                nf_ct_tmpl_free(ct_info->ct);
>>>        }
>>>    }
>>> @@ -2002,17 +2007,9 @@ struct genl_family dp_ct_limit_genl_family __ro_after_init = {
>>>
>>>    int ovs_ct_init(struct net *net)
>>>    {
>>> -     unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>        struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>>>
>>> -     if (nf_connlabels_get(net, n_bits - 1)) {
>>> -             ovs_net->xt_label = false;
>>> -             OVS_NLERR(true, "Failed to set connlabel length");
>>> -     } else {
>>> -             ovs_net->xt_label = true;
>>> -     }
>>> -
>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>        return ovs_ct_limit_init(net, ovs_net);
>>>    #else
>>>        return 0;
>>> @@ -2021,12 +2018,9 @@ int ovs_ct_init(struct net *net)
>>>
>>>    void ovs_ct_exit(struct net *net)
>>>    {
>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>        struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>>>
>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>        ovs_ct_limit_exit(net, ovs_net);
>>>    #endif
>>> -
>>> -     if (ovs_net->xt_label)
>>> -             nf_connlabels_put(net);
>>>    }
>>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
>>> index 9ca6231ea647..365b9bb7f546 100644
>>> --- a/net/openvswitch/datapath.h
>>> +++ b/net/openvswitch/datapath.h
>>> @@ -160,9 +160,6 @@ struct ovs_net {
>>>    #if IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>        struct ovs_ct_limit_info *ct_limit_info;
>>>    #endif
>>> -
>>> -     /* Module reference for configuring conntrack. */
>>> -     bool xt_label;
>>>    };
>>>
>>>    /**
>>


