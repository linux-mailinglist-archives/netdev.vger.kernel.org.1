Return-Path: <netdev+bounces-153038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F8C9F6A0F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E43A1887950
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7DF1DED77;
	Wed, 18 Dec 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fg4f/y9K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CEA1DB363
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535876; cv=none; b=GBMrglzL46lokCwgKB9JMzGppceNYPKPrtwHyxuum27dg3mfGaq2Izx/hzDy2JR25MY+HcbrFKhQCQcssQ+UNYtm03tKT6dOoxgCKrSYu7/k/TcocwJYkYToaGdaVjcWv75ZQm1hr3WvJSlMu5K1VF5HRLyQPQ4OFb4TmiXUHY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535876; c=relaxed/simple;
	bh=r3XUVXoTJXySn8j6M/I5ggNYgQbkFXVfuxSN+4AJWE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvoFkBOynLWIr35yt5jyIn3el9AcyNuWcLJybfG5IDTzv3GLpG3vHHpyCxkx10mAOd27boHH8ruhQJHo0AXcK1MjLtZ/9z6hoIndsO3S64yh8rKPkaHiZ0u4eO33iQ0EUQzCRRPQp7T414ls2i4XI8fDlXw5Ruq2BI238jwVqAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fg4f/y9K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734535874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zP6jpPRpC9DNILLQoSAYB9QA64lMMdKrQX15yrk9XVE=;
	b=Fg4f/y9KJXGpmHPXs0puLYEj9A0ch23sQxMayCLGE9XLHxABt2DpxuQU2bCt0JA4+hMl7Z
	PBlT9VV0aRNjpDxp3q9CZOblgFH2gE2Q2XVgw8cxASh/WK2Z7BSTvzO074B5Og3CPz5R72
	gX0xj4sVld31V5VwWRab3JAF5TvZO4k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-0Zf-acb3OnGpSKz1ZgEQIA-1; Wed, 18 Dec 2024 10:31:10 -0500
X-MC-Unique: 0Zf-acb3OnGpSKz1ZgEQIA-1
X-Mimecast-MFC-AGG-ID: 0Zf-acb3OnGpSKz1ZgEQIA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e1339790so3940766f8f.2
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 07:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734535869; x=1735140669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zP6jpPRpC9DNILLQoSAYB9QA64lMMdKrQX15yrk9XVE=;
        b=pnCXPhtPJ+T9f4wxHlqRGK9K+OXx+d/5OnIOqgPQb8mo0289H9tffcJkplfFyvA1Ri
         FFlVNFgB82NrxJvRvu51KSGeZIhGYbTA4EYhrCA5ycyenp6WyLz+bD89aaZhlswQ/spZ
         EBldAVKH+dnf5/cMNSffxoniWhTwXM72BrAipjYrqcDQYkOevfG0VYP7+8ZDV7YgMIgI
         A85xk9ze2yTAGr0apCm28nK4HSM1tFy0oH6QxMZx7LJr2DOb+41zu6OtcT0fwbwPFXuZ
         IHgpBEYh34e1ckY9DoYiTdA/tMI9NXPSxpy6bDIr1/RV6IzF90WhEqRd2dYr9lM9aNaA
         0EHA==
X-Forwarded-Encrypted: i=1; AJvYcCXWwKg+AVRMB+AMZkgtoNkNGWgTfBKm394VsC2wxqTqwNmKPm7JzvhsVaXK81vAdQ1tuauLJ2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj8oSB0ffh9Z2NdI0zSFlHA8d8ONTzi9fQcmLZ61Pcprm94Wut
	kcUTGgnkx1oqWpeIUouqqiwbQjV5SWV1T5w70lOsuLSfsOn8t8l9K8xqXzCUn6xb2QM3DwYEJpr
	jEZZVJ/koOMdYmWkpBYfhYClQDFMJhxAYt+g9y8TzHWFrbtugLuigUw==
