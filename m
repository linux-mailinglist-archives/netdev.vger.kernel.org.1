Return-Path: <netdev+bounces-162618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF24A2764B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4651C1883D3B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65AF2144B1;
	Tue,  4 Feb 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJy7F+7s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E825A659
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683863; cv=none; b=ribY90rwBkwctJ12vLWhuEX5M4xtEpUZcxJ4fxhoQx5FLTcTPosu/RffnzDzk8merWjWxYgbt5PPHjTGQoufW49kQkcYucLPGFbENGmn49n201cCQqxPkdotCJV1booV+sRLHeuHb1358Gq3/GVFpm4uonzbpKikhVhwuJ2Mz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683863; c=relaxed/simple;
	bh=wBQzymqWxVBXoUEhTUaHzmESPB8vLWHnCnNIkam6n9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBCP00U8STE5B7nCQUR5W22doAMQdyrqF9x5vmPaqsFrRVMPDQ9XsNig/hcWgDPzqB9d2LOjBf0m196aGqDSpmTuBO8nR99Fc7T3a/K539sj99JUOPgE+pxA1kS0X0Dije4rmqhqdpFj9B8jYNV2WS+o9bP3/n0t0UUmI+yFB4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJy7F+7s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738683860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yfd+kVRIxP5LuXNsbqeYTnwL9Y65hDZSnG9R0qhFphI=;
	b=YJy7F+7sXxakxLLtgLtv6wIWa4040WsW+5gAgQbneU1Nvy1V7k3yryf/LfHupoTbv/1IMR
	+QnTcU95ZPPQA5/DCeiORY+1jcPSE+Upd8yhnElqLBl52BiNFjqAJFE6czBVplMUtD7IrG
	+Paztxya/zutsnuwGH4qnWQZE5zU10U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-zFWathpWPNiVctH8MCkoAA-1; Tue, 04 Feb 2025 10:44:18 -0500
X-MC-Unique: zFWathpWPNiVctH8MCkoAA-1
X-Mimecast-MFC-AGG-ID: zFWathpWPNiVctH8MCkoAA
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e42197595cso36020866d6.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 07:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738683858; x=1739288658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfd+kVRIxP5LuXNsbqeYTnwL9Y65hDZSnG9R0qhFphI=;
        b=g0QOv5ZhLAuc9U3gTlNkn6uYvydgHEMrW8Qh8PezRAm0ImFC3YBcHC7+UHDqQJkiPg
         35zSpAsXk7Ouf9d2EdmL3XoI8BF9zi+65fvVXrxCevbR398i8dGAS1vZmt3ZqwFEX0/B
         9OvorNgMmgPvdqTPJ3QbAmm14ORdcVeagFwbLEDUsg3TzcrBV7Sa3oa9Yqekl/2+VhM4
         jUUrNT49j1be3wK+noKKp73XIg9PKvKNdVn8XjfQ+/4LBceNRDsEVykk4pVi9tT3sWG7
         8ZGsgypWTNxfWcpSjh086F/gonxHN7LAG4I/nG+Pyt3ovGjmN2dE+4fe1yoCGt5tb+uZ
         nqZA==
X-Forwarded-Encrypted: i=1; AJvYcCUc44WgGBM1mQymkBmW4GJgzfMhTAojtC4bkytNUj/EDhuZLPfbB1vXdrPihNmQkfBt/tYV+8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTfUH6D1iIoTGrT1pSa+Xb4+JNgJnPaUjSd2GqdukGPeQyR1G
	XtVF9Rw1nmZiuVSUr+iPfCNQyxWg37SYPaU05nBN1CgTt2d35wKKOpR5VUwnfNKq7gkcQevF0hw
	+i1u3gLCGDsMhnCfAwqp1r87vNnwrAnirNxFeC3wLNQddrtwhsncO/w==
X-Gm-Gg: ASbGncvGXTwZj4BXjvPtNOcnW+QHg4UQTKjN0ZK9HhuPp9I+a/pmkyRTxu54Oz17EN0
	v9JPOBvry9RVw8asUsBYGpM+0ZvxJd/8KnDHxO1ure9vSGgL4Y4cSbFJbNMd3ouKwn+/Gz895dQ
	pLdk568rSbVTirJAGnDEH/xgpl6e21MEw39p3VIpXlfBjEYImn8uWWhJtU5+5+Dnap/ASzFYdWK
	pgsDR8iUrFFF/106zotoZFhHXvDfP56b9TwVrNItWPv9M4xBL1bnVU7DiJfwL+kT46KRRKGa0CL
	oQgU8rZ4
X-Received: by 2002:a05:6214:1307:b0:6d4:e0a:230e with SMTP id 6a1803df08f44-6e243bbba57mr399459836d6.16.1738683857982;
        Tue, 04 Feb 2025 07:44:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK0rD3/EuDPCv9ku6AOkxx/KM3+AQfiqkt8DzxvOc+hKZpuFNgiwwCyM+C0W606AJEjY9rbA==
