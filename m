Return-Path: <netdev+bounces-198101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EC4ADB40B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE971885C2D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851641FE474;
	Mon, 16 Jun 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHaLbvPm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80519E97A
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084681; cv=none; b=phhKKW5/LpkrUNn/Oi6e9drkzGEEHrAwD6gDHLXxYeCeMfmrLDfAhF1G59qew+/miaQA2NfLXKhA2vfQhfFOI28CiUgRjEhPqdSTc0rfWY3iuX8s6qbVeiJBqkGTR8ncwTaEhv8qS7vdzrqviLJbWwgaT4Xd/1aYs6+e4ln1Ct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084681; c=relaxed/simple;
	bh=+3V6B07QTgyLvlLajJHsodKxoaoAvMotU0ldSwXhncI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJKSLnCjXupORDuQFEUbIkR2pR9wYUMo2q+xg6hSkbyu98bGU9qnzIUr2DNiah72yTtWdnDiWBND7llbZSTTW4qs1487TCYoyfn/nurhom1+lgHoXETHvmpK2lC3IOQXq3JiiaxIxIjobNWGF3xSb1BaXxMkMK72q/kx7ldVQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHaLbvPm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750084678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5PZUl5rScpx6w7U6u3JWeOhrswycFFkkuG/yAlkmmYU=;
	b=dHaLbvPm7g9VM4a56hODAH5hSPiR/mMaNwRJF8CNEDhwLdiHvWnB6cxEfTilBbIrWY+oNZ
	5k7S3uCwgXAbt5wwXIWTG1YeqQnwNuzXNHQm7GbOhw9npYhg4Mot1A4JYNBSpe6pRkwFKi
	lH4eRydGcshczNA7Qjz0dwwjkqgK7Qg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-YYPgduilNsKQNSKS0A50Rg-1; Mon, 16 Jun 2025 10:37:57 -0400
X-MC-Unique: YYPgduilNsKQNSKS0A50Rg-1
X-Mimecast-MFC-AGG-ID: YYPgduilNsKQNSKS0A50Rg_1750084675
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so2957309f8f.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 07:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084675; x=1750689475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PZUl5rScpx6w7U6u3JWeOhrswycFFkkuG/yAlkmmYU=;
        b=U8dai6qJpT9cX3X5B11boz6kbewyPWEt5Sb80V6LD/f0dKdUeieK84zTY3GsHMmeBv
         CfHabeLRB+nm2dClxxL2ViStHN9FOE0hsimKjgU8VBlIVGF1WGrhwixe7zSlsle7FczH
         RsIsL5dAc0x2fP4UYZXJD3A0DaSVkBE+f5sehffq0vQtniZQT5WMxiEkZ1hHBpsndpJv
         6S7EPhhLAOlS0mHAEq4rxPs2CpfgSO5yLMWjSeXedAtgcM4YFVKg77t2Hpopb0MBdCjT
         wah4DUyq657eKVIOl347pzxDNbvZbtNXUrZ8MBrEqHhS1F3AmFgIkvHCW4Ig6VJHhknS
         mz8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVahMRhjdYVm7NqqMvEFkailg6k7Jd7LXPOhGQJMiLj4+uytPlyYbL/UsuHvMGsAXN+qvKwr34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiHVZNYpvymWn8XjvEzGpRBKpWJD9bCo100e8E6HlK/LdNpjXi
	TNaSntNUc4GClaJZLJbqO9eI2TumNQs+/DWndkspfZEJHGyTZdvGG8Kt3WZRb/Z3lQbIAO6KVx+
	t778/XbwxqmU+HCKseNIpj2gABUq+Kl7hNQrQTHa/xf71KIkhpNGIztbSGw==
X-Gm-Gg: ASbGncuuNs63bbohmEho4zuWPZ3D1gZ+0AGf0Isu3OXsqvtHnYUUlUSxu7Z+T+upwYh
	GkTgkF0WPmnLDXehn4GXpxlLFCT7jsJLe+qzIgOJ6igLSGOjGR2SpG29mp7kgYJ4IDxdZnauGYn
	JQuLeKJBplhaObzEhAaA2Bqk0iavlOwIJdcnFb/3OitgqczdO+LNqDClL3pXtNI5JdGJd40mAQn
	+2LQsKm7VmfKybpoE7Hrb3qH4wapPkEgfeVmKef+DTCvUuJv2BqN6TeoP/eatZ4v2xG07N+Ea1m
	tmabHLx7k5p3JybvSkgpZylEjD8=
