Return-Path: <netdev+bounces-171077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD412A4B601
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 03:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2CE188BA1A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 02:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD633139579;
	Mon,  3 Mar 2025 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZMK5MQ8K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10227082D
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968099; cv=fail; b=awA7ALQKQlno2e+YDynQqCHdp66vksL2PoHh4LQNGMg7ZTdzxfjvQkEBK6cunRRoG6yLqbYgSAH6sw/kmKjqvOYsxhDPH9ssjjcLfF/DMM7qM7O7oi1Fh3e0wOXRpAOkI1Yur1pCKi0lr/+FIyzqh+bOJtFWesh22kX/ZnBNaBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968099; c=relaxed/simple;
	bh=0o2AhbnHCXHCd9HqGcFjvvzytVMgjMC55vkMFbUPmHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tW7erKt5p/ToIexTdPKyz+1ZBfFKLSETZYQPniscIW2zyxDgML2U9pxgbjF2lp9RHvKxCAJBOikK6R7GIL+57J7AjcfoRR8971psXw5GanaqzmNnJlLjGaA6V8izlDPfX8CzTygxFktqGRoFzwek9y4e4NQjQlxKvr6kc4T1M98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZMK5MQ8K; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVBD+Xq930w4OWZhkM2NfrFO/yrLlWBVEBBHs46DPplv5abNQjajVdFZSWB1ppRbAYm/igaj5UDnQoMCs3dlyQayrl4zViLiDQjQsbkmYtR1aiQWznbjr7N41vz5fO2sisoW4T37aCu6fkRbzPVYz83lRSWgw9VDNeSYS36SbCi8zrz0HzfJtuo6DxKcjs05ciMsc0+DE5ez7+tDCg8WZW11i2Tq3tocs/jcrMTO5hdw/w8thlo3e7IWdgTtDJOuLQf+ntydu1qupeMDwBQqHtCu+ODRvT0eWN2Ug6SX1IHSra0oS3ippfllu3Mo9+LFIllpjomtxBI+MouVQz8SVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FhWvEEwyAbtDn+OtejNMwyzDHrE0kSXmmZLxzVCGac=;
 b=t/0XxE7rBk9cGJZwGjCo13XQzkWjPS9iv6E7O/etnViF7sEycMXrh4N5YVe0hje4WqsxLhEITW73v04fjPZjBhweN0intrOb4ifuXSlkGqx6L6opMmj6KilmyeQhdvQt+A0h1ttiNhkinZM3PwlwggVrRfzWly9W31s2PkdVHyS0momh4pgPFccQ5YM9dsCcnxMuF3AC2YQt/jfpguAK1QzAJg7NhTdbjcFWa8+srJIoHXIWN335BqcDGLl/5207Los1RGTU+qbTW2Hv0h371EpGuMvNTsGB6MiHXAwn3dc0uR+V7razoM1pnZWsZPnL/Qw4F207r1YJixnoONXeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FhWvEEwyAbtDn+OtejNMwyzDHrE0kSXmmZLxzVCGac=;
 b=ZMK5MQ8KDsg5IXe3Id/o2o1dh3/z/Wf5XyHp1eia/zeBR8WK1+3wq1U29uX4fAFArnZiyN9p/NvBu62aU7/pkgXw6lAzZ9SFxuCIMYeaydImPzzbmXI3S8MN1Xv8vaf6p1sclCdPfjmrMAoEbk5zihjkNcQu1Nks3DKRxdfHDYUV4l1Q/WMocEZXwrX8sX6Y3VOfHneBPEFKN/ZRKsx3PLFhSE/iowVHAu81k2m4xrK1OUz3fPCgOArb8J0lTIEl/BfFKEhbMKwZi9G9elWmePIhTxdqUGon3HR9WXMA7BqNELt4HNdvis6MKAHH7VXJVNTnctbcOASKtnam/ACnBQ==
