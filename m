Return-Path: <netdev+bounces-162624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B28A276A9
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424901886775
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936852153C3;
	Tue,  4 Feb 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbBolB2/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB6215190
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684830; cv=none; b=k/BEwH9vSYvdmx0ht9d9ZdEeiBV77R5GbzeYb59n5wKgAHvGSU/KCqOcFxbc0mJFJCFpN6pIfwcvxPntGtLdpRaIesEWmz459jvvumnbhQTNJ+eYmA4cdd/H9JLB/47eVbJPRDh/BR01updSuIcfzFJVOvFUdM99grdI++Hb6QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684830; c=relaxed/simple;
	bh=1O/wP9rvmPeZrRl625NzZqbNnLbiuhYCS1deBIYhZQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFHsXk/6xu3YPE7qf52Fakzd2TY00zDhOp4QQasFjvXDkgnC8p12d/xfRsEpysXiaojYxWFFmvG5agOM81+bnco19/eQ+5z/nGDpcOgrM/Vg6vSyeaBJaslgJ0KunXlz8yhXN4Ft51lc5t7AjOmfF7znq18Abiweq/DHF9lBwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbBolB2/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738684827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VQeQVNRtN3YgkmOYd3AaFO1X0gu38baF3CR9tNQKQyQ=;
	b=GbBolB2/Jq3GWfV6ZtpsJ179EEP79X7GMWoHYr6qq+92xbNhXdeHuavSI3n8cGO7ThqEbC
	a9CjZRU487BjG7vxq1VlUd/XaDTvTktKLYqfcd29i5IWy3KgYJCwjfpI6f82sDZNrJpYcl
	3HK9W4zTK9dLSNBzLWDmV3TKZATWPZ4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-Qh81uh31PK6cLAX4qTkThw-1; Tue, 04 Feb 2025 11:00:25 -0500
X-MC-Unique: Qh81uh31PK6cLAX4qTkThw-1
X-Mimecast-MFC-AGG-ID: Qh81uh31PK6cLAX4qTkThw
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7bcf4d3c1c1so869578085a.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 08:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738684825; x=1739289625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQeQVNRtN3YgkmOYd3AaFO1X0gu38baF3CR9tNQKQyQ=;
        b=s0shmTLUEDJyTaiEALLThItBlf7/2043BfI4w5S5BhondWnrAtws5oySzB2cZeS+Dx
         RC/iDLQhXu4+xLQxKqRGxxsbdPHsCmAb9fWbEnb3lCzdOF3AHRykwxjVj74YC8DQGT1k
         g2BI8iKQpEOHJvLCdR/rHOXJGlfhwRWVTSnve75azMyNo0znex0Hzwnkx4gy2aAl+S2b
         TXO2ERAAM0lFyB5z/33oZutWS6qd3/PynT45pRIwGHIJ9f4IeJLlyi7LYCTKO2r/EkeO
         tgTYAE6uY3dyiinCBBegBgzt5rDTSPQkdKmPatpduQ8gq6bs+lBgAcn6m7tfTAf/qxT2
         LQhA==
X-Forwarded-Encrypted: i=1; AJvYcCVjRi8jDyMPR/515tbU02pKiimohZ48wHE/4I+doFTIb42XA8v7PzFt7N7+kHHeZY6cIIHV4qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YweaFTPpfnF0NVIaXgKyRNIlYRPm2Yare9d7D8Iqlx4xjY6PpOM
	kqcHbY0/eOFluigIEebaLzvihStLbNgvNTQ9AmZueBeW2MxsSe3xp0CsimnGBuo+XqhLv4vs2AI
	m7bqmeWKrZJZ+QuUjyqUslyrkcmBhkojNUTXRc3elQ2PBjKN2NTfZBg==
X-Gm-Gg: ASbGncsrlooADQPiEEcFtzQna9nsRoU3xarm+h7GOfWMI1TI1BhaSXcdF14DZWJ82aC
	LyqHFY2bgYFY2k4t+EJqm9zEiwIBHdS0QDqYQsvAb/9wHE9BDcXuiwEjMx+u7al1zJO7ZVdAzwW
	UoJ8d3DYOoCk19H1cQqoKc8axXe2XlLH3BHY7f+XwB9iSn548P+tn/EoytDhJ0/54bHwoncOWqd
	ojVyAy/Pr35OW+SHvmH4fOZXM7NqVR8v1oK8kcJFRS7RvXpua/tAQiU9bWNv++pgvAXXqagMidI
	V1jcUZvJ6g==
X-Received: by 2002:a05:620a:2609:b0:7b6:efd0:3d1e with SMTP id af79cd13be357-7bffcda534bmr4587392985a.53.1738684824375;
        Tue, 04 Feb 2025 08:00:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAzo8YaZRMK8ajt6OxqGDW+Sj15Mdkt2eLhS8DtBinrVor/FEjWi7axlukvj1WQmCBNIR2Cw==
