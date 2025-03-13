Return-Path: <netdev+bounces-174439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F4DA5EA1C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 04:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBD61690CE
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 03:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3404C9D;
	Thu, 13 Mar 2025 03:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OXW5vXUD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5284513AA20
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741835894; cv=fail; b=GgcqKxO/lnf0yXO3YdIdw0ce513rosyWjb9LHAGH02JhSWq876mxn+Zn/R+R4RP/HeSNDWHFnoA7fpMIY3z89zUp4qo2XVA5Kt1V4ucFjzRj7ewpFY95iI9BvV8X+kq+cVPJ06XLW9FyJ1qxnTHFSEjfrnDm0s6PQ8UfkCGV6ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741835894; c=relaxed/simple;
	bh=D17+hY9JyAW0eWxfb3zF04qvUNsfYHCBjKzQJ6Q8oMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bBkvq/vlAA8a5KX6f4SoznXD5q2QVKDJiNyIsGwWjvP86WYoj0v1p+iOF6Rr/xP+XIqI6LpR50iD7APVTEemt5r+1IrmaTJFqkqDtni2bgHKR7g4GW7jR+3rtsvoc7CiSnk5jv6QfPA4TXXj6Hz8KdL+VN5UqGH7f3jt7C2GK2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OXW5vXUD; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjCkiuCBTD7UYbcap0YYaz393SPn3chSIuxwq2UtBReVjf//GfYTeOdcZS1ZTPa3oI1zL2iK3di6OsaOSukx1iQHdbdkZHIpe1fFw2qdAAltAXyKbhVbm3UT3FNdUQNIMEhp4aAoR8p64t99suHQZsVY+WPLuMhFOiGQW1w3VnAZ5Lqe/dgg0CQu5wgTm9LA2eRx/GbDkXQVmZ/eEZs5SF1VI+JviEVj5Xl9sQ94aRJQNN5RtFC3x/ZBLl1SJbgig3GO/frXEEI5152S56gh9o+j94/XGMmn4EmPVX6EoZ8/rU3s3kuxdXQijSo9209nRzhMwZixlHAGXWp/Mq2DKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v48ZqyJtrJxc+0xdlfK32IFtSGY7o9GLS6yq+eF5PkY=;
 b=mhmGbWLwodIGmg/4ImzPjsLfJqepInSMSaOr4Q0LnCbSyvSea1u85xAAwBC5NyPImzbumVey3nHa99gexXWG+iGcO6kbV4B1RZkamzOaPRTCFLfY//mMDa7cCQOMj7S7hLrQg3jiGl7nmqLBm5AwpshKjcs0Wj/AjGFws/duJOgEBklql7UqpoMy+05w0Sx/W/TExVwoaejI9ncSCy1g8JpiVTcc5c/oPpG9FlXXByvBk263dFCm5slcAdSAqDWlS617yAvAk8HdlXI2bblwlLrlIxmqGRfxZxJ1VL+5cBCouBRsPFKmHPcwzyIp53n6KS4839tafYyQ7cAmqDGBBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v48ZqyJtrJxc+0xdlfK32IFtSGY7o9GLS6yq+eF5PkY=;
 b=OXW5vXUD2a+MENTDoNRZ/F9rRx06Kb8TbpSQiGnOEosWoPGB/fDXwuoU5/FQtWb/+yRkzXIM0QEJ9lADvMvgXaJD1TsRGnvG2MceCdpcNxo/IDss6J5D0xflXeAAaCPz/sslFKN2Jzz8j1+u+y2/Np9MvWtnfXRzPOkd80Gn6l65QYc5QLQPbWqQVP3TF7ZBgUQQ/gWBTdxjRo3Y1BgKlFr70vbRYpptaw/9lHKbnT2MizF3xGLDOwNLtq/aui6kGYPAKcz9IPxd8YvAWvE8wIFm6q3KHunwNc3vMv6P/sKJM2R7l42J8DWkGpmyt52I68vgSb4JQWKWX0vi4XfwGA==
