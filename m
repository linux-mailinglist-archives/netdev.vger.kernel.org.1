Return-Path: <netdev+bounces-168916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 230F8A41803
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09736171F74
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A2719067C;
	Mon, 24 Feb 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qglvDVLm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7FEEB5
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387710; cv=fail; b=mEd3RvsNrUSLP59MZ98/GJzwyXae4+yO3pckWB43pXAZwUWvPGSbowHeCRDyoxF+nyRO3hOtj1DkLcAQO7vuK8SPpjSgqWERVFNBLRuK8CVjidAzLKo496rE3s5BjMdB3alfjxsi1JD0cLlMxlRmo1vxyhXiG+iXJHEfaK+orsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387710; c=relaxed/simple;
	bh=tjHdXygWR4nZWa/t0lt3BUSLc48qarmpUdD3k69mCWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V/xuOlE2B7P66Y5QH3AlVOGYsn+1ZBLUFPrasIdHRgU3YkjrcrgLGsS1/c7Ryn7bxts73jvdLsKsPCofcw0IeqT5n8pAt5Yb3pr0Et5W0/dNGVqYjZv9teKRx1mMltmYopTJuARRhXGUE/npjjcfvUF0IBlPSEpRctB3kFgcCdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qglvDVLm; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHLjbufS4VzkKKi9BEuvEylxM3gPu+SoueRBLuccE4EYPTsVlbNF6GpQ2uZqmL+X2hXFTYvGxYDys/oHnglMnpasbsg7FXLRioYvEHgzfUDSGgUGff+omskMcWm6KIFl97uI63ehwgawAJmDm8LaUl1+ry4dw9IIl6FxNv7LkngCV8C1KpdxXVk33WxutyggAc3/glVAk3jYY5RYocFstwzelB2JpaawIpqkKJd0XJ4zDKrdROxgYdX6cYdnl2HnJ9J9RI+nY9OKOP4rifwLOGFoa5os2OEJ4X/bpwSGJJ/z/J0K3HxGbmBvDZV1UkYxywr9oMFR3fCufEB9Mhf5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGfHrqaOOpnIJ6TQSVAL2yW3JxDWPUoSFLzxWu1Wk7E=;
 b=s1Khp/zFdxyelq3YLylgA2S2ooqy9e2x9QapFdJ8JhrQCqjUSf65hRjrDxroPRuzmRNq8iptUd0RTEdGi8v8gOHeqO4KDL3VTnQ7u/q7/So6NPpne1qEQMyehIQGX6r3ebkDoLZhRGq9ZSpayKgy8kkVMi/YF2w011AsVqVDdo8xBvaPjARIaOSkkJqtOgJtcGuUmd0bZf+TkWakvFTBJeFqnvtNLWjwbL2SMaF6waWLLG4Z6KCK3OdixAEauKjMCnCYFMD5BteSw8KrpeJFGKse63x6+z02pGtkFhpMTP6B0DPJsrmc1oTftNu1r0h0rjuFctowP7OBW5RytelbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGfHrqaOOpnIJ6TQSVAL2yW3JxDWPUoSFLzxWu1Wk7E=;
 b=qglvDVLmNykFtjPR72t6Ce/U9mjeZZFSG/rqFLr/1OvZODisvSZ6TXxj5oLzRH3TBCP9/ejVgiBLAq3nXk3d5QcpmP+N8FT6dStHGdaW7g+0IRr9P2PAdDxtK8zMnEoX+VsXTI35D7cLom9RuydFIkaSEPtjgA1Ax0sTKUoSnsBrlYBUkb+wgXpDGR6ArFesaDMFcIL/waAXPPNLGca2Dv5hzwKCH157DpexFjsWC/5V+sljFmmdg1bvBIv1v6PFwpRd2eFMja5NdmGSzYiaazwabAqp0xoCTQcYMudVoKRODRX+hgUZ60Q1LH/GQ+JhNWIOvZn7kHJHONaa/Y2oYA==