X-Received: by 2002:a05:6000:26c3:b0:3a5:2ec5:35a3 with SMTP id ffacd0b85a97d-3a5723af286mr7290026f8f.45.1750084674949;
        Mon, 16 Jun 2025 07:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGal1F7mRxYYjQyfGOqBANwAZxzO8A0ZW64lk9iUjS0uj3llkb1LfY2b4pbZLKU1OZDRyo3lQ==
X-Received: by 2002:a05:6000:26c3:b0:3a5:2ec5:35a3 with SMTP id ffacd0b85a97d-3a5723af286mr7290002f8f.45.1750084674388;
        Mon, 16 Jun 2025 07:37:54 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.202.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2449f1sm150540045e9.23.2025.06.16.07.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:37:53 -0700 (PDT)
Date: Mon, 16 Jun 2025 16:37:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: davem@davemloft.net, fupan.lfp@antgroup.com, jasowang@redhat.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, niuxuewei.nxw@antgroup.com, pabeni@redhat.com, 
	stefanha@redhat.com, virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v2 1/3] vsock: Add support for SIOCINQ ioctl
Message-ID: <2krp5lm4n5nl24hnlp3cx57gqt5sqw6vagtkipviipxf6xdpsd@bspxnwv6hkfd>
References: <xshb6hrotqilacvkemcraz3xdqcdhuxp3co6u3jz3heea3sxfi@eeys5zdpcfxb>
 <20250616142822.1183736-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250616142822.1183736-1-niuxuewei.nxw@antgroup.com>

On Mon, Jun 16, 2025 at 10:28:22PM +0800, Xuewei Niu wrote:
>> On Fri, Jun 13, 2025 at 11:11:50AM +0800, Xuewei Niu wrote:
>> >This patch adds support for SIOCINQ ioctl, which returns the number of
>> >bytes unread in the socket.
>> >
>> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>> >---
>> > include/net/af_vsock.h   |  2 ++
>> > net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
>> > 2 files changed, 24 insertions(+)
>> >
>> >diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> >index d56e6e135158..723a886253ba 100644
>> >--- a/include/net/af_vsock.h
>> >+++ b/include/net/af_vsock.h
>> >@@ -171,6 +171,8 @@ struct vsock_transport {
>> >
>> > 	/* SIOCOUTQ ioctl */
>> > 	ssize_t (*unsent_bytes)(struct vsock_sock *vsk);
>> >+	/* SIOCINQ ioctl */
>> >+	ssize_t (*unread_bytes)(struct vsock_sock *vsk);
>>
>> Instead of adding a new callback, can we just use
>> `vsock_stream_has_data()` ?
>>
>> Maybe adjusting it or changing something in the transports, but for
>> virtio-vsock, it seems to me it does exactly what the new
>> `virtio_transport_unread_bytes()` does, right?
>
>Sorry, I forgot to update this.

Don't worry.

>
>I am curious that is there a plan to implement dgram support in
>virtio-vsock? If yes, adding a new callback is the right way to go. I
>deadly hope to see that feature. If no, will do in the next.

I don't know the status, there were folks working on it, but I didn't 
see updates.

IMO we can deal with it later, since also this patch will not work as it 
is with datagram since you're checking if the socket is "connectible" 
and also a state. And maybe we also need some 
"vsock_datagram_has_data()" anyway, so let's do this when we will have 
the support. For now let's reuse what we have as much as we can.

Thanks.
Stefano

>
>Thanks,
>Xuewei
>
>> Thanks,
>> Stefano
>>
>> >
>> > 	/* Shutdown. */
>> > 	int (*shutdown)(struct vsock_sock *, int);
>> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> >index 2e7a3034e965..466b1ebadbbc 100644
>> >--- a/net/vmw_vsock/af_vsock.c
>> >+++ b/net/vmw_vsock/af_vsock.c
>> >@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
>> > 	vsk = vsock_sk(sk);
>> >
>> > 	switch (cmd) {
>> >+	case SIOCINQ: {
>> >+		ssize_t n_bytes;
>> >+
>> >+		if (!vsk->transport || !vsk->transport->unread_bytes) {
>> >+			ret = -EOPNOTSUPP;
>> >+			break;
>> >+		}
>> >+
>> >+		if (sock_type_connectible(sk->sk_type) &&
>> >+		    sk->sk_state == TCP_LISTEN) {
>> >+			ret = -EINVAL;
>> >+			break;
>> >+		}
>> >+
>> >+		n_bytes = vsk->transport->unread_bytes(vsk);
>> >+		if (n_bytes < 0) {
>> >+			ret = n_bytes;
>> >+			break;
>> >+		}
>> >+		ret = put_user(n_bytes, arg);
>> >+		break;
>> >+	}
>> > 	case SIOCOUTQ: {
>> > 		ssize_t n_bytes;
>> >
>> >--
>> >2.34.1
>> >
>


