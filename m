Return-Path: <netdev+bounces-162451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049CA26F5B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF93A3A419F
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB7208974;
	Tue,  4 Feb 2025 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ow732BUz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4016201267
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738665194; cv=none; b=kjnPFNNccR4DEtU6ljAltb/kd2zi5tPZlVFJFwNaoRY9H2KLWvF6j6oPO62/cYj6MWZrMQCQwe4nFXIaA7SYuOQFwdq5zC1I2sdGb/Cg4FpGerWJ9panwUx5vOAh222xH3b6PSCcwjoYubWQEfAyNLs/7N0n1Y7In0Xn5Oo7h4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738665194; c=relaxed/simple;
	bh=4b1XBzE/5m+KY+suZ2pVCme2vZvnTO+SiWQYm81I2P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTJcN2jYgA6G/ocSjynDW0yxCTVW6KoAfu5SlR3J9tcQDjsTUsS/4PeBNqKcm6xIrsVjYTQxhbATr9Bmm9UuK3nDvVyq03q6ManZ5BLlqJuQWQzWe+Y0ZGra3pxNYcsprh1+6vV3lCJ4yu2Quv0uvYEXqVpDHP9Zw6iOdH7yMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ow732BUz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738665190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEbOKJcttALVbM6Ki5YiOhGoWYNR+/Pc6aq5Y7Ov0u0=;
	b=Ow732BUzVlye8mQ/1E3Mv6bp6Y/dYtqLBClg1GABYshpuKA2KsjersIMgpXQtPVja5a5On
	RHfbiu1DOBR2tOewmyu/ktYrTvHeSYuXpki3/g9HUY/objuOXd4lMbmvIJbH4sn62sOjeO
	sfIve2P5IAgIrKSpdLCodhiq/VQD1fg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-7zbi9oooNfmTBlGhQ2f8dQ-1; Tue, 04 Feb 2025 05:33:05 -0500
X-MC-Unique: 7zbi9oooNfmTBlGhQ2f8dQ-1
X-Mimecast-MFC-AGG-ID: 7zbi9oooNfmTBlGhQ2f8dQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4362552ce62so27358515e9.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 02:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738665181; x=1739269981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEbOKJcttALVbM6Ki5YiOhGoWYNR+/Pc6aq5Y7Ov0u0=;
        b=sbWQ8H+PfACQqL8aYoGHjSaTtQM8xExw8v+c0TFMCud9hslPIcDvCyWbKsAK5Bn9BY
         v6iHw+jk0k8wBlct9njf9BqAfpDGI/A0bUcFeI4Tz/68W67xJiA47IFqIcxAnuSEJ/jL
         hnykLOl3N7ytwJ38qlxMdw2pj5H9oWViECwfXunyvKnZUdivw9FINvm7vu1VZv7aliiO
         s74vw1/eXxHVr8N3DPqKvsDdSVbvA6z3Fe5hmejx7Mm97YvvGdzkJhu69iUmiBBMkZyE
         vgFzQU3uE2S2ParIX6cgF2qva95xAyOvt9RChZd0b8cutw2MzBo03PYUq5rpR2oNCypp
         iRzw==
X-Forwarded-Encrypted: i=1; AJvYcCUZlvm70LD0EqC6lsoYgE79OYy5sJf6Ily5hqiUaIu89NvHZ5q4JHN+tdYLkiGnzJe9H2kGsPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVCg7VY9tqfef6IpTGjih1/ZqYC87fVXLsBDI7z1YtvBsUd7yq
	LOgdAA//SqId49oJHEpb+RUkWZiQ2dJPk41GDP3Kgh/+nr+PdfuPfAlACDZftWP2qYM4D7aO9Tw
	bZwZcvancI5By+moXHUjoBcbbHRInhu9DWQMl4EE2SS6FgRS0fXaaIw==
