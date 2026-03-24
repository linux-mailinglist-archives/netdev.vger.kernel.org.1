Return-Path: <netdev+bounces-270929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMQ5Lw5KwmnYbQQAu9opvQ
	(envelope-from <netdev+bounces-270929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:23:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCFB304889
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C825E303E623
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078836C9D7;
	Tue, 24 Mar 2026 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lItA5BEd"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B6367F3B;
	Tue, 24 Mar 2026 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340436; cv=fail; b=RkTrBe7kRlOO3ub8IyMVG1eoNadIrzipkLtw+FtSKLuAq+dysoQMSJSmXKy/3CBIU3pVWvFpyAAriIaP8Y1kByJJKle0bhGq8bFZbXj5AnZ5un1b3TDlAky3tckTIpLKT2boMKNBiX5x0SZluOjWsU77y2cJMNiYWw2WdPW7AEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340436; c=relaxed/simple;
	bh=Cv2TeXyCFGOmnxgMnmtwIvpZCMHNOPBMytO4epLjjjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EtK07Tl57xhsPo6/g1OldIWh+xKSw6C9RiyJnxfvDWlKnqT/bmGvKsFLaiKbTSVZ24FhDnjmwcUn417ERjz+Mnt9cah0bzhBo+JiWC0eQNPGL8JEtfjzHZVNqdu2O4V3ts/I08MAKDU4bM2tMIwvM24/GiMLjbFQXUVDltyDMpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lItA5BEd; arc=fail smtp.client-ip=40.93.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXXm+t3xmft1v3xPhyLepgyckVV3t8cB4wazJg2CNuA+tSJ0FVZRxnqToq/xOj6FYurf89uWe+GX6mlTjDWeEjCm3ZHMv5lvxvQGFZkHmeI0pfls25I2zQ9yg8nfC7b6hvxUYifD/dctGBEeBlgL40nUV+78RKvbTVXg+cIHM9R3ubmkMGXpKIqGpaL6GkCs0ao3RskQB0QuYJTP3YsLWueZ2DsYO2dHS9nVGkWsXzgpWvALMhrjalnqdYRWoChzgDJD4yHGitS6lMT973/dwpL1ZXdrvaxWCrVpEUkNP17/yDPjXmRJRy72Wh9QEmPcqVPKiSBw7olFXfJSNKM2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPr+Elxb6UVBKYfcZ/tUerk30U8LktK8aiaE6KLKb60=;
 b=euQf7VbFCTrjk/KorGfitA32H18Q8XPCuLOg/2G+zHI3Ca1cu8NKaz5DleFQEJzWrPCXRUr7UWLkZhanH8A4ph85Bby7x1U03y0iGU2b6oPrRyKruOBhySeE25HK0mIPIMBeLnKNNxg3SThKEVC0CRWsjTrMi7j8cNoQ0+mfGaslw35I2AuKMi2rnxbpPVaBxQsOx9bQQWPu4gBVDjU/hgquzJffvoqnGJTwklU0z9JFj9QY/dMVIFzsr5CBwoHp/HFEXn3unZD1wZUQXAsahNo2saeGcpoQAnjy3sMM6q8nJJGqxaF7fMrHHqBd7nW5B/EtBXAa+9GtmvDJqNdOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPr+Elxb6UVBKYfcZ/tUerk30U8LktK8aiaE6KLKb60=;
 b=lItA5BEd7OplyQUImv/Yihc87W3VC6ha++M4lXy3WhutyEvZChW7Ny+ydg+bvY9Ku3g3GI1tUM9ejwF9smaU7j5TkSK9h2kQ8/jQXSu323ofQiy1KXyd49C4z2dy5Rv+1LdiWisqxl9UA5jyD7nBezaZlzE+BdHPD/Fl0qV8/M8=
Received: from BYAPR11CA0095.namprd11.prod.outlook.com (2603:10b6:a03:f4::36)
 by CY1PR12MB9581.namprd12.prod.outlook.com (2603:10b6:930:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 08:20:24 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::90) by BYAPR11CA0095.outlook.office365.com
 (2603:10b6:a03:f4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 08:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 08:20:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 03:20:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 03:20:23 -0500
Received: from [10.136.34.242] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 24 Mar 2026 03:20:19 -0500
Message-ID: <cbce5727-f4d5-4601-a81f-ed9cb3f541e6@amd.com>
Date: Tue, 24 Mar 2026 13:50:18 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for buffer
 allocation
To: "Michael S. Tsirkin" <mst@redhat.com>, Omar Elghoul
	<oelghoul@linux.ibm.com>
CC: <vishs@meta.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<dw@davidwei.uk>, <edumazet@google.com>, <eperezma@redhat.com>,
	<ilias.apalodimas@linaro.org>, <jasowang@redhat.com>, <kernel-team@meta.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <technoboy85@gmail.com>,
	<virtualization@lists.linux.dev>, <xuanzhuo@linux.alibaba.com>
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260323150136.14452-1-oelghoul@linux.ibm.com>
 <20260323114313-mutt-send-email-mst@kernel.org>
 <20260323122728-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20260323122728-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|CY1PR12MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e8ea93-1e2d-4f0f-dec3-08de897e328c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lcN5DXZ8a0XhxK9omY39NdA/unFDs86R5rHSIBbgttqLuDv5kdTToxykRoUsn4BiHK21VOr2wTtvuaJHKwUUYwei4DL9SoA2uNxlj3+/dtfoNMaB4voiCtgYty7mCQ32QbN5gz+cJipjSKOhcBj2a0p3b1PBnFvwU0pv6+Ir1GRyjPHi77ay1ekQoCpEmtBAGp7Euji4i6W0Tq1sto3sP5CDrCfiJytWMJ0aPi3cSb3s/V87J4PW/3b1zlSVl8ms5FeWNwBAml8hprhG9kMezDXdzoahSwEW5Orny9yOqzPjfeOSDe28GjnyzmqsPAAkQHft2Yap8N3UrEqYZ7YHoA3j70OGKMMMN73tvDkCO/tlPRsRh+AvSuHdqOkI7/fepNu0Wp0qE6ctgjOaqAtDDViR9V7T0yRbq55n+mRqgyPRcnPctWe8OxJihXo0ufumm8c+/6vRuLB7uNuSPl6QXqt3SgeEOSTUy1G3uWzHtN5MSCu031w+xN3O/UT5SaeiG5Tf05rkF0vjjprZBeUJSfY8RByfipD235OIVtvTLTarUPkUl09ha7xlNeutzBUfXl25VgJso27Zdv+xtn324deaZGyfNEyQKzpdi9+WHMxOcQXIbIH+Rq4IsVRJd7hv9ByMk7Vs1aJCw2x8S5WYp6Bw8Uh/xrIViSoUnIh6oNJDBM6IrcbJTYN648BMrwG5v+SK2gG1zmHTGKOQBMR/0y7TOZGC0T6QtNycn5htie+AtDPGsz8xbX1K/Dw7ugYZAQY2LjHwvi588EKIeuOrJw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2mnXxB2wrZ8+ypriArA7GRVGHuKMj1Ubdwu4AIzaOQYYNOVCIxoXYnIjJbjOcepcY1cy/JByzqPXVjd1R+kHax7zFX9EWCxiEvgyx/p1qppESZ20W1z7R1Afl5BluhItqAZ8bJeHPChr39jrJpjT5yetSbX0K20FBkwulTeUGPilyHK6ue/MoIFsCMdQvyb7nFGVty8X7jvXFF0AxhOPUigvRSNpbcEa9gaFz2vRZoPXeCn+3Tl/qZs63cusXcxg2E1BC8MlIoeVMWCmP05YC4w3w6yqfN+DXr+EYZ1mzmQZPCQZDUPz6H22MdTZd/L6bhDx3GGVj8+1O6VhPnombIP/nrktI6dusugxbfpMojyOnke37YHntWvvXEpErvVA269OOegS2HQOf75KXOpGv0KGRKE3epwjkB2E8OjUpJmgbaDe8kvsRjNqZ9cWDN78
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:20:23.8826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e8ea93-1e2d-4f0f-dec3-08de897e328c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9581
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270929-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[meta.com,lunn.ch,davemloft.net,davidwei.uk,google.com,redhat.com,linaro.org,kernel.org,vger.kernel.org,gmail.com,lists.linux.dev,linux.alibaba.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sraithal@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5CCFB304889
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/2026 10:28 PM, Michael S. Tsirkin wrote:
> On Mon, Mar 23, 2026 at 11:52:34AM -0400, Michael S. Tsirkin wrote:
>> On Mon, Mar 23, 2026 at 11:01:31AM -0400, Omar Elghoul wrote:
>>> Hi,
>>>
>>> I've been testing linux-next (tags later than 03/17) and hit new issues in
>>> virtio-net on s390x. I bisected the issue, and I found this patch to be the
>>> first buggy commit.
>>>
>>> The issue seems to only be reproducible when running in Secure Execution.
>>> Tested in a KVM guest, the virtio-net performance appears greatly reduced,
>>> and the dmesg output shows many instances of the following error messages.
>>>
>>> Partial relevant logs
>>> =====================
>>> [   49.332028] macvtap0: bad gso: type: 0, size: 0, flags 1 tunnel 0 tnl csum 0
>>> [   74.365668] macvtap0: bad gso: type: 2e, size: 27948, flags 0 tunnel 0 tnl csum 0
>>> [  403.302168] macvtap0: bad csum: flags: 2, gso_type: 23 rx_tnl_csum 0
>>> [  403.302271] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum 0
>>> [  403.302279] macvtap0: bad csum: flags: 2, gso_type: e1 rx_tnl_csum 0
>>> [  403.309492] macvtap0: bad csum: flags: 2, gso_type: 4c rx_tnl_csum 0
>>> [  403.317029] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum 0
>>>
>>> Steps to reproduce
>>> ==================
>>> 1. Boot a Linux guest implementing this patch under QEMU/KVM (*) with SE
>>>     enabled and a virtio-net-ccw device attached.
>>> 2. Run dmesg. The error message is usually already present at boot time,
>>>     but if not, it can be reproduced by creating any network traffic.
>>>
>>> (*) This patch was not tested in a non-KVM hypervisor environment.
>>>
>>> I've further confirmed that reverting this patch onto its parent commit
>>> resolves the issue. Please let me know if you'd like me to test a fix or if
>>> you would need more information.
>>>
>>> Thanks in advance.
>>>
>>> Best,
>>> Omar
>>
>> Well... I am not sure how I missed it. Obvious in hindsight:
>>
>> static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>                          void *buf, unsigned int len, void **ctx,
>>                          unsigned int *xdp_xmit,
>>                          struct virtnet_rq_stats *stats)
>> {
>>          struct net_device *dev = vi->dev;
>>          struct sk_buff *skb;
>>          u8 flags;
>>                  
>>          if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>>                  pr_debug("%s: short packet %i\n", dev->name, len);
>>                  DEV_STATS_INC(dev, rx_length_errors);
>>                  virtnet_rq_free_buf(vi, rq, buf);
>>                  return;
>>          }
>>          
>>          /* About the flags below:
>>           * 1. Save the flags early, as the XDP program might overwrite them.
>>           * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
>>           * stay valid after XDP processing.
>>           * 2. XDP doesn't work with partially checksummed packets (refer to
>>           * virtnet_xdp_set()), so packets marked as
>>           * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
>>           */
>>                  
>>          if (vi->mergeable_rx_bufs) {
>>                  flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>>                  skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>>                                          stats);
>>          } else if (vi->big_packets) {
>>                  void *p = page_address((struct page *)buf);
>>                  
>>                  flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
>>                  skb = receive_big(dev, vi, rq, buf, len, stats);
>>          } else {
>>                  flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>>                  skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
>>          }
>>
>>
>> So we are reading the header, before dma sync, which is within
>> receive_mergeable and friends:
>>
>> static struct sk_buff *receive_mergeable(struct net_device *dev,
>>                                           struct virtnet_info *vi,
>>                                           struct receive_queue *rq,
>>                                           void *buf,
>>                                           void *ctx,
>>                                           unsigned int len,
>>                                           unsigned int *xdp_xmit,
>>                                           struct virtnet_rq_stats *stats)
>> {
>>          struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
>>          int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>>          struct page *page = virt_to_head_page(buf);
>>          int offset = buf - page_address(page);
>>          struct sk_buff *head_skb, *curr_skb;
>>          unsigned int truesize = mergeable_ctx_to_truesize(ctx);
>>          unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>>                  
>>          head_skb = NULL;
>>                  
>>          if (rq->use_page_pool_dma)
>>                  page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
>>                  
>>
>>
>> Just as a test, the below should fix it (compiled only), but the real
>> fix is more complex since we need to be careful to avoid expensive syncing
>> twice.
>>
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 97035b49bae7..57b4f5954bed 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -931,9 +931,19 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>   
>>   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>>   {
>> +	void *buf;
>> +
>>   	BUG_ON(!rq->page_pool);
>>   
>> -	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>> +	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
>> +	if (buf && rq->use_page_pool_dma && *len) {
>> +		struct page *page = virt_to_head_page(buf);
>> +		int offset = buf - page_address(page);
>> +
>> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, *len);
>> +	}
>> +
>> +	return buf;
>>   }
>>   
>>   static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>
>>
>>
>>
>> -- 
>> MST
> 
> or maybe like this:
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 97035b49bae7..835f52651006 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1956,13 +1956,6 @@ static struct sk_buff *receive_small(struct net_device *dev,
>   	 */
>   	buf -= VIRTNET_RX_PAD + xdp_headroom;
>   
> -	if (rq->use_page_pool_dma) {
> -		int offset = buf - page_address(page) +
> -			     VIRTNET_RX_PAD + xdp_headroom;
> -
> -		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> -	}
> -
>   	len -= vi->hdr_len;
>   	u64_stats_add(&stats->bytes, len);
>   
> @@ -2398,9 +2391,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>   
>   	head_skb = NULL;
>   
> -	if (rq->use_page_pool_dma)
> -		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> -
>   	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>   
>   	if (check_mergeable_len(dev, ctx, len))
> @@ -2563,6 +2553,13 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>   		return;
>   	}
>   
> +	if (rq->use_page_pool_dma) {
> +		struct page *page = virt_to_head_page(buf);
> +		int offset = buf - page_address(page);
> +
> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> +	}
> +
>   	/* About the flags below:
>   	 * 1. Save the flags early, as the XDP program might overwrite them.
>   	 * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
> 

I see the same virtio_net regression introduced by commit 24fbd3967f3f 
(“virtio_net: add page_pool support for buffer allocation”) on AMD EPYC 
(KVM/QEMU secure guests with virtio-net), in addition to s390x as in 
Omar Elghoul’s report [1].

The failure mode matches: broken guest networking until that commit is 
reverted or worked around.

I built and tested both of Michael Tsirkin’s proposed fixes in this 
thread [2] [3]; each resolves the issue on my AMD EPYC setup.

[1] 
https://lore.kernel.org/all/20260323150136.14452-1-oelghoul@linux.ibm.com/
[2] 
https://lore.kernel.org/all/20260323114313-mutt-send-email-mst@kernel.org/
[3] 
https://lore.kernel.org/all/20260323122728-mutt-send-email-mst@kernel.org/#t

Tested-by: Srikanth Aithal <sraithal@amd.com>



