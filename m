Return-Path: <netdev+bounces-210942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC9DB15DD2
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 12:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE56C4E7781
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C222F76F;
	Wed, 30 Jul 2025 10:08:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300ED224254;
	Wed, 30 Jul 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870116; cv=none; b=mt3uamT8dVp0Yg9sfj4SMwta6/tI/IYPJk20ZFMSMEzwTOkPDYOYJY8uW9ZF+Q9oBzFhGMnmLCoXDOdVhr2+dxSPMdt9mSY0q3/3AWOQrEbOYQdxTr/PoEIvgibvdxfOF05IqxttzNeqhZVM+U/SAwNg1U7D0TQ3Zrxfyz7bNIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870116; c=relaxed/simple;
	bh=w1/l+HTLMvjAUl692J51h2+9oQoosTH/TzYF/itO6cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ekxc/9StLGjRsYGqwzcBuKElwO4ryeOFDYOUOFzqxbyQ/zZ0Nt4rGW7prvi9zplY4iZCS5EVCVcgvUc+Hp3S3tvMd7wS0GYP6WV0Dn6CQeLITxfbSDlgJzPolhzMgWg24pPOU9RIS39KIrJQETuQBBQkqeNzfi2Dbt+tHZW7X3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bsSVR1hRLzdc5M;
	Wed, 30 Jul 2025 18:04:15 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id C5EA014027D;
	Wed, 30 Jul 2025 18:08:28 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Jul 2025 18:08:27 +0800
Message-ID: <5fa8a2db-d79b-4bcc-a386-03f3706c319f@huawei.com>
Date: Wed, 30 Jul 2025 18:08:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net v2] net: drop gso udp packets in udp_rcv_segment()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <atenart@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250729123907.3318425-1-wangliang74@huawei.com>
 <6889005c9d7f1_1669652947@willemb.c.googlers.com.notmuch>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <6889005c9d7f1_1669652947@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/7/30 1:09, Willem de Bruijn 写道:
> Can limit to drop UFO packets, as other GSO packets will get segmented
> correctly.
>
> Wang Liang wrote:
>> When sending a packet with virtio_net_hdr to tun device, if the gso_type
>> in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than udphdr
>> size, below crash may happen.
>>
>>    ------------[ cut here ]------------
>>    kernel BUG at net/core/skbuff.c:4572!
>>    Oops: invalid opcode: 0000 [#1] SMP NOPTI
>>    CPU: 0 UID: 0 PID: 62 Comm: mytest Not tainted 6.16.0-rc7 #203 PREEMPT(voluntary)
>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>>    RIP: 0010:skb_pull_rcsum+0x8e/0xa0
>>    Code: 00 00 5b c3 cc cc cc cc 8b 93 88 00 00 00 f7 da e8 37 44 38 00 f7 d8 89 83 88 00 00 00 48 8b 83 c8 00 00 00 5b c3 cc cc cc cc <0f> 0b 0f 0b 66 66 2e 0f 1f 84 00 000
>>    RSP: 0018:ffffc900001fba38 EFLAGS: 00000297
>>    RAX: 0000000000000004 RBX: ffff8880040c1000 RCX: ffffc900001fb948
>>    RDX: ffff888003e6d700 RSI: 0000000000000008 RDI: ffff88800411a062
>>    RBP: ffff8880040c1000 R08: 0000000000000000 R09: 0000000000000001
>>    R10: ffff888003606c00 R11: 0000000000000001 R12: 0000000000000000
>>    R13: ffff888004060900 R14: ffff888004050000 R15: ffff888004060900
>>    FS:  000000002406d3c0(0000) GS:ffff888084a19000(0000) knlGS:0000000000000000
>>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>    CR2: 0000000020000040 CR3: 0000000004007000 CR4: 00000000000006f0
>>    Call Trace:
>>     <TASK>
>>     udp_queue_rcv_one_skb+0x176/0x4b0 net/ipv4/udp.c:2445
>>     udp_queue_rcv_skb+0x155/0x1f0 net/ipv4/udp.c:2475
>>     udp_unicast_rcv_skb+0x71/0x90 net/ipv4/udp.c:2626
>>     __udp4_lib_rcv+0x433/0xb00 net/ipv4/udp.c:2690
>>     ip_protocol_deliver_rcu+0xa6/0x160 net/ipv4/ip_input.c:205
>>     ip_local_deliver_finish+0x72/0x90 net/ipv4/ip_input.c:233
>>     ip_sublist_rcv_finish+0x5f/0x70 net/ipv4/ip_input.c:579
>>     ip_sublist_rcv+0x122/0x1b0 net/ipv4/ip_input.c:636
>>     ip_list_rcv+0xf7/0x130 net/ipv4/ip_input.c:670
>>     __netif_receive_skb_list_core+0x21d/0x240 net/core/dev.c:6067
>>     netif_receive_skb_list_internal+0x186/0x2b0 net/core/dev.c:6210
>>     napi_complete_done+0x78/0x180 net/core/dev.c:6580
>>     tun_get_user+0xa63/0x1120 drivers/net/tun.c:1909
>>     tun_chr_write_iter+0x65/0xb0 drivers/net/tun.c:1984
>>     vfs_write+0x300/0x420 fs/read_write.c:593
>>     ksys_write+0x60/0xd0 fs/read_write.c:686
>>     do_syscall_64+0x50/0x1c0 arch/x86/entry/syscall_64.c:63
>>     </TASK>
>>
>> To trigger gso segment in udp_queue_rcv_skb(), we should also set option
>> UDP_ENCAP_ESPINUDP to enable udp_sk(sk)->encap_rcv. When the encap_rcv
>> hook return 1 in udp_queue_rcv_one_skb(), udp_csum_pull_header() will try
>> to pull udphdr, but the skb size has been segmented to gso size, which
>> leads to this crash.
>>
>> Previous commit cf329aa42b66 ("udp: cope with UDP GRO packet misdirection")
>> introduces segmentation in UDP receive path only for GRO, which was never
>> intended to be used for UFO, so drop gso udp packets in udp_rcv_segment().
>>
>> Fixes: cf329aa42b66 ("udp: cope with UDP GRO packet misdirection")
>> Fixes: 3d010c8031e3 ("udp: do not accept non-tunnel GSO skbs landing in a tunnel")
> Only one Fixes tag, to know where to backport too.
>
> The segmentation on receive is introduced in the first commit. I'd
> keep only that.
>
> And please add a Link: to the email thread with the analysis of the
> bug, your v1 (above the ---).


Thanks very much for your suggestions! They are helpful and clear.

I have send a v3 patch, please check it. Thanks.

------
Best regards
Wang Liang

>> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> ---
>> v1: https://lore.kernel.org/netdev/20250724083005.3918375-1-wangliang74@huawei.com/
>> v2: Drop ufo packets instead of checking min gso size.
>> ---
>>   include/net/udp.h | 22 ++++++++++++++++------
>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/net/udp.h b/include/net/udp.h
>> index a772510b2aa5..e3fcda71f6c1 100644
>> --- a/include/net/udp.h
>> +++ b/include/net/udp.h
>> @@ -587,6 +587,14 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
>>   {
>>   	netdev_features_t features = NETIF_F_SG;
>>   	struct sk_buff *segs;
>> +	int drop_count = 1;
> This is rare, can move initialization into the branch.
>> +
>> +	/*
>> +	 * Segmentation in UDP receive path is only for UDP GRO, drop udp
>> +	 * fragmentation offload (UFO) packets.
>> +	 */
>> +	if (skb_shinfo(skb)->gso_type & (SKB_GSO_UDP | SKB_GSO_UDP_L4))
> Only SKB_GSO_UDP.
>
> The purpose of this function is to correctly segment SKB_GSO_UDP_L4
> packets.
>
>> +		goto drop;
>>   
>>   	/* Avoid csum recalculation by skb_segment unless userspace explicitly
>>   	 * asks for the final checksum values
>> @@ -610,16 +618,18 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
>>   	 */
>>   	segs = __skb_gso_segment(skb, features, false);
>>   	if (IS_ERR_OR_NULL(segs)) {
>> -		int segs_nr = skb_shinfo(skb)->gso_segs;
>> -
>> -		atomic_add(segs_nr, &sk->sk_drops);
>> -		SNMP_ADD_STATS(__UDPX_MIB(sk, ipv4), UDP_MIB_INERRORS, segs_nr);
>> -		kfree_skb(skb);
>> -		return NULL;
>> +		drop_count = skb_shinfo(skb)->gso_segs;
>> +		goto drop;
>>   	}
>>   
>>   	consume_skb(skb);
>>   	return segs;
>> +
>> +drop:
>> +	atomic_add(drop_count, &sk->sk_drops);
>> +	SNMP_ADD_STATS(__UDPX_MIB(sk, ipv4), UDP_MIB_INERRORS, drop_count);
>> +	kfree_skb(skb);
>> +	return NULL;
>>   }
>>   
>>   static inline void udp_post_segment_fix_csum(struct sk_buff *skb)
>> -- 
>> 2.34.1
>>
>

