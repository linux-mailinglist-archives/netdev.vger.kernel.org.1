Return-Path: <netdev+bounces-265496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGTRHWixrmkSHwIAu9opvQ
	(envelope-from <netdev+bounces-265496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:39:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40C238044
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 140563009F1D
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 11:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD3A395244;
	Mon,  9 Mar 2026 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ReNa8CA9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0642E3859CC;
	Mon,  9 Mar 2026 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056354; cv=none; b=r04nELrZHJCjsU95pgVeGiVykycPO5oWTI72dQBZqziU0mh5+ogoTvwznUOhZFmV1j0u1HQBn5n6t9Zgo7dE8r7fGbj0Nh+QysHDwtiVhRywWyGe66aKgHVYrFX+rc6nUL5tTE08GrITlYfHC6A9RsSupLnyvi9Yvk/9jY7w/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056354; c=relaxed/simple;
	bh=5wcvCYm4HHzLJw2WvxFlYjuoO1klr3Nn61CGh1huo1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Goyiz6VQK40zbK3ZFV7M3AfupZTUWx8mYsYsQof/1FuloZjNrNwPS1y/eB53LWEwUj7rjDW+6hMPkb222u2FZDQyaLhyNs8mRYTUXXuWlhB5h42pTdzmBGNqJKY6T1v6bO+YBwLV0cZgklrYjQhT8pztczlLhlHYhZY0Le244ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ReNa8CA9; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=QDbKOGxN4PHx6EtTLUjCVghLu0chB+6hYRk0Dgw70a4=;
	b=ReNa8CA9Dyp39tOul0dfqS43vql9OB0zurpitLuBZxebO8nlL85/1fWqcRJ5nE
	S/wlDABtWT3zTPjerccbf81L7KscRiPRXRuHDnIc5rg86gY0XNaKYH8D4E36SeuM
	BGLaSxwUUKk817t7tfEH8MBVxCsmQL8YKG0MDbJ4HC5E0=
Received: from [7.247.167.131] (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPA id Mc8vCgD3_7SWsK5pgQ5iAg--.2659S2;
	Mon, 09 Mar 2026 19:35:51 +0800 (CST)
Message-ID: <4b8a6182-da50-4edb-a34a-b75ed784f1e2@yeah.net>
Date: Mon, 9 Mar 2026 19:35:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE
 is cleared and napi_tx is false
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260307035110.7121-1-xietangxin@yeah.net>
 <CACGkMEtBS3M6P9xFM-kfPHyjwHgvCrfHM5H1242AQPi54ETqEw@mail.gmail.com>
From: xietangxin <xietangxin@yeah.net>
In-Reply-To: <CACGkMEtBS3M6P9xFM-kfPHyjwHgvCrfHM5H1242AQPi54ETqEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgD3_7SWsK5pgQ5iAg--.2659S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw4rXFy8Zw4DGryxJFWkJFb_yoW5uFy5pr
	4rKayYqF4kJ3yxAFsaqw4kGryjvan5Jr43Grs5Wr13C3s8uFy5Jr4I9rWUua98uFs5Z342
	qw4Fgry2gryqyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOKsUUUUUU=
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiNhdXi2musJew3gAA3z
X-Rspamd-Queue-Id: 6A40C238044
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yeah.net,none];
	R_DKIM_ALLOW(-0.20)[yeah.net:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265496-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[yeah.net];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xietangxin@yeah.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yeah.net:+];
	NEURAL_HAM(-0.00)[-0.938];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,yeah.net:dkim,yeah.net:email,yeah.net:mid]
X-Rspamd-Action: no action



On 3/9/2026 11:42 AM, Jason Wang wrote:
> On Sat, Mar 7, 2026 at 11:53 AM xietangxin <xietangxin@yeah.net> wrote:
>>
>> A UAF issue occurs when the virtio_net driver is configured with napi_tx=N
>> and the device's IFF_XMIT_DST_RELEASE flag is cleared
>> (e.g., during the configuration of tc route filter rules).
>>
>> When IFF_XMIT_DST_RELEASE is removed from the net_device, the network stack
>> expects the driver to hold the reference to skb->dst until the packet
>> is fully transmitted and freed. In virtio_net with napi_tx=N,
>> skbs may remain in the virtio transmit ring for an extended period.
>>
>> If the network namespace is destroyed while these skbs are still pending,
>> the corresponding dst_ops structure has freed. When a subsequent packet
>> is transmitted, free_old_xmit() is triggered to clean up old skbs.
>> It then calls dst_release() on the skb associated with the stale dst_entry.
>> Since the dst_ops (referenced by the dst_entry) has already been freed,
>> a UAF kernel paging request occurs.
>>
>> fix it by adds skb_dst_drop(skb) in start_xmit to explicitly release
>> the dst reference before the skb is queued in virtio_net.
>>
>> Call Trace:
>>  Unable to handle kernel paging request at virtual address ffff80007e150000
>>  CPU: 2 UID: 0 PID: 6236 Comm: ping Kdump: loaded Not tainted 7.0.0-rc1+ #6 PREEMPT
>>   ...
>>   percpu_counter_add_batch+0x3c/0x158 lib/percpu_counter.c:98 (P)
>>   dst_release+0xe0/0x110  net/core/dst.c:177
>>   skb_release_head_state+0xe8/0x108 net/core/skbuff.c:1177
>>   sk_skb_reason_drop+0x54/0x2d8 net/core/skbuff.c:1255
>>   dev_kfree_skb_any_reason+0x64/0x78 net/core/dev.c:3469
>>   napi_consume_skb+0x1c4/0x3a0 net/core/skbuff.c:1527
>>   __free_old_xmit+0x164/0x230  drivers/net/virtio_net.c:611 [virtio_net]
>>   free_old_xmit drivers/net/virtio_net.c:1081 [virtio_net]
>>   start_xmit+0x7c/0x530 drivers/net/virtio_net.c:3329 [virtio_net]
>>   ...
>>
>> Reproduction Steps:
>> NETDEV="enp3s0"
>>
>> config_qdisc_route_filter() {
>>     tc qdisc del dev $NETDEV root
>>     tc qdisc add dev $NETDEV root handle 1: prio
>>     tc filter add dev $NETDEV parent 1:0 protocol ip prio 100 route to 100 flowid 1:1
>>     ip route add 192.168.1.100/32 dev $NETDEV realm 100
>> }
>>
>> test_ns() {
>>     ip netns add testns
>>     ip link set $NETDEV netns testns
>>     ip netns exec testns ifconfig $NETDEV  10.0.32.46/24
>>     ip netns exec testns ping -c 1 10.0.32.1
>>     ip netns del testns
>> }
>>
>> config_qdisc_route_filter
>>
>> test_ns
>> sleep 2
>> test_ns
>>
>> Signed-off-by: xietangxin <xietangxin@yeah.net>
>> ---
> 
> This is needed for stable I think.
> 
> And do we need to fix tun_net_xmit() as well?
> 
> Thanks
Hi Jason,

I have analyzed the tun driver and concluded that it don't suffer from this UAF issue.

The netns containing a tun interface cannot be destroyed until all processes
holding the tun file descriptor have exited. When the file descriptor is closed,
tun_chr_close() is called, which immediately free all skbs in the tx_ring.
This happens before cleanup_net() destroys the dst_ops. Therefore, no skbs referencing freeed dst_ops.
Unlike virtio_net, where skbs can remain in the TX queue even if the ns is deleted.

I believe the fix is only necessary for virtio_net. What do you think?

Best regards,

Tangxin Xie