X-Gm-Gg: ASbGncs9VdByX5AY0vMoRzgDsux5Zi9Usup4ZJg6q+etJvnQvqFDUKVcdjFpORXcjy2
	JHgm9muDtk4SxgtdxnmuAGjqPNpXq8MmaM6T4nE0riajuVPCVVJl9YYt5rI+ZSupUDJd15bLaMD
	sQvIdWrb1Gp1pcuzd11xUjiAXFGA1F66D/DOOp4EyrumF11OeaqxYmVJ0SOHuNylOO4CfB47ezN
	7KlOAt6Zlh48gz3PnufI4qsqJlvAtK/mI7N1zplQf5Q8DLbVZdffNo18T66JkQ1Yx5vOLftNIAR
	0aoAvn//+iKMof1VBJ0R4bQ9Kxyelxg1
X-Received: by 2002:a5d:59a5:0:b0:385:dc45:ea22 with SMTP id ffacd0b85a97d-38a19b34cfemr2228f8f.39.1734535868963;
        Wed, 18 Dec 2024 07:31:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDDdXPUZnVUVG+84ipcndh/cFh9e/6HZbYw/dYlro0c6HYQ/SQobmD1ixPZyJDlF01VybrxQ==
X-Received: by 2002:a5d:59a5:0:b0:385:dc45:ea22 with SMTP id ffacd0b85a97d-38a19b34cfemr2154f8f.39.1734535868295;
        Wed, 18 Dec 2024 07:31:08 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c804a2f9sm14540515f8f.77.2024.12.18.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 07:31:07 -0800 (PST)
Date: Wed, 18 Dec 2024 16:31:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, qwerty@theori.io, imv4bel@gmail.com
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
Message-ID: <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
 <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
 <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX>
 <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>

On Wed, Dec 18, 2024 at 03:40:40PM +0100, Stefano Garzarella wrote:
>On Wed, Dec 18, 2024 at 09:19:08AM -0500, Hyunwoo Kim wrote:
>>On Wed, Dec 18, 2024 at 02:40:49PM +0100, Stefano Garzarella wrote:
>>>On Wed, Dec 18, 2024 at 07:25:07AM -0500, Hyunwoo Kim wrote:
>>>> When calling connect to change the CID of a vsock, the loopback
>>>> worker for the VIRTIO_VSOCK_OP_RST command is invoked.
>>>> During this process, vsock_stream_has_data() calls
>>>> vsk->transport->stream_has_data().
>>>> However, a null-ptr-deref occurs because vsk->transport was set
>>>> to NULL in vsock_deassign_transport().
>>>>
>>>>                     cpu0                                                      cpu1
>>>>
>>>>                                                               socket(A)
>>>>
>>>>                                                               bind(A, VMADDR_CID_LOCAL)
>>>>                                                                 vsock_bind()
>>>>
>>>>                                                               listen(A)
>>>>                                                                 vsock_listen()
>>>>  socket(B)
>>>>
>>>>  connect(B, VMADDR_CID_LOCAL)
>>>>
>>>>  connect(B, VMADDR_CID_HYPERVISOR)
>>>>    vsock_connect(B)
>>>>      lock_sock(sk);