X-Received: by 2002:a05:620a:2609:b0:7b6:efd0:3d1e with SMTP id af79cd13be357-7bffcda534bmr4587364685a.53.1738684823018;
        Tue, 04 Feb 2025 08:00:23 -0800 (PST)
Received: from sgarzare-redhat ([185.121.209.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a90558csm656228185a.74.2025.02.04.08.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:00:22 -0800 (PST)
Date: Tue, 4 Feb 2025 17:00:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com, fstornio@redhat.com
Subject: Re: [PATCH net 1/2] vsock: Orphan socket after transport release
Message-ID: <huosgcp4y7rr4ppagt7232oexydso6nxv3hzk5qi2euqqqyp6f@mfggrtjrzjdu>
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
 <20250204-vsock-linger-nullderef-v1-1-6eb1760fa93e@rbox.co>
 <jj6xlb2udt2khosipoi4m6iwjc6g5hau3jnzbf6dg2aredfykp@y7j4jlgd4tpr>
 <jfkqsbbq5um6nmlhnxxgx3eg7aopnwaddqvcj7s6svmpujswub@42sq2pawnsxn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <jfkqsbbq5um6nmlhnxxgx3eg7aopnwaddqvcj7s6svmpujswub@42sq2pawnsxn>

On Tue, Feb 04, 2025 at 04:44:13PM +0100, Luigi Leonardi wrote:
>On Tue, Feb 04, 2025 at 11:32:54AM +0100, Stefano Garzarella wrote:
>>On Tue, Feb 04, 2025 at 01:29:52AM +0100, Michal Luczaj wrote:
>>>During socket release, sock_orphan() is called without considering that it
>>>sets sk->sk_wq to NULL. Later, if SO_LINGER is enabled, this leads to a
>>>null pointer dereferenced in virtio_transport_wait_close().
>>>
>>>Orphan the socket only after transport release.
>>>
>>>Partially reverts the 'Fixes:' commit.
>>>
>>>KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
>>>lock_acquire+0x19e/0x500
>>>_raw_spin_lock_irqsave+0x47/0x70
>>>add_wait_queue+0x46/0x230
>>>virtio_transport_release+0x4e7/0x7f0
>>>__vsock_release+0xfd/0x490
>>>vsock_release+0x90/0x120
>>>__sock_release+0xa3/0x250
>>>sock_close+0x14/0x20
>>>__fput+0x35e/0xa90
>>>__x64_sys_close+0x78/0xd0
>>>do_syscall_64+0x93/0x1b0
>>>entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>>Reported-by: syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
>>>Closes: https://syzkaller.appspot.com/bug?extid=9d55b199192a4be7d02c
>>>Fixes: fcdd2242c023 ("vsock: Keep the binding until socket destruction")
>>
>>Looking better at that patch, can you check if we break commit
>>3a5cc90a4d17 ("vsock/virtio: remove socket from connected/bound list 
>>on shutdown")
>>
>>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3a5cc90a4d1756072619fe511d07621bdef7f120
>>
>I worked with Filippo (+CC) on this patch.
>
>IMHO it shouldn't do any harm. `sock_orphan` sets sk->sk_socket and 
>sk_wq to NULL, and sets the SOCK_DEAD flag.
>
>This patch sets the latter in the same place. All the other fields are 
>not used by the transport->release() (at least in virtio-based 
>transports), so from my perspective there is no real change.
>
>What was your concern?

My concern was more about calling `vsock_remove_sock()` in 
virtio_transport_recv_connected:

I mean this block:
	case VIRTIO_VSOCK_OP_SHUTDOWN:
		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_RCV)
			vsk->peer_shutdown |= RCV_SHUTDOWN;
		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_SEND)
			vsk->peer_shutdown |= SEND_SHUTDOWN;
		if (vsk->peer_shutdown == SHUTDOWN_MASK) {
			if (vsock_stream_has_data(vsk) <= 0 && !sock_flag(sk, SOCK_DONE)) {
				(void)virtio_transport_reset(vsk, NULL);
				virtio_transport_do_close(vsk, true);
			}
			/* Remove this socket anyway because the remote peer sent
			 * the shutdown. This way a new connection will succeed
			 * if the remote peer uses the same source port,
			 * even if the old socket is still unreleased, but now disconnected.
			 */
			vsock_remove_sock(vsk);
		}

After commit fcdd2242c023 ("vsock: Keep the binding until socket 
destruction") calling `vsock_remove_sock` without SOCK_DEAD set, removes 
the socket only from the connected list.

So, IMHO there is a real change, but I'm not sure if it's an issue or 
not, since the issue fixed by commit 3a5cc90a4d17 ("vsock/virtio: remove 
socket from connected/bound list on shutdown") was more about the remote 
port IIRC, so that should only be affected by the connected list, which 
is stll touched now.

Stefano