Received: from BY5PR17CA0071.namprd17.prod.outlook.com (2603:10b6:a03:167::48)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 09:01:44 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::69) by BY5PR17CA0071.outlook.office365.com
 (2603:10b6:a03:167::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Mon,
 24 Feb 2025 09:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 09:01:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 01:01:31 -0800
Received: from [10.19.165.164] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 01:01:28 -0800
Message-ID: <2ee4d016-5e57-4d86-9dca-e4685cb183bb@nvidia.com>
Date: Mon, 24 Feb 2025 17:01:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next] openvswitch: switch to per-action label
 counting in conntrack
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
	<dev@openvswitch.org>, <ovs-dev@openvswitch.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar
	<pshelar@ovn.org>, Ilya Maximets <i.maximets@ovn.org>, Aaron Conole
	<aconole@redhat.com>, Florian Westphal <fw@strlen.de>
References: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ceb61ac-ff8a-4a91-6648-08dd54b1dc84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3l4VmlIK3g2OHRrTUdaTnBtNU85V3NIblQvRzJBQjU1K3VVNkV0cmxpVGh6?=
 =?utf-8?B?eUo5OExmWTBYMDBiZjBraUt1VWtZL2hLSVVDYUdsL3MxVHdFbEc5SFFEdmF1?=
 =?utf-8?B?S1ExTzNKcXlNWi92QzhyVG0rMkVjYVJDQTQ3NFpCMTVidFZweThxK0swQ3li?=
 =?utf-8?B?THB0a2JpRFdlUm5rbC9IOUZneDJlWit0QWpVZFQvVXc4V3pubFZYano5ZTha?=
 =?utf-8?B?dE9XSGJjLzYrOUtXd0plOW1YcTF1NzVvZGxHbzliWGMwQ2o3Q3JoYVpkbjBP?=
 =?utf-8?B?Z3AvU0oxRXBJNkxqTEpSU2hZUmNyVTBJNUszMDRPMzRzNFkvTDlXcFhCeTVC?=
 =?utf-8?B?WEx0MGdyN0s1aks2aktxVHRiTGxaVXdvTkswaDJIWjl5Z0J1RGVEVWFhWEdV?=
 =?utf-8?B?RzhlSkJoVDkraUFYNGFGbkdGUTRuZlBseWordXdXaEJVbjFEekxuQm5VcENZ?=
 =?utf-8?B?MEFTYmlUUkpwR0Y1YjFuaGpRQnBkL0xJUVdVUGwrOXdpQTUzcmN0cG5vb2JP?=
 =?utf-8?B?a0hEamRTdHhVUWRIZ1RzK3BDMnF4cG9UZ3pCQlRwOG45OVZGYmhkaDJZZE5R?=
 =?utf-8?B?aGR0TEU1Ykw3S2VaMS9VSmxybWo4WUtoNGc5VE56NGZibGtCRnZhcmVaL2lN?=
 =?utf-8?B?UGtLZGp3TWZZNGZGWjJOa0hEUVdYRkRYb1lrRFJuYkhTK1UyNlFycGZIdnMx?=
 =?utf-8?B?a0lld0h4ZGZvKy9uMnFsRGlQNmdTWWdWdG9aSmtudkVTZGlGeG5lRVdPSzJn?=
 =?utf-8?B?SmFpSGFYNkhFRktsZmxISkNLQWIrZ1g2MzV1YlBrNFZVb1F3dXdISWEwWHBq?=
 =?utf-8?B?WWlpYXVwMFpZcEFXeHFjblRsNnJEa21GUWpRb3Y2TGRHL0VOaUdmK2puNEVN?=
 =?utf-8?B?akYwYk94clZta3g3a3dISEl0a0ljZHlFbWtBTlQ1VzdITmt1ZnhlNGVueHJ3?=
 =?utf-8?B?VTJwYnQ0WVN5em9hV2dIdGRYL1puTXQreGtoOUNXb3RDUktMZSt5M3EzcHdD?=
 =?utf-8?B?Wk9QdzhhTUFtUVppVW5nMm9XM0JmcVBXaE1SOFlRb1JLcUVZcDFvYURHK2kw?=
 =?utf-8?B?UnQ0elRnUXRNNGppMGY5blh2OVh4aTBFYmlLTlNzK0NkVW54dk03c0QvaFJO?=
 =?utf-8?B?VXRUTGtYaUVrV3RZVjBKYzE2cmRUZTVuUHBkTHF0NjUxYkRJM29GV0pvN1RG?=
 =?utf-8?B?UWtMODVLeFZQaDQ1S1dlVHlWU2JjZUtYUGd1azZQV2tXZ1hhN1k3SW1lWE80?=
 =?utf-8?B?TDgzdUgvKzJGZmw2akpEdXJ1andnNTh3OXFNOS9UdHlCUFl4Mk5BTWg1YkpY?=
 =?utf-8?B?RWVyMHNMOTg1SEhscEwyRzNNY2k4alpKeDR1R0hNUkpENXVBQnJVcGpNMDh2?=
 =?utf-8?B?WWc0cGpoNHNXMi9CdEorR1FNb3hlbHhXbExSOTM4R1R3RWNJdElVa2ZmT0RT?=
 =?utf-8?B?MGN4Qm5RRW5xbFM4dzdqR2lHS2xTZDZsRjhUYzJkS3d3RUNzQkkxUHJRMFFa?=
 =?utf-8?B?ejJLQlM1Vk5sMUpoaHhBRVE5b0U2WG9wc0l0VWJjSWwzaFJDNWVCMHl1U0Vi?=
 =?utf-8?B?Nng3OGRNTUhXMkk1QWVWcXRBM3o5RDRiMUR5dDhudUlhZGZvM3dWZlIxVjB0?=
 =?utf-8?B?T0F6ZmxpdGxCRWY2RUZQQ291dUJRQXVVdVVyZjY3b2tCWSsyZXdIV09DVm54?=
 =?utf-8?B?OXFMT2lIa2t2UG0zUXdjWEY5NFNhOThKdTBPdVEvcGZrUFZ1S3ZCV00waU9p?=
 =?utf-8?B?R1g0c3VZdmdIVHNjYldKVGVGUzhIL2taUGdlM0g3aWx4NmppeVE5dFk0Vk5y?=
 =?utf-8?B?eWdKb1ExdlBpNzgwdm1wNTNoSitiNThudWpOSnh5UmxXWTE3VTZEYXowWTZs?=
 =?utf-8?B?bXJBWlRyazJRSVBZVlhBQWQvK2lEOXEwMm44aHQ5VE9rQ2lKT3REdXN3REdj?=
 =?utf-8?B?L0t5SWszanEzT3RWVThnWm1vbEl6OEtQQXJHaGlnMlhkVTZSamlBRC8yUlIr?=
 =?utf-8?Q?xtKQHlGPu+VyachA65N1raJHn+EWFk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 09:01:44.1775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ceb61ac-ff8a-4a91-6648-08dd54b1dc84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750