X-Gm-Gg: ASbGncscOMJB6mjvDtji4zvmcqNcaRNF6bPSNgZ+BSkEbpfLtC7GsobHz+QU+tpWi1l
	DM1L2yOY/PZW8Up4rtyfER6F1Yl3ODQ3wi+wf0MBtldtW/jLe2juDmmbPuYkuWjKWydWUBW5aW0
	tfGoYLg+w09/265n5KToUEnGZdRbRuiWSel+q0tsCEtqNSPrEECIb1s2JsnHXddmaavX89grDoo
	XoUq694uF39zPVCISY6OE6waPOv1t9fFyZdqzGZrXgkAsSNA803kxLEQMNGL3hiiPenGrPvlf2m
	7glmQdX2lA==
X-Received: by 2002:a5d:5987:0:b0:38a:5122:5a07 with SMTP id ffacd0b85a97d-38c5194a22emr20746730f8f.15.1738665181027;
        Tue, 04 Feb 2025 02:33:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGByaI2uELIcLfn7blwblakqv+128hygenPz/zBl9e9SRsA+NvI1A85jtvCxOgmDmqcfxSohQ==
X-Received: by 2002:a5d:5987:0:b0:38a:5122:5a07 with SMTP id ffacd0b85a97d-38c5194a22emr20746696f8f.15.1738665180314;
        Tue, 04 Feb 2025 02:33:00 -0800 (PST)
Received: from sgarzare-redhat ([185.121.209.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244f38esm187969545e9.26.2025.02.04.02.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 02:32:59 -0800 (PST)
Date: Tue, 4 Feb 2025 11:32:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
Subject: Re: [PATCH net 1/2] vsock: Orphan socket after transport release
Message-ID: <jj6xlb2udt2khosipoi4m6iwjc6g5hau3jnzbf6dg2aredfykp@y7j4jlgd4tpr>
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
 <20250204-vsock-linger-nullderef-v1-1-6eb1760fa93e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250204-vsock-linger-nullderef-v1-1-6eb1760fa93e@rbox.co>

On Tue, Feb 04, 2025 at 01:29:52AM +0100, Michal Luczaj wrote:
>During socket release, sock_orphan() is called without considering that it
>sets sk->sk_wq to NULL. Later, if SO_LINGER is enabled, this leads to a
>null pointer dereferenced in virtio_transport_wait_close().
>
>Orphan the socket only after transport release.
>
>Partially reverts the 'Fixes:' commit.
>
>KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> lock_acquire+0x19e/0x500
> _raw_spin_lock_irqsave+0x47/0x70
> add_wait_queue+0x46/0x230
> virtio_transport_release+0x4e7/0x7f0
> __vsock_release+0xfd/0x490
> vsock_release+0x90/0x120
> __sock_release+0xa3/0x250
> sock_close+0x14/0x20
> __fput+0x35e/0xa90
> __x64_sys_close+0x78/0xd0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Reported-by: syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=9d55b199192a4be7d02c
>Fixes: fcdd2242c023 ("vsock: Keep the binding until socket destruction")

Looking better at that patch, can you check if we break commit
3a5cc90a4d17 ("vsock/virtio: remove socket from connected/bound list on 
shutdown")

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3a5cc90a4d1756072619fe511d07621bdef7f120

BTW we also added a test to cover that scenario, so we should be fine 
since the suite I run was fine.

>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 075695173648d3a4ecbd04e908130efdbb393b41..06250bb9afe2f253e96130b73554aae9151aaac1 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -824,13 +824,14 @@ static void __vsock_release(struct sock *sk, int level)
> 	 */
> 	lock_sock_nested(sk, level);
>

I would add a comment here to explain that we need to set it, so 
vsock_remove_sock() called here some lines above, or by transports in 
the release() callback (maybe in the future we can refactor it, and call 
it only here) will remove the binding only if it's set, since the 
release() is also called when de-assigning the transport.

Thanks,
Stefano

>-	sock_orphan(sk);
>+	sock_set_flag(sk, SOCK_DEAD);
>
> 	if (vsk->transport)
> 		vsk->transport->release(vsk);
> 	else if (sock_type_connectible(sk->sk_type))
> 		vsock_remove_sock(vsk);
>
>+	sock_orphan(sk);
> 	sk->sk_shutdown = SHUTDOWN_MASK;
>
> 	skb_queue_purge(&sk->sk_receive_queue);
>
>-- 
>2.48.1
>