Received: from DS7PR03CA0325.namprd03.prod.outlook.com (2603:10b6:8:2b::34) by
 CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.28; Mon, 3 Mar
 2025 02:14:55 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::4d) by DS7PR03CA0325.outlook.office365.com
 (2603:10b6:8:2b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 02:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 02:14:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 2 Mar 2025
 18:14:44 -0800
Received: from [10.19.167.157] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 2 Mar
 2025 18:14:41 -0800
Message-ID: <7061a416-56cb-4751-8576-8071c2205d70@nvidia.com>
Date: Mon, 3 Mar 2025 10:14:42 +0800
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
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <CADvbK_cungrr_D5VAiL8C+FSJEoLFYtMxV5foU0XA9E4zrcegA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 7682d74f-f286-4546-dc6d-08dd59f930aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0Z2Umt3cXpQNnhHU0ptZ0F5YlpoM3FDZlc0Uk9hZjc2RWVQc2FrVytKSWl1?=
 =?utf-8?B?cWZEZS9tQnIvTisyUElVeTJpMjlVSmE5TmYrMlMyaitPbDdxbHlvUHczKzJx?=
 =?utf-8?B?dEkrWHFRV1hlREhGS0lDdzF2LzQ2NmhnWFF6WjhIaTNiNGJ0VkMya2c5UXN3?=
 =?utf-8?B?ZUdWeThGV0xneXJMaHgxL2R6ZlpDN0ZmQXFFbEM5UVh0blI1dWU0bzhhMWs1?=
 =?utf-8?B?WjYyRm5wajRSekJaaTFIWHBPTE50V3ZwMEc1VXYrczJSeGk1TmZpSDk4eFNq?=
 =?utf-8?B?U1V1cjMxd1diWWxQdlJIRDF3ZzdNUGI4aXBWQ2grbno3Y3pidmJhRnV2Qm5o?=
 =?utf-8?B?aHpsTE5HblZSSG5VdjRmb2ZQeDBZL3A4YTBPVWs5L09Ealh0akswWDM3b1Iv?=
 =?utf-8?B?UVFTQlAxbmNpa0kvdUgvWVgzOVJIZWliL3pWbFM1ck53QXJiOTdjb1l4b29F?=
 =?utf-8?B?VkNZR2N5NzVBa3BFa0kxOFhjZ080U3FzUTdFb1Vqc1RLWDlMd2tXTWJ4cE5t?=
 =?utf-8?B?WDlycUxxckRFVEdVN0hINXRtcy9tUEZTOFg1M2d3Zm0zTGVRUzJHeTRUbk1G?=
 =?utf-8?B?ZmNUSUx4cml3NmpSaWo3OVBzM3E3UGhUbmRVd2hlUWE0NEdHM1QvS28xdXAz?=
 =?utf-8?B?d3laMmdYSFdGOGdHODdmUjF3eXg3MGxxOEZKV0J2Z2F4NUs0YkJ6R1ZTbFJt?=
 =?utf-8?B?d0Y3S0dyQmUzVnFFSlNWZHJpcHl6V0ZMTXczMDYrOHhFQTRobFdGSlFJS1hW?=
 =?utf-8?B?Mm1Ha2dtS1ZZSDBsZSs3eFljQ2ZCTWl5eHgxYVg1T0U1RE1iV1FGbnozbTkv?=
 =?utf-8?B?RW03R1piaFkxSkpOZ2lQZG80UFBiNm1GZUFIMDl1SkJ2dnVhWEJVM29xV3pU?=
 =?utf-8?B?OUI3MXYwVDhsbTJKQURiOU1hOXZnVmRVY3lEWkM4ZjNPS291czd6WGROMHdv?=
 =?utf-8?B?Sm03QURmSTZSZjVid1FoUkRsL3JTYmNqREhyKzRzY1NTVzlBNmgvdzVsVlow?=
 =?utf-8?B?Q3dySi9sYzVmOFhSM0ovNTlrVFBING1DY0lITkRHQ0ZEVkR2ZEZxaTR0NFBP?=
 =?utf-8?B?U0Rva0lqYTBhejBFNm52dFlmV0FIV2FuTi9CZXRiOG5VWDh3TkxXNVRmWFN6?=
 =?utf-8?B?MUppSWVTSWEvVDl0dEJQRk5QV0pVU2lYTnAzaFpQdXptSXd4endwSTdGTjBO?=
 =?utf-8?B?ME1BeTEyemdPMXFiY3E3SzE1K1JYYzh4WEFTSmZTUys5ODNxbDlYdE1PUlY4?=
 =?utf-8?B?S2I4Uk8rejh5akc3ckQ2N2tmNlhlYjd2TXorN2Z4Mm1zL3Y5MGhaYlJTaElq?=
 =?utf-8?B?TjRkTXJ6ZEdwVzl3V0FKeWdUcDZUV3Frcmx0MW5UNGRTSU03NUdnaG1pWHJi?=
 =?utf-8?B?dEJBYjg4RDFkZ0xHUWFnSVp6djV1WWlFSWd3NXg4N05IUFprTkRBSUlNSTR2?=
 =?utf-8?B?bzc1ZnkxK21HVzJZMjE5WUlEbktVYlROWkJyZU9Xbll0UnJXMm9aYUVuUzNZ?=
 =?utf-8?B?SkwzTDBHY2Z4VmZZbHBHQjZ5Q2ZOd20vWEw0V0dJMWh6dkVWN0ZOem51enhm?=
 =?utf-8?B?ek16TjlqS0F3R21pK0hKOFZ6Q0FPODBJNUZ0L3hUZ2dlbEQxaHNucHFSUnU5?=
 =?utf-8?B?UWw4R2lxYW9ua010L2lOdi9qYkVNQk1TRzQvMkg0NmZleitsV3hFVEdXRGRt?=
 =?utf-8?B?aHRJSEtjbUhqS3RVSjl1dEZ4RDNxSENqSXpKdzhQL0RIcjdPM0hJS0taN1VT?=
 =?utf-8?B?THozazZsV2ljQkFXOXF5OXdZVUkycTg3eHFaRkdWSSs3bElrekJtMnlNclA5?=
 =?utf-8?B?Y1IrSFN5RW5DNHp0bzc3M3hMbVVCSzZjL3h5MTQyckJubkNDeGxSRFBDMHZF?=
 =?utf-8?B?RUI3ZFNBeFNxTVcwaUkrWkRCSzJ6cUZ2T01iY09XL3lGTUZpaE13ZStya1dV?=
 =?utf-8?B?VXRuSXBPbFFmaXpPdDZ4MnBjeTZ3SXRRSG1uN25zVWZEaThPMnZMc2pzSzEy?=
 =?utf-8?Q?Kky9PPiELEPyy8b3Sghhty/kRRMzEU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 02:14:55.3148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7682d74f-f286-4546-dc6d-08dd59f930aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549



On 3/3/2025 2:22 AM, Xin Long wrote:
> On Tue, Feb 25, 2025 at 9:57 AM Xin Long <lucien.xin@gmail.com> wrote:
>>
>> On Mon, Feb 24, 2025 at 8:38 PM Jianbo Liu <jianbol@nvidia.com> wrote:
>>>
>>>
>>>
>>> On 2/25/2025 3:55 AM, Xin Long wrote:
>>>> On Mon, Feb 24, 2025 at 4:01 AM Jianbo Liu <jianbol@nvidia.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 8/13/2024 1:17 AM, Xin Long wrote:
>>>>>> Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-action
>>>>>> label counting"), we should also switch to per-action label counting
>>>>>> in openvswitch conntrack, as Florian suggested.
>>>>>>
>>>>>> The difference is that nf_connlabels_get() is called unconditionally
>>>>>> when creating an ct action in ovs_ct_copy_action(). As with these
>>>>>> flows:
>>>>>>
>>>>>>      table=0,ip,actions=ct(commit,table=1)
>>>>>>      table=1,ip,actions=ct(commit,exec(set_field:0xac->ct_label),table=2)
>>>>>>
>>>>>> it needs to make sure the label ext is created in the 1st flow before
>>>>>> the ct is committed in ovs_ct_commit(). Otherwise, the warning in
>>>>>> nf_ct_ext_add() when creating the label ext in the 2nd flow will
>>>>>> be triggered:
>>>>>>
>>>>>>       WARN_ON(nf_ct_is_confirmed(ct));
>>>>>>
>>>>>
>>>>> Hi Xin Long,
>>>>>
>>>>> The ct can be committed before openvswitch handles packets with CT
>>>>> actions. And we can trigger the warning by creating VF and running ping
>>>>> over it with the following configurations:
>>>>>
>>>>> ovs-vsctl add-br br
>>>>> ovs-vsctl add-port br eth2
>>>>> ovs-vsctl add-port br eth4
>>>>> ovs-ofctl add-flow br "table=0, in_port=eth4,ip,ct_state=-trk
>>>>> actions=ct(table=1)"
>>>>> ovs-ofctl add-flow br "table=1, in_port=eth4,ip,ct_state=+trk+new
>>>>> actions=ct(exec(set_field:0xef7d->ct_label), commit), output:eth2"
>>>>> ovs-ofctl add-flow br "table=1, in_port=eth4,ip,ct_label=0xef7d,
>>>>> ct_state=+trk+est actions=output:eth2"
>>>>>
>>>>> The eth2 is PF, and eth4 is VF's representor.
>>>>> Would you like to fix it?
>>>> Hi, Jianbo,
>>>>
>>>> Sure, we have to attach a new ct to the skb in __ovs_ct_lookup() for
>>>> this case, and even delete the one created before ovs_ct.
>>>>
>>>> Can you check if this works on your env?
>>>
>>> Yes, it works.
>>> Could you please submit the formal patch? Thanks!
>> Great, I will post after running some of my local tests.
>>
> Hi Jianbo,
> 
> I recently ran some tests and observed that the current approach cannot
> completely avoid the warning. If an skb enters __ovs_ct_lookup() without
> an attached connection tracking (ct) entry, it may still acquire an
> existing ct created outside of OVS (possibly by netfilter) through
> nf_conntrack_in(). This will trigger the warning in ovs_ct_set_labels().
> 
> Deleting a ct created outside OVS and creating a new one within
> __ovs_ct_lookup() doesn't seem reasonable and would be difficult to

Yes, I'm also skeptical of your temporary fix, and waiting for your 
formal one.

> implement. However, since OVS is not supposed to use ct entries created
> externally, I believe ct zones can be used to prevent this issue.
> In your case, the following flows should work:
> 
> ovs-ofctl add-flow br "table=0, in_port=eth4,ip,ct_state=-trk
> actions=ct(table=1,zone=1)"
> ovs-ofctl add-flow br "table=1,
> in_port=eth4,ip,ct_state=+trk+new,ct_zone=1
> actions=ct(exec(set_field:0xef7d->ct_label),commit,zone=1),
> output:eth2"
> ovs-ofctl add-flow br "table=1,
> in_port=eth4,ip,ct_label=0xef7d,ct_state=+trk+est,ct_zone=1
> actions=output:eth2"
> 
> Regarding the warning triggered by externally created ct entries, I plan
> to remove the ovs_ct_get_conn_labels() call from ovs_ct_set_labels() and
> I'll let nf_connlabels_replace() return an error in such cases, similar
> to how tcf_ct_act_set_labels() handles this scenario in tc act_ct.
> 

It's a good idea to be consistent with act_ct implementation. But, would 
you like to revert first if it takes long time to work on the fix?

Thanks!

> Thanks.
>>>
>>>>
>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
>>>> index 3bb4810234aa..c599ee013dfe 100644
>>>> --- a/net/openvswitch/conntrack.c
>>>> +++ b/net/openvswitch/conntrack.c
>>>> @@ -595,6 +595,11 @@ static bool skb_nfct_cached(struct net *net,
>>>>                rcu_dereference(timeout_ext->timeout))
>>>>                return false;
>>>>        }
>>>> +    if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) && !nf_ct_labels_find(ct)) {
>>>> +        if (nf_ct_is_confirmed(ct))
>>>> +            nf_ct_delete(ct, 0, 0);
>>>> +        return false;
>>>> +    }
>>>>
>>>> Thanks.
>>>>
>>>>>
>>>>> Thanks!
>>>>> Jianbo
>>>>>
>>>>>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
>>>>>> ---
>>>>>> v2: move ovs_net into #if in ovs_ct_exit() as Jakub noticed.
>>>>>> ---
>>>>>>     net/openvswitch/conntrack.c | 30 ++++++++++++------------------
>>>>>>     net/openvswitch/datapath.h  |  3 ---
>>>>>>     2 files changed, 12 insertions(+), 21 deletions(-)
>>>>>>
>>>>>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
>>>>>> index 8eb1d644b741..a3da5ee34f92 100644
>>>>>> --- a/net/openvswitch/conntrack.c
>>>>>> +++ b/net/openvswitch/conntrack.c
>>>>>> @@ -1368,11 +1368,8 @@ bool ovs_ct_verify(struct net *net, enum ovs_key_attr attr)
>>>>>>             attr == OVS_KEY_ATTR_CT_MARK)
>>>>>>                 return true;
>>>>>>         if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
>>>>>> -         attr == OVS_KEY_ATTR_CT_LABELS) {
>>>>>> -             struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>>>>>> -
>>>>>> -             return ovs_net->xt_label;
>>>>>> -     }
>>>>>> +         attr == OVS_KEY_ATTR_CT_LABELS)
>>>>>> +             return true;
>>>>>>
>>>>>>         return false;
>>>>>>     }
>>>>>> @@ -1381,6 +1378,7 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
>>>>>>                        const struct sw_flow_key *key,
>>>>>>                        struct sw_flow_actions **sfa,  bool log)
>>>>>>     {
>>>>>> +     unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
>>>>>>         struct ovs_conntrack_info ct_info;
>>>>>>         const char *helper = NULL;
>>>>>>         u16 family;
>>>>>> @@ -1409,6 +1407,12 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
>>>>>>                 return -ENOMEM;
>>>>>>         }
>>>>>>
>>>>>> +     if (nf_connlabels_get(net, n_bits - 1)) {
>>>>>> +             nf_ct_tmpl_free(ct_info.ct);
>>>>>> +             OVS_NLERR(log, "Failed to set connlabel length");
>>>>>> +             return -EOPNOTSUPP;
>>>>>> +     }
>>>>>> +
>>>>>>         if (ct_info.timeout[0]) {
>>>>>>                 if (nf_ct_set_timeout(net, ct_info.ct, family, key->ip.proto,
>>>>>>                                       ct_info.timeout))
>>>>>> @@ -1577,6 +1581,7 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
>>>>>>         if (ct_info->ct) {
>>>>>>                 if (ct_info->timeout[0])
>>>>>>                         nf_ct_destroy_timeout(ct_info->ct);
>>>>>> +             nf_connlabels_put(nf_ct_net(ct_info->ct));
>>>>>>                 nf_ct_tmpl_free(ct_info->ct);
>>>>>>         }
>>>>>>     }
>>>>>> @@ -2002,17 +2007,9 @@ struct genl_family dp_ct_limit_genl_family __ro_after_init = {
>>>>>>
>>>>>>     int ovs_ct_init(struct net *net)
>>>>>>     {
>>>>>> -     unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
>>>>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>         struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>>>>>>
>>>>>> -     if (nf_connlabels_get(net, n_bits - 1)) {
>>>>>> -             ovs_net->xt_label = false;
>>>>>> -             OVS_NLERR(true, "Failed to set connlabel length");
>>>>>> -     } else {
>>>>>> -             ovs_net->xt_label = true;
>>>>>> -     }
>>>>>> -
>>>>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>         return ovs_ct_limit_init(net, ovs_net);
>>>>>>     #else
>>>>>>         return 0;
>>>>>> @@ -2021,12 +2018,9 @@ int ovs_ct_init(struct net *net)
>>>>>>
>>>>>>     void ovs_ct_exit(struct net *net)
>>>>>>     {
>>>>>> +#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>         struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>>>>>>
>>>>>> -#if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>         ovs_ct_limit_exit(net, ovs_net);
>>>>>>     #endif
>>>>>> -
>>>>>> -     if (ovs_net->xt_label)
>>>>>> -             nf_connlabels_put(net);
>>>>>>     }
>>>>>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
>>>>>> index 9ca6231ea647..365b9bb7f546 100644
>>>>>> --- a/net/openvswitch/datapath.h
>>>>>> +++ b/net/openvswitch/datapath.h
>>>>>> @@ -160,9 +160,6 @@ struct ovs_net {
>>>>>>     #if IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>>>>>         struct ovs_ct_limit_info *ct_limit_info;
>>>>>>     #endif
>>>>>> -
>>>>>> -     /* Module reference for configuring conntrack. */
>>>>>> -     bool xt_label;
>>>>>>     };
>>>>>>
>>>>>>     /**
>>>>>
>>>