X-Received: by 2002:a05:6214:1307:b0:6d4:e0a:230e with SMTP id 6a1803df08f44-6e243bbba57mr399459426d6.16.1738683857662;
        Tue, 04 Feb 2025 07:44:17 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254817c59sm63168396d6.36.2025.02.04.07.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 07:44:17 -0800 (PST)
Date: Tue, 4 Feb 2025 16:44:13 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com, fstornio@redhat.com
Subject: Re: [PATCH net 1/2] vsock: Orphan socket after transport release
Message-ID: <jfkqsbbq5um6nmlhnxxgx3eg7aopnwaddqvcj7s6svmpujswub@42sq2pawnsxn>
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
 <20250204-vsock-linger-nullderef-v1-1-6eb1760fa93e@rbox.co>
 <jj6xlb2udt2khosipoi4m6iwjc6g5hau3jnzbf6dg2aredfykp@y7j4jlgd4tpr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <jj6xlb2udt2khosipoi4m6iwjc6g5hau3jnzbf6dg2aredfykp@y7j4jlgd4tpr>

On Tue, Feb 04, 2025 at 11:32:54AM +0100, Stefano Garzarella wrote:
>On Tue, Feb 04, 2025 at 01:29:52AM +0100, Michal Luczaj wrote:
>>During socket release, sock_orphan() is called without considering that it
>>sets sk->sk_wq to NULL. Later, if SO_LINGER is enabled, this leads to a
>>null pointer dereferenced in virtio_transport_wait_close().
>>
>>Orphan the socket only after transport release.
>>
>>Partially reverts the 'Fixes:' commit.
>>
>>KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
>>lock_acquire+0x19e/0x500
>>_raw_spin_lock_irqsave+0x47/0x70
>>add_wait_queue+0x46/0x230
>>virtio_transport_release+0x4e7/0x7f0
>>__vsock_release+0xfd/0x490
>>vsock_release+0x90/0x120
>>__sock_release+0xa3/0x250
>>sock_close+0x14/0x20
>>__fput+0x35e/0xa90
>>__x64_sys_close+0x78/0xd0
>>do_syscall_64+0x93/0x1b0
>>entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>>Reported-by: syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
>>Closes: https://syzkaller.appspot.com/bug?extid=9d55b199192a4be7d02c
>>Fixes: fcdd2242c023 ("vsock: Keep the binding until socket destruction")
>
>Looking better at that patch, can you check if we break commit
>3a5cc90a4d17 ("vsock/virtio: remove socket from connected/bound list 
>on shutdown")
>
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3a5cc90a4d1756072619fe511d07621bdef7f120
>
I worked with Filippo (+CC) on this patch.

IMHO it shouldn't do any harm. `sock_orphan` sets sk->sk_socket and 
sk_wq to NULL, and sets the SOCK_DEAD flag.

This patch sets the latter in the same place. All the other fields are 
not used by the transport->release() (at least in virtio-based 
transports), so from my perspective there is no real change.

What was your concern?

>BTW we also added a test to cover that scenario, so we should be fine 
>since the suite I run was fine.
Yep! Test runs fine.
>
>>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>---
>>net/vmw_vsock/af_vsock.c | 3 ++-
>>1 file changed, 2 insertions(+), 1 deletion(-)
>>
>>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>index 075695173648d3a4ecbd04e908130efdbb393b41..06250bb9afe2f253e96130b73554aae9151aaac1 100644
>>--- a/net/vmw_vsock/af_vsock.c
>>+++ b/net/vmw_vsock/af_vsock.c
>>@@ -824,13 +824,14 @@ static void __vsock_release(struct sock *sk, int level)
>>	 */
>>	lock_sock_nested(sk, level);
>>
>
>I would add a comment here to explain that we need to set it, so 
>vsock_remove_sock() called here some lines above, or by transports in 
>the release() callback (maybe in the future we can refactor it, and 
>call it only here) will remove the binding only if it's set, since the 
>release() is also called when de-assigning the transport.
>
>Thanks,
>Stefano
>
>>-	sock_orphan(sk);
>>+	sock_set_flag(sk, SOCK_DEAD);
>>
>>	if (vsk->transport)
>>		vsk->transport->release(vsk);
>>	else if (sock_type_connectible(sk->sk_type))
>>		vsock_remove_sock(vsk);
>>
>>+	sock_orphan(sk);
>>	sk->sk_shutdown = SHUTDOWN_MASK;
>>
>>	skb_queue_purge(&sk->sk_receive_queue);
>>
>>-- 
>>2.48.1
>>
>

@Michal From the code POV I have no concerns, LGTM :)

Thanks,
Luigi