Received: from BLAPR05CA0046.namprd05.prod.outlook.com (2603:10b6:208:335::26)
 by LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 03:18:08 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::b8) by BLAPR05CA0046.outlook.office365.com
 (2603:10b6:208:335::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Thu,
 13 Mar 2025 03:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 03:18:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Mar
 2025 20:17:56 -0700
Received: from [10.19.164.127] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 20:17:52 -0700
Message-ID: <fd11917d-ff8e-4de3-ba65-6e5da993db6a@nvidia.com>
Date: Thu, 13 Mar 2025 11:17:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ovs-dev] [PATCH net] Revert "openvswitch: switch to per-action
 label counting in conntrack"
To: Aaron Conole <aconole@redhat.com>, Xin Long <lucien.xin@gmail.com>
CC: network dev <netdev@vger.kernel.org>, <dev@openvswitch.org>,
	<ovs-dev@openvswitch.org>, Marcelo Ricardo Leitner
	<marcelo.leitner@gmail.com>, Florian Westphal <fw@strlen.de>, Ilya Maximets
	<i.maximets@ovn.org>, Eric Dumazet <edumazet@google.com>, <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>
References: <1bdeb2f3a812bca016a225d3de714427b2cd4772.1741457143.git.lucien.xin@gmail.com>
 <f7tjz8uz5ow.fsf@redhat.com>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <f7tjz8uz5ow.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 59172ff5-151f-441f-d1be-08dd61ddadd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0cxaXhwNzZpQ3dnUVpaQ01lRjE3WkZrZ0NnMWhkbDMzVXVGK3hpT1I1eHBT?=
 =?utf-8?B?dldmdDArbnBaVHlVYW1BRGhIbGxpbms4OUgzR2RrT2VURkRybHN5V2lncElB?=
 =?utf-8?B?ODZ5eHpVa3hQNTRZQVpKdWYybTF3L1lJL1E5aHRtcXBGZWt6OXFvOWZXbFFL?=
 =?utf-8?B?aklac21PL2FISmxsblUwdlM0azhzdXRPbk5QRS9WTW43dkl4R2VDZ25LTk54?=
 =?utf-8?B?ZzUxQm9kajcwSjM3T1R3Nm1WS2RhdlhKZjN2YWJvUjhKdXJaV0JrdHdjTDVS?=
 =?utf-8?B?UzJrbG5xVTYzZU1FQUJHdHRkTVR1U2FDRVFTUS9aL0JRYTVKajZzNmpLWkFh?=
 =?utf-8?B?ZGM3VXVXYXFIMmhWWHpaK0x1c0EzT1hSR3g5ck9LMUkvYmcrdWEvcjZLZ0g1?=
 =?utf-8?B?bWdBSVNLa1dVRkJqQWE3eDJqZENIUmRoVGQzMWx1L3pjQjQrMElqbGFSWGxp?=
 =?utf-8?B?dlQ2TEtiTUtTczc3dUhLQmppcWtrMnN4VVZiZVhRMWhMdHdlbzJjY0ZmQm94?=
 =?utf-8?B?aktUN1ZId0FjVEJDZVVBeW85TGkwSlUxMG1BdUJnbUhsYUxmMlBaUENGbm5v?=
 =?utf-8?B?SkNLYjQwLzVsZ3FSbkZKWkdDaHBxb0dyaVdIOS9Na2lJTU5CUEhNSHZZYUpl?=
 =?utf-8?B?d2pGb3BQNTI2bVd2VGtkY3BsblFMeWZxbndwSlY0Ty9uZ3hCbEtPQjdveFBM?=
 =?utf-8?B?SCtDTFhvekd4R2Z0ekJhMU4vWUJ1eHhhWEtncDFqMDlwT3hicGdwdVNYRnFh?=
 =?utf-8?B?VFdHVnVsVVZLYmFHRXJPYm5mRzVaRVdmWGNsR0R1SFZZcXpIbmlRbENKK1A4?=
 =?utf-8?B?Qk90UXpmZnhjNk9VSTExVHh3Y0xYTm9FV2doaUFHcC9HSUpNdHkzV20xYnIx?=
 =?utf-8?B?S0RmRzVnQlJvK1lCcUhXS2xFeUNPSDNON1paTllJZG9YcVRlc2lwU2ZvRkk1?=
 =?utf-8?B?OUlIQVdRVzl1bytBVk9zcC9qZEd0UGRjQk9MNGVtRkVURmZUOXg4cmlrbjBS?=
 =?utf-8?B?dTVwZkJURWg4OHExL2FidzBtUGJ2eHNkWTlyajRkeFNEVCtPUjdIeHArclpr?=
 =?utf-8?B?SGlaMCszVjNOUmJtNFpOQWVBVDZHeUhNZjZjSms3UTZoR3YxQVQrMEQ5Vi84?=
 =?utf-8?B?cGlmVHF3T1VFdjh5N004bjJhWll5YStldGU1ZE1JZ3ZGVmtxelJQK1BSMUt1?=
 =?utf-8?B?WW9KQ0Ria0RQTFl1ODJLWjVjM3lBSG1HS1V0cDFHdVR0cHBxRmNIalNobW93?=
 =?utf-8?B?S2NPMEU2QVU1SnlGMU11TVFyNGs0RWNqM2dERnY2cEZCNlZacE42eEllRkNj?=
 =?utf-8?B?d1h4cDNzRnQ0eCtJSHdkMkltM0p0aU9UVm5nbnZZUGFXaysvQWh0Ym9aWDZI?=
 =?utf-8?B?dWV3MzlHZlFReThMSDlVVkVMSW5vanBIZ3RvWldySHpvTXU3OTNXR002bmQy?=
 =?utf-8?B?WUo1WkxTOTZOVWhqSTJ2ckJqZ3JUMFlxT0V5MUZYaklUT0F6ZkVVa05lU2ZP?=
 =?utf-8?B?T0pqZDBWbWRybi9YN2xxMndCQkhoSFYvcXVIN0o4cjMxRUVrd0psOG5iOFhI?=
 =?utf-8?B?Y011QXFRU0VRMnJ6ZHl3MXpDUFFyMzgrZkw4SGdvaVU3ZTBjLzNjeVFnOGg5?=
 =?utf-8?B?WE9VQXNMN3R2ZnJhMmNkMklyaW9PbkFwVy9hZjdKZU04MVZkQzBxNUgyK1o5?=
 =?utf-8?B?cnZqT3JiWC9SdFlNVUZOYnVzVUhuUFRaU1Y1TklqK0F0eVZ2a1VSZG1uTlBJ?=
 =?utf-8?B?MnVVRFJPS2FsZklUNFY5eSswM1h1VGFsdFpMcFMwbFZuWTJwTzd1dk9BNVBQ?=
 =?utf-8?B?cys4SVpGd2pvMnZ3cW54NGl6Qm9HWWJwcFhwY0Nibmh0WDdKSDEzQ0VveHJt?=
 =?utf-8?B?S0F2OHZDbGpaZEJETk9ma05RKytZWGh0cVNwdEN4ZktPeGYveTR0TUlPbVN2?=
 =?utf-8?B?QlVBd3E0MWlxYXAvbjRwUjFRV2FzL0xKU3pqSWMzbE9qL0IyVC9STGFzclVV?=
 =?utf-8?B?WXhyVmNnYVJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 03:18:08.7194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59172ff5-151f-441f-d1be-08dd61ddadd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262



