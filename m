Return-Path: <netdev+bounces-162813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB3DA28003
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 01:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEB53A2B5C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE79163;
	Wed,  5 Feb 2025 00:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="lvoIj73f"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1F9802
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714320; cv=none; b=OsKF3FHpz+t5vEcoWtGhAQlnwr9MlkhKtsbM+qqYvMdnRIq7vQmroWLUFZFOnrAaQkHhLgVatde8kkdi+pNGdI0YoxwlgQby8BVGFMPZQVa1/5w3wsHfC7osDu7wHMhrnwqWSasQf4lmdrakDgGt4EgcYpNPdtLv1m7+rOQYe0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714320; c=relaxed/simple;
	bh=2aThuqXjD26rFcT60UJzU5YqD8mFeRffsShdAudJ4P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsD00Nk/37yMmjR+nxSh3qb17Vsp7Uw7wEJL3Bpju2FkSdAIMGTZ0qedzqCZfBPFMHBolvsc0FzHMX4KUnxNq6OyV/wKoBStrbpGLDcyciPDY1Iea9PgeIGeCuTjFMlowBF7woMJtv19U1Mwh4TTvWonFQxls0nlfND95WPsE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=lvoIj73f; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tfT1D-00605F-D3; Wed, 05 Feb 2025 01:11:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=fqnPEqb0npCwgOMe8eMS+WgvesQGL3/eDCx7rcm8DxA=; b=lvoIj73f1U6GgEhitfx5HyHaIe
	AfWkMAKm11W4MjGRO9C1D0UmXeAi/+GRzUOtykjye8C7t4yN/yqfz+IRjrO/5hulxMyOxcShnDYEM
	2/GLlkObDW7J8ZgyUSc2hXsZ3yDv5kpR5V+n+p3Ystpk/dfIa0vn9SWT03J04lsZq84ScvvDE511o
	vcpO1/grhOriyfnWP/RVN5Aw/ToeBUiyekjwsGf7RxJx1fu4GQ4f7iHRbG9JUuJgPfflPK8JyJcWo
	pOStP2WpcJcb8jEDJ+TVkYvPfs8mZRFumqogjwFEG+GxgitiZFfk1VLTuwxV8oltzyoIzhw2Ee3FW
	LBaEwfDw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tfT1C-0003M2-Lr; Wed, 05 Feb 2025 01:11:50 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tfT0y-009bhV-EO; Wed, 05 Feb 2025 01:11:36 +0100
Message-ID: <142e66e5-7080-41d9-ac5c-c392dfa68d2a@rbox.co>
Date: Wed, 5 Feb 2025 01:11:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] vsock: Orphan socket after transport release
To: Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com, fstornio@redhat.com
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
 <20250204-vsock-linger-nullderef-v1-1-6eb1760fa93e@rbox.co>
 <jj6xlb2udt2khosipoi4m6iwjc6g5hau3jnzbf6dg2aredfykp@y7j4jlgd4tpr>
 <jfkqsbbq5um6nmlhnxxgx3eg7aopnwaddqvcj7s6svmpujswub@42sq2pawnsxn>
 <huosgcp4y7rr4ppagt7232oexydso6nxv3hzk5qi2euqqqyp6f@mfggrtjrzjdu>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <huosgcp4y7rr4ppagt7232oexydso6nxv3hzk5qi2euqqqyp6f@mfggrtjrzjdu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 17:00, Stefano Garzarella wrote:
> On Tue, Feb 04, 2025 at 04:44:13PM +0100, Luigi Leonardi wrote:
>> On Tue, Feb 04, 2025 at 11:32:54AM +0100, Stefano Garzarella wrote:
>>> On Tue, Feb 04, 2025 at 01:29:52AM +0100, Michal Luczaj wrote:
>>>> During socket release, sock_orphan() is called without considering that it
>>>> sets sk->sk_wq to NULL. Later, if SO_LINGER is enabled, this leads to a
>>>> null pointer dereferenced in virtio_transport_wait_close().
>>>>
>>>> Orphan the socket only after transport release.
>>>>
>>>> Partially reverts the 'Fixes:' commit.
>>>>
>>>> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
>>>> lock_acquire+0x19e/0x500
>>>> _raw_spin_lock_irqsave+0x47/0x70
>>>> add_wait_queue+0x46/0x230
>>>> virtio_transport_release+0x4e7/0x7f0
>>>> __vsock_release+0xfd/0x490
>>>> vsock_release+0x90/0x120
>>>> __sock_release+0xa3/0x250
>>>> sock_close+0x14/0x20
>>>> __fput+0x35e/0xa90
>>>> __x64_sys_close+0x78/0xd0
>>>> do_syscall_64+0x93/0x1b0
>>>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>
>>>> Reported-by: syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=9d55b199192a4be7d02c
>>>> Fixes: fcdd2242c023 ("vsock: Keep the binding until socket destruction")
>>>
>>> Looking better at that patch, can you check if we break commit
>>> 3a5cc90a4d17 ("vsock/virtio: remove socket from connected/bound list 
>>> on shutdown")
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3a5cc90a4d1756072619fe511d07621bdef7f120
>>>
>> I worked with Filippo (+CC) on this patch.
>>
>> IMHO it shouldn't do any harm. `sock_orphan` sets sk->sk_socket and 
>> sk_wq to NULL, and sets the SOCK_DEAD flag.
>>
>> This patch sets the latter in the same place. All the other fields are 
>> not used by the transport->release() (at least in virtio-based 
>> transports), so from my perspective there is no real change.
>>
>> What was your concern?
> 
> My concern was more about calling `vsock_remove_sock()` in 
> virtio_transport_recv_connected:
> 
> I mean this block:
> 	case VIRTIO_VSOCK_OP_SHUTDOWN:
> 		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_RCV)
> 			vsk->peer_shutdown |= RCV_SHUTDOWN;
> 		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_SEND)
> 			vsk->peer_shutdown |= SEND_SHUTDOWN;
> 		if (vsk->peer_shutdown == SHUTDOWN_MASK) {
> 			if (vsock_stream_has_data(vsk) <= 0 && !sock_flag(sk, SOCK_DONE)) {
> 				(void)virtio_transport_reset(vsk, NULL);
> 				virtio_transport_do_close(vsk, true);
> 			}
> 			/* Remove this socket anyway because the remote peer sent
> 			 * the shutdown. This way a new connection will succeed
> 			 * if the remote peer uses the same source port,
> 			 * even if the old socket is still unreleased, but now disconnected.
> 			 */
> 			vsock_remove_sock(vsk);
> 		}
> 
> After commit fcdd2242c023 ("vsock: Keep the binding until socket 
> destruction") calling `vsock_remove_sock` without SOCK_DEAD set, removes 
> the socket only from the connected list.
> 
> So, IMHO there is a real change, but I'm not sure if it's an issue or 
> not, since the issue fixed by commit 3a5cc90a4d17 ("vsock/virtio: remove 
> socket from connected/bound list on shutdown") was more about the remote 
> port IIRC, so that should only be affected by the connected list, which 
> is stll touched now.

I agree, not an issue. But maybe it's worth replacing
vsock_remove_sock(vsk) with vsock_remove_connected(vsk) to better convey
what kind of removal we're talking about here?

Michal