On 8/13/2024 1:17 AM, Xin Long wrote:
> Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-action
> label counting"), we should also switch to per-action label counting
> in openvswitch conntrack, as Florian suggested.
> 
> The difference is that nf_connlabels_get() is called unconditionally
> when creating an ct action in ovs_ct_copy_action(). As with these
> flows:
> 
>    table=0,ip,actions=ct(commit,table=1)
>    table=1,ip,actions=ct(commit,exec(set_field:0xac->ct_label),table=2)
> 
> it needs to make sure the label ext is created in the 1st flow before
> the ct is committed in ovs_ct_commit(). Otherwise, the warning in
> nf_ct_ext_add() when creating the label ext in the 2nd flow will
> be triggered:
> 
>     WARN_ON(nf_ct_is_confirmed(ct));
> 

Hi Xin Long,

The ct can be committed before openvswitch handles packets with CT 
actions. And we can trigger the warning by creating VF and running ping 
over it with the following configurations:

ovs-vsctl add-br br
ovs-vsctl add-port br eth2
ovs-vsctl add-port br eth4
ovs-ofctl add-flow br "table=0, in_port=eth4,ip,ct_state=-trk 
actions=ct(table=1)"
ovs-ofctl add-flow br "table=1, in_port=eth4,ip,ct_state=+trk+new 
actions=ct(exec(set_field:0xef7d->ct_label), commit), output:eth2"
ovs-ofctl add-flow br "table=1, in_port=eth4,ip,ct_label=0xef7d, 
ct_state=+trk+est actions=output:eth2"

