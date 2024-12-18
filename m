Return-Path: <netdev+bounces-152997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8B19F68E5
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F1916F84A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83DB1F63DF;
	Wed, 18 Dec 2024 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asEgRmHG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001011F63CF
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532851; cv=none; b=nMADF8B18wt3947bO68Fd2EHryS3xljqVj9qg6y8Wmpl9rUXF5R6fkhRkBuSUCyFVWrCb3Cp+ZGFnAUrOQKQmWE0hOYDc7nfEdcZ/GQ7pAqV/PET0yv+eRaJ3KdfyPn5XO5EKlr0vkhYYqLBFa7FmN/HFAgkHlSxHxLORsSYjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532851; c=relaxed/simple;
	bh=MwPLENdg+Ia1pv5QVH281sJkOLiWbrHIz5j4P5RgxZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz6wLiFkFJiIbtzlPQF0BQ8j7KZ6GDLmNvsw5job6tIkebgvHwqb58XztUJLFoHdGPCeRCc7h5HldHrevDdRlXv94LKpaV2Dqttekt5ybj18uOg9hfatzRczFdswKrePDeCBX9zI2/Cy9/BC/iq+fWI/tz1QFKNEbzqFmHmOI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=asEgRmHG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734532848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/ln2iWwg3W1VlQ55SosBWfePkjE7g7a7xlkcFCzw0E=;
	b=asEgRmHGFMK38VHmvOxEHVSflcWDbJJKTi/joZL3sImkuv4yAt8dUv62gxoOLExXwwa4E2
	vuUDE7qqpeY8AoAKNgjDfChUZmwTjrfDXyuNBIKTGvVFVq+6yLbwQnfRXEisY7kNq6NEKc
	rc44hA2wUmJ1o+PSgJfxCWrxhlgEqFI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-8jK3Bc5FO5CDDkZiONlTMQ-1; Wed, 18 Dec 2024 09:40:47 -0500
X-MC-Unique: 8jK3Bc5FO5CDDkZiONlTMQ-1
X-Mimecast-MFC-AGG-ID: 8jK3Bc5FO5CDDkZiONlTMQ
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b93c7ffaeeso106005285a.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 06:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734532847; x=1735137647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/ln2iWwg3W1VlQ55SosBWfePkjE7g7a7xlkcFCzw0E=;
        b=H4Qw3YHg3yPYtgXlXhG5yeocwJB8ShQBl8SChiH/p8hSMn85s+yqdc4AuIQArU76hR
         3lr70RZ6eSTaAl5yvsYdRB5JZgPuJWGOLGaCSNkJPgRe+KkCl1U4kHW+So/pzGeYo+Ei
         edtBY/EMA99wGOtv+J08nqrNWTfSBBl5yK57Y21tAXmW+6FmjGw2+mXUElV2RBBXycxY
         yZ67BFiYNM7wE4NMi8sx7NGszvj3fal4UqIfpKOEFSeim2XLo8HfcNO1AyDTFPmyshaB
         SQ9HAMTBvsMyPZNMWML5rtVVaVwmpJBsqW+VWb7hJFSMY/QW+OPTdW2o+MtSvctAsfhc
         frrg==
X-Forwarded-Encrypted: i=1; AJvYcCXVwxQc07UPf8iSXpKnnki5TlbD+rZclKGBEt9/JHIAErXL2N4SSHjC8OEsgSDNYwwdw8H9K9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6eNoVA349e5Nn3FFRXqOMM9NrYhMmNwHBvYeq3JaaDc4/lktO
	BehvdDzqXMUhuW9kLAhBuVGjLiuyH64/MOP4YTUTcMqcYD/TTzmRDrOThor/q/IUWD5ZsLz3NyD
	N3pc9JjatNUyjpllHz5T5XcQSaaOUzFY/uDpTtT1u/BWn2dvG5rjZDA==
X-Gm-Gg: ASbGnctLnWgkQvk60aX/q5M42RKdliPIanzJuI4sqYqbiHnQW50NI0VwlwiCCJfXk95
	T0iTAdUh4QBEs0kNGTTlE2wA+M7L6HA5N/F/+dof9q6hpUPZI3i4BFAe/KSPFYfdCPacRguK5D5
	FhSqjbrORiv/IiBzUGpsibu56FKxmgprQ5tqOqmkRUnW0YCTs19lYhQ0yR1GDAcvllm6hDNJrb4
	hbY+7qAjkZjI5XxcrqdUG+aR00YagmbWxWkftFgdWlmrBB1Gbfszkmje70O9DdnG/GZcowLvaPt
	XmJoBqKVg8nNbddhrKeBpJq1kPESgrSN
X-Received: by 2002:ac8:7d4c:0:b0:466:93f3:5bf1 with SMTP id d75a77b69052e-46908f47101mr48585841cf.1.1734532847216;
        Wed, 18 Dec 2024 06:40:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ/MvaBfuDYs6BY9Cd4MpRj7KOAGySX61kha03o1FHj3J7vm9jIZZgayAzE8kcfJ0nF3xjFw==
X-Received: by 2002:ac8:7d4c:0:b0:466:93f3:5bf1 with SMTP id d75a77b69052e-46908f47101mr48585361cf.1.1734532846753;
        Wed, 18 Dec 2024 06:40:46 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e99c02sm51225531cf.67.2024.12.18.06.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:40:45 -0800 (PST)
Date: Wed, 18 Dec 2024 15:40:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, qwerty@theori.io, imv4bel@gmail.com
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
Message-ID: <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
 <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
 <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX>