On 3/12/2025 10:25 PM, Aaron Conole wrote:
> Xin Long <lucien.xin@gmail.com> writes:
> 
>> Currently, ovs_ct_set_labels() is only called for confirmed conntrack
>> entries (ct) within ovs_ct_commit(). However, if the conntrack entry
>> does not have the labels_ext extension, attempting to allocate it in
>> ovs_ct_get_conn_labels() for a confirmed entry triggers a warning in
>> nf_ct_ext_add():
>>
>>    WARN_ON(nf_ct_is_confirmed(ct));
>>
>> This happens when the conntrack entry is created externally before OVS
>> increments net->ct.labels_used. The issue has become more likely since
>> commit fcb1aa5163b1 ("openvswitch: switch to per-action label counting
>> in conntrack"), which changed to use per-action label counting and
>> increment net->ct.labels_used when a flow with ct action is added.
>>
>> Since there’s no straightforward way to fully resolve this issue at the
>> moment, this reverts the commit to avoid breaking existing use cases.
>>
>> Fixes: fcb1aa5163b1 ("openvswitch: switch to per-action label counting in conntrack")
>> Reported-by: Jianbo Liu <jianbol@nvidia.com>
>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
>> ---
> 
> I did a quick test using the case provided by Jianbo and I wasn't able
> to generate the warning.  If possible, I'd like Jianbo to confirm that
> it works as well.

Yes, it works. The warning is gone after applying this revert. Thanks!

> 
> Acked-by: Aaron Conole <aconole@redhat.com>
> 
>>   net/openvswitch/conntrack.c | 30 ++++++++++++++++++------------
>>   net/openvswitch/datapath.h  |  3 +++
>>   2 files changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
>> index 3bb4810234aa..e573e9221302 100644
>> --- a/net/openvswitch/conntrack.c
>> +++ b/net/openvswitch/conntrack.c
>> @@ -1368,8 +1368,11 @@ bool ovs_ct_verify(struct net *net, enum ovs_key_attr attr)
>>   	    attr == OVS_KEY_ATTR_CT_MARK)
>>   		return true;
>>   	if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
>> -	    attr == OVS_KEY_ATTR_CT_LABELS)
>> -		return true;
>> +	    attr == OVS_KEY_ATTR_CT_LABELS) {
>> +		struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>> +
>> +		return ovs_net->xt_label;
>> +	}
>>   
>>   	return false;
>>   }
>> @@ -1378,7 +1381,6 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
>>   		       const struct sw_flow_key *key,
>>   		       struct sw_flow_actions **sfa,  bool log)
>>   {
>> -	unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
>>   	struct ovs_conntrack_info ct_info;
>>   	const char *helper = NULL;
>>   	u16 family;
>> @@ -1407,12 +1409,6 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
>>   		return -ENOMEM;
>>   	}
>>   
>> -	if (nf_connlabels_get(net, n_bits - 1)) {
>> -		nf_ct_tmpl_free(ct_info.ct);
>> -		OVS_NLERR(log, "Failed to set connlabel length");
>> -		return -EOPNOTSUPP;
>> -	}
>> -
>>   	if (ct_info.timeout[0]) {
>>   		if (nf_ct_set_timeout(net, ct_info.ct, family, key->ip.proto,
>>   				      ct_info.timeout))
>> @@ -1581,7 +1577,6 @@ static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
>>   	if (ct_info->ct) {
>>   		if (ct_info->timeout[0])
>>   			nf_ct_destroy_timeout(ct_info->ct);
>> -		nf_connlabels_put(nf_ct_net(ct_info->ct));
>>   		nf_ct_tmpl_free(ct_info->ct);
>>   	}
>>   }
>> @@ -2006,9 +2001,17 @@ struct genl_family dp_ct_limit_genl_family __ro_after_init = {
>>   
>>   int ovs_ct_init(struct net *net)
>>   {
>> -#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>> +	unsigned int n_bits = sizeof(struct ovs_key_ct_labels) * BITS_PER_BYTE;
>>   	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>>   
>> +	if (nf_connlabels_get(net, n_bits - 1)) {
>> +		ovs_net->xt_label = false;
>> +		OVS_NLERR(true, "Failed to set connlabel length");
>> +	} else {
>> +		ovs_net->xt_label = true;
>> +	}
>> +
>> +#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>   	return ovs_ct_limit_init(net, ovs_net);
>>   #else
>>   	return 0;
>> @@ -2017,9 +2020,12 @@ int ovs_ct_init(struct net *net)
>>   
>>   void ovs_ct_exit(struct net *net)
>>   {
>> -#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>   	struct ovs_net *ovs_net = net_generic(net, ovs_net_id);
>>   
>> +#if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>   	ovs_ct_limit_exit(net, ovs_net);
>>   #endif
>> +
>> +	if (ovs_net->xt_label)
>> +		nf_connlabels_put(net);
>>   }
>> diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
>> index 365b9bb7f546..9ca6231ea647 100644
>> --- a/net/openvswitch/datapath.h
>> +++ b/net/openvswitch/datapath.h
>> @@ -160,6 +160,9 @@ struct ovs_net {
>>   #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>>   	struct ovs_ct_limit_info *ct_limit_info;
>>   #endif
>> +
>> +	/* Module reference for configuring conntrack. */
>> +	bool xt_label;
>>   };
>>   
>>   /**
> 