The eth2 is PF, and eth4 is VF's representor.
Would you like to fix it?

Thanks!
Jianbo

> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
> v2: move ovs_net into #if in ovs_ct_exit() as Jakub noticed.
> ---
>   net/openvswitch/conntrack.c | 30 ++++++++++++------------------
>   net/openvswitch/datapath.h  |  3 ---
>   2 files changed, 12 insertions(+), 21 deletions(-)
> 
> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> index 8eb1d644b741..a3da5ee34f92 100644
> --- a/net/openvswitch/conntrack.c
> +++ b/net/openvswitch/conntrack.c
> @@ -1368,11 +1368,8 @@ bool ovs_ct_verify(struct net *net, enum ovs_key_attr attr)
>   	    attr == OVS_KEY_ATTR_CT_MARK)
>   		return true;
>   	if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
> -	    attr == OVS_KEY_ATTR_CT_LABELS) {
> -		struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
> -
> -		return ovs_net->xt_label;
> -	}
> +	    attr == OVS_KEY_ATTR_CT_LABELS)
> +		return true;
>   
>   	return false;
>   }
> @@ -1381,6 +1378,7 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
>   		       const struct sw_flow_key *key,
>   		       struct sw_flow_actions **sfa,  bool log)
>   {
> +	unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
>   	struct ovs_conntrack_info ct_info;
>   	const char *helper = NULL;
>   	u16 family;
> @@ -1409,6 +1407,12 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
>   		return -ENOMEM;
>   	}
>   
> +	if (nf_connlabels_get(net, n_bits - 1)) {
> +		nf_ct_tmpl_free(ct_info.ct);
> +		OVS_NLERR(log, "Failed to set connlabel length");
> +		return -EOPNOTSUPP;
> +	}
> +
>   	if (ct_info.timeout[0]) {
>   		if (nf_ct_set_timeout(net, ct_info.ct, family, key->ip.proto,
>   				      ct_info.timeout))
> @@ -1577,6 +1581,7 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
>   	if (ct_info->ct) {
>   		if (ct_info->timeout[0])
>   			nf_ct_destroy_timeout(ct_info->ct);
> +		nf_connlabels_put(nf_ct_net(ct_info->ct));
>   		nf_ct_tmpl_free(ct_info->ct);
>   	}
>   }
> @@ -2002,17 +2007,9 @@ struct genl_family dp_ct_limit_genl_family __ro_after_init = {
>   
>   int ovs_ct_init(struct net *net)
>   {
> -	unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
> +#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>   	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>   
> -	if (nf_connlabels_get(net, n_bits - 1)) {
> -		ovs_net->xt_label = false;
> -		OVS_NLERR(true, "Failed to set connlabel length");
> -	} else {
> -		ovs_net->xt_label = true;
> -	}
> -
> -#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>   	return ovs_ct_limit_init(net, ovs_net);
>   #else
>   	return 0;
> @@ -2021,12 +2018,9 @@ int ovs_ct_init(struct net *net)
>   
>   void ovs_ct_exit(struct net *net)
>   {
> +#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>   	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>   
> -#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>   	ovs_ct_limit_exit(net, ovs_net);
>   #endif
> -
> -	if (ovs_net->xt_label)
> -		nf_connlabels_put(net);
>   }
> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
> index 9ca6231ea647..365b9bb7f546 100644
> --- a/net/openvswitch/datapath.h
> +++ b/net/openvswitch/datapath.h
> @@ -160,9 +160,6 @@ struct ovs_net {
>   #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>   	struct ovs_ct_limit_info *ct_limit_info;
>   #endif
> -
> -	/* Module reference for configuring conntrack. */
> -	bool xt_label;
>   };
>   
>   /**