On Wed, Dec 18, 2024 at 09:19:08AM -0500, Hyunwoo Kim wrote:
>On Wed, Dec 18, 2024 at 02:40:49PM +0100, Stefano Garzarella wrote:
>> On Wed, Dec 18, 2024 at 07:25:07AM -0500, Hyunwoo Kim wrote:
>> > When calling connect to change the CID of a vsock, the loopback
>> > worker for the VIRTIO_VSOCK_OP_RST command is invoked.
>> > During this process, vsock_stream_has_data() calls
>> > vsk->transport->stream_has_data().
>> > However, a null-ptr-deref occurs because vsk->transport was set
>> > to NULL in vsock_deassign_transport().
>> >
>> >                     cpu0                                                      cpu1
>> >
>> >                                                               socket(A)
>> >
>> >                                                               bind(A, VMADDR_CID_LOCAL)
>> >                                                                 vsock_bind()
>> >
>> >                                                               listen(A)
>> >                                                                 vsock_listen()
>> >  socket(B)
>> >
>> >  connect(B, VMADDR_CID_LOCAL)
>> >
>> >  connect(B, VMADDR_CID_HYPERVISOR)
>> >    vsock_connect(B)
>> >      lock_sock(sk);
>> >      vsock_assign_transport()
>> >        virtio_transport_release()
>> >          virtio_transport_close()
>> >            virtio_transport_shutdown()
>> >              virtio_transport_send_pkt_info()
>> >                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>> >                  queue_work(vsock_loopback_work)
>> >        vsock_deassign_transport()
>> >          vsk->transport = NULL;
>> >                                                               vsock_loopback_work()
>> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>> >                                                                   virtio_transport_recv_connected()
>> >                                                                     virtio_transport_reset()
>> >                                                                       virtio_transport_send_pkt_info()
>> >                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
>> >                                                                           queue_work(vsock_loopback_work)
>> >
>> >                                                               vsock_loopback_work()
>> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
>> > 								   virtio_transport_recv_disconnecting()
>> > 								     virtio_transport_do_close()
>> > 								       vsock_stream_has_data()
>> > 								         vsk->transport->stream_has_data(vsk);    // null-ptr-deref
>> >
>> > To resolve this issue, add a check for vsk->transport, similar to
>> > functions like vsock_send_shutdown().
>> >
>> > Fixes: fe502c4a38d9 ("vsock: add 'transport' member in the struct vsock_sock")
>> > Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
>> > Signed-off-by: Wongi Lee <qwerty@theori.io>
>> > ---
>> > net/vmw_vsock/af_vsock.c | 3 +++
>> > 1 file changed, 3 insertions(+)
>> >
>> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> > index 5cf8109f672a..a0c008626798 100644
>> > --- a/net/vmw_vsock/af_vsock.c
>> > +++ b/net/vmw_vsock/af_vsock.c
>> > @@ -870,6 +870,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
>> >
>> > s64 vsock_stream_has_data(struct vsock_sock *vsk)
>> > {
>> > +	if (!vsk->transport)
>> > +		return 0;
>> > +
>>
>> I understand that this alleviates the problem, but IMO it is not the right
>> solution. We should understand why we're still processing the packet in the
>> context of this socket if it's no longer assigned to the right transport.
>
>Got it. I agree with you.
>
>>
>> Maybe we can try to improve virtio_transport_recv_pkt() and check if the
>> vsk->transport is what we expect, I mean something like this (untested):
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 9acc13ab3f82..18b91149a62e 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>>
>>         lock_sock(sk);
>>
>> -       /* Check if sk has been closed before lock_sock */
>> -       if (sock_flag(sk, SOCK_DONE)) {
>> +       /* Check if sk has been closed or assigned to another transport before
>> +        * lock_sock
>> +        */
>> +       if (sock_flag(sk, SOCK_DONE) || vsk->transport != t) {
>>                 (void)virtio_transport_reset_no_sock(t, skb);
>>                 release_sock(sk);
>>                 sock_put(sk);
>>
>> BTW I'm not sure it is the best solution, we have to check that we do not
>> introduce strange cases, but IMHO we have to solve the problem earlier in
>> virtio_transport_recv_pkt().
>
>At least for vsock_loopback.c, this change doesn’t seem to introduce any
>particular issues.

But was it working for you? because the check was wrong, this one should 
work, but still, I didn't have time to test it properly, I'll do later.

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9acc13ab3f82..ddecf6e430d6 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
  
         lock_sock(sk);
  
-       /* Check if sk has been closed before lock_sock */
-       if (sock_flag(sk, SOCK_DONE)) {
+       /* Check if sk has been closed or assigned to another transport before
+        * lock_sock
+        */
+       if (sock_flag(sk, SOCK_DONE) || vsk->transport != &t->transport) {
                 (void)virtio_transport_reset_no_sock(t, skb);
                 release_sock(sk);
                 sock_put(sk);

>
>And separately, I think applying the vsock_stream_has_data patch would help
>prevent potential issues that could arise when vsock_stream_has_data is
>called somewhere.

Not sure, with that check, we wouldn't have seen this problem we had, so 
either add an error, but mute it like this I don't think is a good idea, 
also because the same function is used in a hot path, so an extra check 
could affect performance (not much honestly in this case, but adding it 
anywhere could).

Thanks,
Stefano

>
>>
>> Thanks,
>> Stefano
>>
>> > 	return vsk->transport->stream_has_data(vsk);
>> > }
>> > EXPORT_SYMBOL_GPL(vsock_stream_has_data);
>> > --
>> > 2.34.1
>> >
>>
>