It shouldn't go on here anyway, because there's this check in 
vsock_connect():

	switch (sock->state) {
	case SS_CONNECTED:
		err = -EISCONN;
		goto out;


Indeed if I try, I have this behaviour:

shell1# python3
import socket
s = socket.socket(socket.AF_VSOCK, socket.SOCK_STREAM)
s.bind((1,1234))
s.listen()

shell2# python3
import socket
s = socket.socket(socket.AF_VSOCK, socket.SOCK_STREAM)
s.connect((1, 1234))
s.connect((2, 1234))
Traceback (most recent call last):
   File "<stdin>", line 1, in <module>
OSError: [Errno 106] Transport endpoint is already connected


Where 106 is exactly EISCONN.
So, do you have a better reproducer for that?

Would be nice to add a test in tools/testing/vsock/vsock_test.c

Thanks,
Stefano

>>>>      vsock_assign_transport()
>>>>        virtio_transport_release()
>>>>          virtio_transport_close()
>>>>            virtio_transport_shutdown()
>>>>              virtio_transport_send_pkt_info()
>>>>                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>>>>                  queue_work(vsock_loopback_work)
>>>>        vsock_deassign_transport()
>>>>          vsk->transport = NULL;
>>>>                                                               vsock_loopback_work()
>>>>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>>>>                                                                   virtio_transport_recv_connected()
>>>>                                                                     virtio_transport_reset()
>>>>                                                                       virtio_transport_send_pkt_info()
>>>>                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
>>>>                                                                           queue_work(vsock_loopback_work)
>>>>
>>>>                                                               vsock_loopback_work()
>>>>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
>>>> 								   virtio_transport_recv_disconnecting()
>>>> 								     virtio_transport_do_close()
>>>> 								       vsock_stream_has_data()
>>>> 								         vsk->transport->stream_has_data(vsk);    // null-ptr-deref
>>>>
>>>> To resolve this issue, add a check for vsk->transport, similar to
>>>> functions like vsock_send_shutdown().
>>>>
>>>> Fixes: fe502c4a38d9 ("vsock: add 'transport' member in the struct vsock_sock")
>>>> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
>>>> Signed-off-by: Wongi Lee <qwerty@theori.io>
>>>> ---
>>>> net/vmw_vsock/af_vsock.c | 3 +++
>>>> 1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>> index 5cf8109f672a..a0c008626798 100644
>>>> --- a/net/vmw_vsock/af_vsock.c
>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>> @@ -870,6 +870,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
>>>>
>>>> s64 vsock_stream_has_data(struct vsock_sock *vsk)
>>>> {
>>>> +	if (!vsk->transport)
>>>> +		return 0;
>>>> +
>>>
>>>I understand that this alleviates the problem, but IMO it is not the right
>>>solution. We should understand why we're still processing the packet in the
>>>context of this socket if it's no longer assigned to the right transport.
>>
>>Got it. I agree with you.
>>
>>>
>>>Maybe we can try to improve virtio_transport_recv_pkt() and check if the
>>>vsk->transport is what we expect, I mean something like this (untested):
>>>
>>>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>index 9acc13ab3f82..18b91149a62e 100644
>>>--- a/net/vmw_vsock/virtio_transport_common.c
>>>+++ b/net/vmw_vsock/virtio_transport_common.c
>>>@@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>>>
>>>        lock_sock(sk);
>>>
>>>-       /* Check if sk has been closed before lock_sock */
>>>-       if (sock_flag(sk, SOCK_DONE)) {
>>>+       /* Check if sk has been closed or assigned to another transport before
>>>+        * lock_sock
>>>+        */
>>>+       if (sock_flag(sk, SOCK_DONE) || vsk->transport != t) {
>>>                (void)virtio_transport_reset_no_sock(t, skb);
>>>                release_sock(sk);
>>>                sock_put(sk);
>>>
>>>BTW I'm not sure it is the best solution, we have to check that we do not
>>>introduce strange cases, but IMHO we have to solve the problem earlier in
>>>virtio_transport_recv_pkt().
>>
>>At least for vsock_loopback.c, this change doesn’t seem to introduce any
>>particular issues.
>
>But was it working for you? because the check was wrong, this one 
>should work, but still, I didn't have time to test it properly, I'll 
>do later.
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 9acc13ab3f82..ddecf6e430d6 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>        lock_sock(sk);
>-       /* Check if sk has been closed before lock_sock */
>-       if (sock_flag(sk, SOCK_DONE)) {
>+       /* Check if sk has been closed or assigned to another transport before
>+        * lock_sock
>+        */
>+       if (sock_flag(sk, SOCK_DONE) || vsk->transport != &t->transport) {
>                (void)virtio_transport_reset_no_sock(t, skb);
>                release_sock(sk);
>                sock_put(sk);
>
>>
>>And separately, I think applying the vsock_stream_has_data patch would help
>>prevent potential issues that could arise when vsock_stream_has_data is
>>called somewhere.
>
>Not sure, with that check, we wouldn't have seen this problem we had, 
>so either add an error, but mute it like this I don't think is a good 
>idea, also because the same function is used in a hot path, so an 
>extra check could affect performance (not much honestly in this case, 
>but adding it anywhere could).
>
>Thanks,
>Stefano
>
>>
>>>
>>>Thanks,
>>>Stefano
>>>
>>>> 	return vsk->transport->stream_has_data(vsk);
>>>> }
>>>> EXPORT_SYMBOL_GPL(vsock_stream_has_data);
>>>> --
>>>> 2.34.1
>>>>
>>>
>>


